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

      // FIXME: For debugging purpose
      print('limit: ' + limit.toString());
      print('startAfter: ' +
          (startAfter != null ? startAfter.toIso8601String() : 'null'));
      print('customerName: ' + customerName.toString());

      // Init variable query
      Query query = _transactions.orderBy('tanggal_buat', descending: true);

      // StartAfter filter
      if (startAfter != null)
        query = query.startAfter(
          [startAfter.toIso8601String()],
        );

      // Where filter
      if (customerName != null && customerName != '')
        query = query.where(
          'nama_pelanggan',
          isEqualTo: customerName,
        );

      query = query.limit(limit);

      // Get data from document
      QuerySnapshot querySnapshot = await query.get();

      // Init varialble list transaction
      List<model.Transaction> transactions = [];

      // Save to local database
      querySnapshot.docs.forEach((doc) {
        transactions.add(model.Transaction.fromJson(doc.data()));
      });

      // FIXME: For debugging purpose
      print('first data: ' +
          (transactions.length <= 0 ? 'null' : transactions[0].customerName));

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
