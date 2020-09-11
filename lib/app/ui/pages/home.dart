import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:laundry/app/ui/components/custom_app_bar.dart';
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
          padding: EdgeInsets.all(
            GlobalData.COMPONENT_MARGIN_PADDING,
          ),
          child: FutureBuilder(
            // Initialize FlutterFire:
            future: _initialization,
            builder: (context, snapshot) {
              // Check for errors
              if (snapshot.hasError) {
                return Text('Error');
              }

              // Once complete, show your application
              if (snapshot.connectionState == ConnectionState.done) {
                return Text('Its works');
              }

              // Otherwise, show something whilst waiting for initialization to complete
              return Text('Loading');
            },
          ),
        ),
      ),
    );
  }
}
