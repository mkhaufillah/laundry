import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry/app/models/transaction.dart';
import 'package:laundry/app/resources/repository.dart';
import 'package:laundry/global_data.dart';

/// Define parameter class for get transaction bloc
/// This class contain callback function
class GetTransactionBlocParams {
  final BuildContext context;

  GetTransactionBlocParams({@required this.context});
}

/// Define results class for get transaction bloc
class GetTransactionBlocResults {
  final List<Transaction> transactions;
  final GlobalStreamStatus status;

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

      // Use Stale-While-Revalidate cache strategy
      // Stale from cache
      List<Transaction> transactions = await repo.transaction.getFromCache();
      // if length of transactions <= 0, direct get data from network
      if (transactions.length > 0) {
        yield GetTransactionBlocResults(
          transactions: transactions,
          status: GlobalStreamStatus.SUCCESS,
        );
      }

      // Revalidate cache with data from network
      yield GetTransactionBlocResults(
        transactions: await repo.transaction.getFromNetwork(),
        status: GlobalStreamStatus.SUCCESS,
      );
    } catch (e) {
      // Stream error
      yield GetTransactionBlocResults(
        transactions: [],
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
