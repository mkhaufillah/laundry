import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:laundry/app/models/transaction.dart';
import 'package:laundry/app/resources/repository.dart';
import 'package:laundry/global_data.dart';

/// Define params class for get transaction bloc
class GetTransactionBlocParams {
  DateTime startAfter;
  String customerName;
  Function callback;

  GetTransactionBlocParams({
    this.startAfter,
    this.customerName,
    this.callback,
  });
}

/// Define results class for get transaction bloc
class GetTransactionBlocResults {
  List<Transaction> transactions;
  GlobalStreamStatus status;

  GetTransactionBlocResults({
    @required this.transactions,
    @required this.status,
  });
}

/// This is main bloc class with params and result
class GetTransactionBloc
    extends Bloc<GetTransactionBlocParams, GetTransactionBlocResults> {
  GetTransactionBloc(GetTransactionBlocResults initialState)
      : super(initialState);

  @override
  Stream<GetTransactionBlocResults> mapEventToState(
      GetTransactionBlocParams params) async* {
    try {
      Repository repo = Repository();

      // Stream loading
      yield GetTransactionBlocResults(
        transactions: [],
        status: GlobalStreamStatus.LOADING,
      );

      // Get data from resource
      yield GetTransactionBlocResults(
        transactions: await repo.transaction.get(
          startAfter: params.startAfter,
          customerName: params.customerName,
        ),
        status: GlobalStreamStatus.SUCCESS,
      );

      if (params.callback != null) params.callback();
    } catch (e) {
      // Stream error
      yield GetTransactionBlocResults(
        transactions: [],
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
