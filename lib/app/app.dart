import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:laundry/app/ui/pages/home.dart';
import 'package:laundry/global_data.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // Define all blocs
      providers: <BlocProvider>[],
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
          accentColorBrightness: Brightness.dark,
          fontFamily: 'Poppins',
          appBarTheme: AppBarTheme(
            elevation: 0.0,
            color: GlobalData.BACKGROUND_COLOR,
          ),
        ),
        // Building navigations
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => Home(),
          ),
        ],
      ),
    );
  }
}
