import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry/app/models/transaction.dart';
import 'package:laundry/app/ui/components/custom_app_bar.dart';
import 'package:laundry/global_data.dart';

class ShowTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Transaction transaction = Get.arguments as Transaction;

    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'Detail Transaksi'),
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
              transaction.services.length != 0
                  ? Container(
                      margin: EdgeInsets.only(
                        bottom: GlobalData.COMPONENT_MARGIN_PADDING,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          GlobalData.BORDER_RADIUS,
                        ),
                        color: GlobalData.GREY_LIGHT_COLOR,
                      ),
                      child: Wrap(
                        children: transaction.services.map((e) {
                          return ListTile(
                            leading: Icon(
                              Icons.local_laundry_service,
                              color: GlobalData.PRIMARY_COLOR,
                            ),
                            title: Text(
                              e.serviceName,
                              style: TextStyle(
                                color: GlobalData.PRIMARY_COLOR,
                              ),
                            ),
                            subtitle: RichText(
                              text: TextSpan(
                                text: 'Total harga ',
                                style: TextStyle(
                                  color: GlobalData.FOREGROUND_COLOR,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                        '${e.priceTotal.parseToIdrCurrency()}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: GlobalData.FOREGROUND_COLOR,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : Container(),
              _listItemTransaction(
                title: 'Tanggal Pembuatan',
                subtitle: DateFormat.yMMMMd().format(transaction.createdDate),
              ),
              _listItemTransaction(
                title: 'Tanggal Selesai',
                subtitle: DateFormat.yMMMMd().format(transaction.finishedDate),
              ),
              _listItemTransaction(
                title: 'Keterangan',
                subtitle: transaction.additionalInfo == null ||
                        transaction.additionalInfo == ''
                    ? '-'
                    : transaction.additionalInfo,
              ),
              _listItemTransaction(
                title: 'Total Tagihan',
                subtitle: transaction.billTotal.parseToIdrCurrency(),
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
