import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:laundry/app/blocs/get_service_bloc.dart';
import 'package:laundry/app/blocs/get_transaction_bloc.dart';
import 'package:laundry/app/blocs/save_transaction_bloc.dart';
import 'package:laundry/app/models/service.dart';
import 'package:laundry/app/models/transaction.dart';
import 'package:laundry/app/ui/pages/home.dart';
import 'package:laundry/app/ui/pages/input_transaction.dart';
import 'package:laundry/app/ui/pages/review_transaction.dart';
import 'package:laundry/global_data.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scope with try catch to avoid error duplicate key in local database
    try {
      // register local database
      Hive.registerAdapter(ServiceAdapter());
      Hive.registerAdapter(TransactionAdapter());
    } catch (_e) {}

    return MultiBlocProvider(
      // Define all blocs
      providers: <BlocProvider>[
        // Get service bloc
        BlocProvider<GetServiceBloc>(
          create: (context) => GetServiceBloc(
            GetServiceBlocResults(
              services: [],
              status: GlobalStreamStatus.INITIALIZED,
            ),
          ),
        ),
        // Get transaction bloc
        BlocProvider<GetTransactionBloc>(
          create: (context) => GetTransactionBloc(
            GetTransactionBlocResults(
              transactions: [],
              status: GlobalStreamStatus.INITIALIZED,
            ),
          ),
        ),
        // Save transaction bloc
        BlocProvider<SaveTransactionBloc>(
          create: (context) => SaveTransactionBloc(
            SaveTransactionBlocResults(
              transactions: [],
              status: GlobalStreamStatus.INITIALIZED,
            ),
          ),
        ),
      ],
      // Building UI
      child: GetMaterialApp(
        title: 'Laundry POS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: GlobalData.PRIMARY_COLOR,
          accentColor: GlobalData.ACCENT_COLOR,
          backgroundColor: GlobalData.BACKGROUND_COLOR,
          errorColor: GlobalData.ERROR_COLOR,
          brightness: Brightness.light,
          primaryColorBrightness: Brightness.dark,
          accentColorBrightness: Brightness.light,
          fontFamily: 'Poppins',
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            color: GlobalData.BACKGROUND_COLOR,
            brightness: Brightness.light,
          ),
        ),
        // Building navigations
        initialRoute: '/home',
        getPages: [
          GetPage(
            name: '/home',
            page: () => Home(),
          ),
          GetPage(
            name: '/input-transaction',
            page: () => InputTransaction(),
          ),
          GetPage(
            name: '/review-transaction',
            page: () => ReviewTransaction(),
          ),
          GetPage(
            name: '/transaction-success',
            page: () => Home(),
          ),
          GetPage(
            name: '/list-transaction',
            page: () => Home(),
          ),
        ],
      ),
    );
  }
}
