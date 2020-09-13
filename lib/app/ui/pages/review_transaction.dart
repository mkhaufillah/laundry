import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry/app/blocs/save_transaction_bloc.dart';
import 'package:laundry/app/models/transaction.dart';
import 'package:laundry/app/ui/components/custom_app_bar.dart';
import 'package:laundry/app/ui/components/custom_button.dart';
import 'package:laundry/global_data.dart';

class ReviewTransaction extends StatefulWidget {
  @override
  _ReviewTransactionState createState() => _ReviewTransactionState();
}

class _ReviewTransactionState extends State<ReviewTransaction> {
  // Define bloc to save transaction
  SaveTransactionBloc _saveTransactionBloc;

  Transaction _transaction;

  @override
  void initState() {
    _saveTransactionBloc = BlocProvider.of<SaveTransactionBloc>(context);
    _transaction = Get.arguments as Transaction;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'Review Transaksi'),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(GlobalData.BODY_MARGIN_PADDING),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _listItemTransaction(
                    title: 'Nama Pelanggan',
                    subtitle: _transaction.customerName,
                  ),
                  _transaction.services.length != 0
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
                            children: _transaction.services.map((e) {
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
                                    text: '${e.buyQty} ${e.unitName} ',
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
                    subtitle:
                        DateFormat.yMMMMd().format(_transaction.createdDate),
                  ),
                  _listItemTransaction(
                    title: 'Tanggal Selesai',
                    subtitle:
                        DateFormat.yMMMMd().format(_transaction.finishedDate),
                  ),
                  _listItemTransaction(
                    title: 'Keterangan',
                    subtitle: _transaction.additionalInfo == null ||
                            _transaction.additionalInfo == ''
                        ? '-'
                        : _transaction.additionalInfo,
                  ),
                  _listItemTransaction(
                    title: 'Total Tagihan',
                    subtitle: _transaction.billTotal.parseToIdrCurrency(),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(GlobalData.BODY_MARGIN_PADDING),
              child:
                  BlocBuilder<SaveTransactionBloc, SaveTransactionBlocResults>(
                      builder: (context, snapshot) {
                // Set loading state
                CustomButtonType type = CustomButtonType.ACCENT;
                Function onPressed = () {
                  _saveTransactionBloc.add(
                    SaveTransactionBlocParams(
                        transaction: _transaction,
                        callback: () {
                          Get.offAllNamed('/transaction-success');
                        }),
                  );
                };

                if (snapshot.status == GlobalStreamStatus.LOADING) {
                  type = CustomButtonType.LOADING;
                  onPressed = () {};
                }

                // default send
                return CustomButton(
                  size: CustomButtonSize.BIG,
                  type: type,
                  text: 'Simpan Transaksi',
                  onPressed: onPressed,
                );
              }),
            ),
          ],
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
