import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:laundry/app/models/service.dart';
import 'package:laundry/app/resources/repository.dart';
import 'package:laundry/global_data.dart';

/// Define parameter class for get service bloc
class GetServiceBlocParams {
  final String query;
  final List<Service> services;

  GetServiceBlocParams({
    this.query,
    this.services,
  });
}

/// Define results class for get service bloc
class GetServiceBlocResults {
  final List<Service> services;
  final GlobalStreamStatus status;

  GetServiceBlocResults({
    @required this.services,
    @required this.status,
  });
}

/// This is main bloc class with params and result
class GetServiceBloc extends Bloc<GetServiceBlocParams, GetServiceBlocResults> {
  GetServiceBloc(GetServiceBlocResults initialState) : super(initialState);

  @override
  Stream<GetServiceBlocResults> mapEventToState(
      GetServiceBlocParams params) async* {
    try {
      Repository repo = Repository();

      // Stream loading
      yield GetServiceBlocResults(
        services: [],
        status: GlobalStreamStatus.LOADING,
      );

      // Search
      if (params.query != null && params.services != null) {
        List<Service> searched = [];
        List<Service> unsearched = [];
        params.services.forEach((element) {
          if (element.name.toLowerCase().contains(params.query.toLowerCase())) {
            element.isSearched = true;
            searched.add(element);
          } else {
            element.isSearched = false;
            unsearched.add(element);
          }
        });
        yield GetServiceBlocResults(
          services: [...searched, ...unsearched],
          status: GlobalStreamStatus.SUCCESS,
        );
        return;
      }

      // Use Stale-While-Revalidate cache strategy
      // Stale from cache
      List<Service> services = await repo.service.getFromCache();
      // if length of services <= 0, direct get data from network
      if (services.length > 0) {
        yield GetServiceBlocResults(
          services: services,
          status: GlobalStreamStatus.SUCCESS,
        );
      }

      // Revalidate cache with data from network
      yield GetServiceBlocResults(
        services: await repo.service.getFromNetwork(),
        status: GlobalStreamStatus.SUCCESS,
      );
    } catch (e) {
      // Stream error
      yield GetServiceBlocResults(
        services: [],
        status: GlobalStreamStatus.FAILED,
      );

      // Send error notify to user
      Get.snackbar(
        'Opps...',
        e.toString(),
        borderRadius: GlobalData.BORDER_RADIUS,
        margin: EdgeInsets.all(GlobalData.BODY_MARGIN_PADDING),
        backgroundColor: GlobalData.ERROR_COLOR,
        colorText: GlobalData.BACKGROUND_COLOR,
      );
    }
  }
}
