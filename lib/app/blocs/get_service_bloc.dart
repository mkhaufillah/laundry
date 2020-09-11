import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/app/models/service.dart';
import 'package:laundry/app/resources/repository.dart';
import 'package:laundry/global_data.dart';

/// Define parameter class for get service bloc
/// This class contain callback function
class GetServiceBlocParams {
  final BuildContext context;

  GetServiceBlocParams({@required this.context});
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
      Flushbar(
        borderRadius: GlobalData.BORDER_RADIUS,
        margin: EdgeInsets.all(GlobalData.BODY_MARGIN_PADDING),
        title: 'Opps...',
        message: e.toString(),
        backgroundColor: GlobalData.ERROR_COLOR,
        isDismissible: true,
        duration: Duration(seconds: 6),
      ).show(params.context);
    }
  }
}
