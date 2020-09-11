import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:laundry/app/models/transaction.dart';
import 'package:laundry/app/resources/repository.dart';
import 'package:laundry/global_data.dart';

/// Define parameter class for save transaction bloc
/// This class contain callback function
class SaveTransactionBlocParams {
  final Transaction transaction;

  SaveTransactionBlocParams({
    @required this.transaction,
  });
}

/// Define results class for save transaction bloc
class SaveTransactionBlocResults {
  final List<Transaction> transactions;
  final GlobalStreamStatus status;

  SaveTransactionBlocResults({
    @required this.transactions,
    @required this.status,
  });
}

/// This is main bloc class with params and result
class SaveTransactionBloc
    extends Bloc<SaveTransactionBlocParams, SaveTransactionBlocResults> {
  SaveTransactionBloc(SaveTransactionBlocResults initialState)
      : super(initialState);

  @override
  Stream<SaveTransactionBlocResults> mapEventToState(
      SaveTransactionBlocParams params) async* {
    try {
      Repository repo = Repository();

      // Stream loading
      yield SaveTransactionBlocResults(
        transactions: [],
        status: GlobalStreamStatus.LOADING,
      );

      // Save data
      yield SaveTransactionBlocResults(
        transactions: await repo.transaction.save(
          transaction: params.transaction,
        ),
        status: GlobalStreamStatus.SUCCESS,
      );
    } catch (e) {
      // Stream error
      yield SaveTransactionBlocResults(
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
