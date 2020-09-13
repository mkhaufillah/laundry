import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laundry/app/models/transaction.dart' as model;

class TransactionProvider {
  final CollectionReference _transactions =
      FirebaseFirestore.instance.collection('transactions');

  Future<List<model.Transaction>> get({
    String customerName,
    DateTime startAfter,
  }) async {
    try {
      // Limit
      int limit = 10;

      // Init variable query
      Query query =
          _transactions.orderBy('tanggal_buat', descending: true).limit(limit);

      // StartAfter filter
      if (startAfter != null) query = query.startAfter([startAfter]);

      if (customerName != null && customerName != '')
        query = query.where(customerName);

      // Get data from document
      QuerySnapshot querySnapshot = await query.get();

      // Init varialble list transaction
      List<model.Transaction> transactions = [];

      // Save to local database
      querySnapshot.docs.forEach((doc) {
        transactions.add(model.Transaction.fromJson(doc.data()));
      });

      // Stream updated data
      return transactions;
    } catch (e) {
      // For debugging detailed error
      print(e);

      // Throw simple error to friendly UX
      throw 'Jaringan bermasalah, silahkan periksa koneksi internet anda.';
    }
  }

  Future<model.Transaction> save({
    @required model.Transaction transaction,
  }) async {
    try {
      // post to firebase
      await _transactions.add(transaction.toJson());

      // return local data
      return transaction;
    } catch (e) {
      // For debugging detailed error
      print(e);

      // Throw simple error to friendly UX
      throw 'Jaringan bermasalah, silahkan periksa koneksi internet anda.';
    }
  }
}
