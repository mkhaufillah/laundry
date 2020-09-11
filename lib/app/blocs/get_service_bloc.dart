import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Define parameter class for get service bloc
/// This class contain callback function
class GetServiceBlocParams {
  final Function(String) onError;
  final Function(GetServiceBlocResults) onSuccess;

  GetServiceBlocParams({@required this.onError, @required this.onSuccess});
}

/// Define results class for get service bloc
class GetServiceBlocResults {
  // TODO: Define result model for get service bloc
}

/// This is main bloc class with params and result
class GetServiceBloc extends Bloc<GetServiceBlocParams, GetServiceBlocResults> {
  GetServiceBloc(GetServiceBlocResults initialState) : super(initialState);

  @override
  Stream<GetServiceBlocResults> mapEventToState(
      GetServiceBlocParams params) async* {
    try {
      // TODO: Build get service bloc
    } catch (e) {
      // Send error notify to user
      params.onError(e.toString());
    }
  }
}
