import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:laundry/app/ui/components/card_home_menu.dart';
import 'package:laundry/app/ui/components/custom_app_bar.dart';
import 'package:laundry/app/ui/components/error_page.dart';
import 'package:laundry/app/ui/components/loading_page.dart';
import 'package:laundry/global_data.dart';

class Home extends StatelessWidget {
  // Create the initilization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'Laundry POS'),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            // Initialize FlutterFire:
            future: _initialization,
            builder: (context, snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                return ErrorPage();
              }

              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                return _home(context);
              }

              // Otherwise, show something whilst waiting for initialization to complete
              return LoadingPage();
            },
          ),
        ),
      ),
    );
  }

  Widget _home(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      padding: EdgeInsets.all(GlobalData.BODY_MARGIN_PADDING),
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(
                GlobalData.COMPONENT_MARGIN_PADDING * 2,
              ),
            ),
            SvgPicture.asset(
              'assets/images/calculator.svg',
              semanticsLabel: 'Error Load Data',
              alignment: Alignment.center,
              width: width * 0.5,
            ),
            Padding(
              padding: EdgeInsets.all(
                GlobalData.COMPONENT_MARGIN_PADDING * 2,
              ),
            ),
            CardHomeMenu(
              icon: Icons.note_add,
              onTap: () {
                Get.toNamed('/input-transaction');
              },
              subtitle:
                  'Kamu bisa melakukan pencatatan transaksi dan menyimpannya.',
              title: 'Masukkan Transaksi',
            ),
            CardHomeMenu(
              icon: Icons.view_list,
              onTap: () {
                Get.toNamed('/list-transaction');
              },
              subtitle:
                  'Kamu bisa melihat semua catatan transaksi yang tersimpan.',
              title: 'Daftar Transaksi',
            ),
          ],
        ),
      ),
    );
  }
}
