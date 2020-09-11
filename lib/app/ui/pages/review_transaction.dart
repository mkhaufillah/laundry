import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laundry/app/models/transaction.dart';
import 'package:laundry/app/ui/components/custom_app_bar.dart';
import 'package:laundry/global_data.dart';

class ReviewTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Transaction transaction = Get.arguments as Transaction;
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'Review Transaksi'),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(GlobalData.BODY_MARGIN_PADDING),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _listItemTransaction(
                title: 'Nama Pelanggan',
                subtitle: transaction.customerName,
              ),
              _listItemTransaction(
                title: 'Layanan yang Dipilih',
                subtitle: transaction.service.name,
              ),
              _listItemTransaction(
                title: 'Kuantitas',
                subtitle: transaction.quantity.toString(),
              ),
              _listItemTransaction(
                title: 'Tanggal Pembuatan',
                subtitle: transaction.createdDate.toString(),
              ),
              _listItemTransaction(
                title: 'Tanggal Selesai',
                subtitle: transaction.finishedDate.toString(),
              ),
              _listItemTransaction(
                title: 'Keterangan',
                subtitle: transaction.additionalInfo,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItemTransaction({
    @required String title,
    @required String subtitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(
          subtitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(GlobalData.COMPONENT_MARGIN_PADDING / 2),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(
              width: 1,
              color: GlobalData.GREY_COLOR,
            ),
          )),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(GlobalData.COMPONENT_MARGIN_PADDING / 2),
        ),
      ],
    );
  }
}
