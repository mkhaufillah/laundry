import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:laundry/app/models/service.dart';
import 'package:laundry/global_data.dart';

class ServiceProvider {
  final String _boxName = 'services';

  Future<List<Service>> getFromCache() async {
    try {
      // Open local database
      var box = await Hive.openBox<Service>(_boxName);

      // Return data from local database
      return box.values;
    } catch (e) {
      // For debugging detailed error
      print(e);

      // Throw simple error to friendly UX
      throw 'Jaringan bermasalah, silahkan periksa koneksi internet anda.';
    }
  }

  Future<List<Service>> getFromNetwork() async {
    try {
      // Create map body request
      Map<String, dynamic> body = {
        'jwt': GlobalData.JWT,
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

      // Revalidate cache if status server code == 200
      if (response.statusCode == 200) {
        // Open local database
        var box = await Hive.openBox<Service>(_boxName);

        // Delete local data
        box.deleteAll(box.values);

        // Save to local database
        json.decode(response.body)['data'].forEach((element) {
          box.add(Service.fromJson(element));
        });

        // Stream updated data
        return box.values;
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
