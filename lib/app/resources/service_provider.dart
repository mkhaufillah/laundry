import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:laundry/app/models/service.dart';
import 'package:laundry/global_data.dart';

class ServiceProvider {
  Future<List<Service>> get({
    @required String q,
    @required int page,
  }) async {
    try {
      // Generate limit & offset
      page = page < 1 ? 1 : page;
      int limit = 10;
      int offset = limit * (page - 1);

      // FIXME: For debugging purpose
      print('page: ' + page.toString());
      print('limit: ' + limit.toString());
      print('offset: ' + offset.toString());
      print('q: ' + q.toString());

      /// FIXME: Bugs in API
      /// In indonesia language
      ///
      /// Karena pada API request dengan paramenter "q" dan "offset"
      /// tidak bekerja (hanya parameter limit yang bekerja)
      /// maka, dilakuka pagination offline dan search offline untuk sementara
      /// sampai dengan bugs diperbaiki.
      /// Sehingga JWT saat ini hanya digunakan untuk akses API bukan untuk klaim parameter q dan offset

      // Create JWT claim
      JwtClaim claimSet = new JwtClaim(otherClaims: <String, dynamic>{
        // FIXME: Bugs in API
        // In indonesia language
        //
        // Karena yang bisa hanya limit maka limit sementara dibuat maksimal
        'q': q,
        'limit': double.maxFinite.round(), // max limit
        'offset': offset,
      }, maxAge: const Duration(minutes: 5));

      // Create JWT signature
      String jwt = issueJwtHS256(claimSet, GlobalData.JWT_KEY);

      // Create map body request
      Map<String, dynamic> body = {
        'jwt': jwt,
      };

      // Generate map body to body url encoded
      String urlEncodedbody = body.keys
          .map(
            (key) => "$key=${body[key]}",
          )
          .join("&");

      // Send request service to server
      final response = await http.post(
        '${GlobalData.API_URL}/layanan',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: urlEncodedbody,
      );

      // FIXME: For debugging purpose
      print('jwt: ' + jwt);

      // Return data if status server code == 200
      if (response.statusCode == 200) {
        // Create list of service variable
        List<Service> services = [];

        /// FIXME: Bugs in API
        /// In indonesia language
        ///
        /// Karena pada API request dengan paramenter "q" dan "offset"
        /// tidak bekerja (hanya parameter limit yang bekerja)
        /// maka, dilakuka pagination offline dan search offline untuk sementara
        /// sampai dengan bugs diperbaiki.
        /// Sehingga JWT saat ini hanya digunakan untuk akses API bukan untuk klaim parameter q dan offset

        // FIXME: Bugs in API
        // Mapping with offline search and pagination
        int i = 0;
        json.decode(response.body).forEach((element) {
          Service service = Service.fromJson(element);
          if (service.serviceName.toLowerCase().contains(q.toLowerCase())) {
            if (i >= offset && i < limit * page) services.add(service);
            i++;
          }
        });

        // FIXME: Bugs in API
        // Mapping service with default behavior (API fixed)
        // json.decode(response.body).forEach((element) {
        //   services.add(Service.fromJson(element));
        // });

        // FIXME: For debugging purpose
        print('first data: ' +
            (services.length <= 0 ? 'null' : services[0].serviceName));

        // Stream updated data
        return services;
      }

      // Throw error if status server code != 200
      throw 'Has error with code: ' + response.statusCode.toString();
    } catch (e) {
      // For debugging detailed error
      print(e);

      // Throw simple error to friendly UX
      throw 'Jaringan bermasalah, silahkan periksa koneksi internet anda.';
    }
  }
}
