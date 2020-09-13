import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:laundry/app/models/service.dart';
import 'package:laundry/app/resources/repository.dart';
import 'package:laundry/global_data.dart';

/// Define parameter class for get service bloc
class GetServiceBlocParams {
  String q;
  int page;
  Function callback;

  GetServiceBlocParams({
    this.q,
    this.page,
    this.callback,
  });
}

/// Define results class for get service bloc
class GetServiceBlocResults {
  List<Service> services;
  GlobalStreamStatus status;

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

      // Filter params
      params.q = params.q == null ? '' : params.q;
      params.page = params.page == null ? 0 : params.page;

      // Get data from resources
      yield GetServiceBlocResults(
        services: await repo.service.get(
          q: params.q,
          page: params.page,
        ),
        status: GlobalStreamStatus.SUCCESS,
      );

      if (params.callback != null) params.callback();
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
