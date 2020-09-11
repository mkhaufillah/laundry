import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:laundry/app/models/transaction.dart' as model;
import 'package:path_provider/path_provider.dart';

class TransactionProvider {
  final String _boxName = 'transactions';
  final CollectionReference _transactions =
      FirebaseFirestore.instance.collection('transactions');

  Future<List<model.Transaction>> getFromCache() async {
    try {
      // Init local database
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      // Open local database
      var box = await Hive.openBox<model.Transaction>(_boxName);

      // Return data from local database
      return box.values.toList();
    } catch (e) {
      // For debugging detailed error
      print(e);

      // Throw simple error to friendly UX
      throw 'Jaringan bermasalah, silahkan periksa koneksi internet anda.';
    }
  }

  Future<List<model.Transaction>> getFromNetwork() async {
    try {
      // Get data from document
      QuerySnapshot querySnapshot = await _transactions.get();

      // Revalidate cache
      // Init local database
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      // Open local database
      var box = await Hive.openBox<model.Transaction>(_boxName);

      // delete local data
      box.deleteAll(box.keys.toList());

      // Save to local database
      querySnapshot.docs.forEach((doc) {
        box.add(model.Transaction.fromJson(doc.data()));
      });

      // Stream updated data
      return box.values.toList();
    } catch (e) {
      // For debugging detailed error
      print(e);

      // Throw simple error to friendly UX
      throw 'Jaringan bermasalah, silahkan periksa koneksi internet anda.';
    }
  }

  Future<List<model.Transaction>> save({
    @required model.Transaction transaction,
  }) async {
    try {
      // post to firebase
      await _transactions.add(transaction.toJson());

      // Init local database
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
      // Open local database
      var box = await Hive.openBox<model.Transaction>(_boxName);

      // Save to local database
      await box.add(transaction);

      // return local data
      return box.values.toList();
    } catch (e) {
      // For debugging detailed error
      print(e);

      // Throw simple error to friendly UX
      throw 'Jaringan bermasalah, silahkan periksa koneksi internet anda.';
    }
  }
}
