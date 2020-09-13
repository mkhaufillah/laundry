import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:laundry/app/models/transaction.dart';
import 'package:laundry/app/models/transaction_service.dart';
import 'package:laundry/app/ui/components/custom_app_bar.dart';
import 'package:laundry/app/ui/components/custom_button.dart';
import 'package:laundry/app/ui/components/custom_input_text.dart';
import 'package:laundry/global_data.dart';

class InputTransaction extends StatefulWidget {
  @override
  _InputTransactionState createState() => _InputTransactionState();
}

class _InputTransactionState extends State<InputTransaction> {
  String _name;
  List<TransactionService> _transactionServices;
  DateTime _createdDate;
  DateTime _finishedDate;
  String _additionalInfo;

  String _idTransaction;

  String _nameErr;

  FocusNode _nameFocus;
  FocusNode _additionalInfoFocus;

  // Find max complete dration in selected service
  int _getMaxDateInListOfTranactionService() {
    int maxCompleteDuration = _transactionServices[0].completeDuration;
    _transactionServices.forEach((element) {
      if (maxCompleteDuration < element.completeDuration)
        maxCompleteDuration = element.completeDuration;
    });
    return maxCompleteDuration;
  }

  @override
  void initState() {
    _transactionServices = [];
    // Generate Id
    _idTransaction = 'TRN' + DateTime.now().millisecondsSinceEpoch.toString();
    _nameFocus = FocusNode();
    _additionalInfoFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'Masukkan Transaksi'),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(GlobalData.BODY_MARGIN_PADDING),
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Input name
                    CustomInputText(
                      focusNode: _nameFocus,
                      onChanged: (e) {
                        setState(() {
                          _nameErr = null;
                        });
                        if (e == null || e == '') {
                          setState(() {
                            _nameErr = 'Tidak boleh kosong';
                          });
                        }
                        setState(() {
                          _name = e;
                        });
                      },
                      label: 'Nama',
                      err: _nameErr,
                      hint: 'Masukkan nama pelanggan',
                      type: TextInputType.name,
                    ),
                    // Show services
                    _transactionServices.length != 0 ? _gap() : Container(),
                    _transactionServices.length != 0
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                GlobalData.BORDER_RADIUS,
                              ),
                              color: GlobalData.GREY_LIGHT_COLOR,
                            ),
                            child: Wrap(
                              children: _transactionServices.map((e) {
                                return ListTile(
                                  leading: Icon(
                                    Icons.local_laundry_service,
                                    color: GlobalData.PRIMARY_COLOR,
                                  ),
                                  title: Text(
                                    e.serviceName,
                                    style: TextStyle(
                                      color: GlobalData.PRIMARY_COLOR,
                                      fontWeight: FontWeight.bold,
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
                    // Input service
                    _gap(),
                    CustomButton(
                      type: CustomButtonType.PRIMARY,
                      text: 'Pilih Layanan',
                      onPressed: () async {
                        _nameFocus.unfocus();
                        _additionalInfoFocus.unfocus();
                        var callbackData = await Get.toNamed(
                          '/list-service',
                          arguments: _idTransaction,
                        );
                        if ((callbackData as List<TransactionService>).length !=
                            0)
                          setState(() {
                            _transactionServices =
                                callbackData as List<TransactionService>;
                          });
                        if (_createdDate != null)
                          setState(() {
                            _finishedDate = _createdDate.add(
                              Duration(
                                milliseconds:
                                    _getMaxDateInListOfTranactionService(),
                              ),
                            );
                          });
                      },
                      isFullWidth: true,
                    ),
                    _createdDate != null ? _gap() : Container(),
                    _createdDate != null
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                GlobalData.BORDER_RADIUS,
                              ),
                              color: GlobalData.GREY_LIGHT_COLOR,
                            ),
                            child: Wrap(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.event_note,
                                    color: GlobalData.PRIMARY_COLOR,
                                  ),
                                  title: Text(
                                    'Tanggal Transaksi',
                                    style: TextStyle(
                                      color: GlobalData.PRIMARY_COLOR,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    DateFormat.yMMMMd().format(_createdDate),
                                    style: TextStyle(
                                      color: GlobalData.FOREGROUND_COLOR,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.event_note,
                                    color: GlobalData.PRIMARY_COLOR,
                                  ),
                                  title: Text(
                                    'Tanggal Selesai',
                                    style: TextStyle(
                                      color: GlobalData.PRIMARY_COLOR,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    DateFormat.yMMMMd().format(_finishedDate),
                                    style: TextStyle(
                                      color: GlobalData.FOREGROUND_COLOR,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    // Input created date
                    _transactionServices.length != 0 ? _gap() : Container(),
                    _transactionServices.length != 0
                        ? CustomButton(
                            type: CustomButtonType.PRIMARY,
                            text: 'Pilih Tanggal Transaksi',
                            onPressed: () {
                              _nameFocus.unfocus();
                              _additionalInfoFocus.unfocus();
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                onConfirm: (date) {
                                  setState(() {
                                    _createdDate = date;
                                    _finishedDate = date.add(
                                      Duration(
                                        milliseconds:
                                            _getMaxDateInListOfTranactionService(),
                                      ),
                                    );
                                  });
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.id,
                              );
                            },
                            isFullWidth: true,
                          )
                        : Container(),
                    // Input description info date
                    _transactionServices.length != 0 ? _gap() : Container(),
                    _transactionServices.length != 0
                        ? CustomInputText(
                            focusNode: _additionalInfoFocus,
                            onChanged: (e) {
                              setState(() {
                                _additionalInfo = e;
                              });
                            },
                            label: 'Keterangan (Opsional)',
                            err: null,
                            hint: 'Masukkan keterangan tambahan',
                            type: TextInputType.multiline,
                          )
                        : Container(),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: GlobalData.COMPONENT_MARGIN_PADDING * 7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(GlobalData.BODY_MARGIN_PADDING),
              child: CustomButton(
                size: CustomButtonSize.BIG,
                type: _name == null ||
                        _transactionServices == null ||
                        _createdDate == null ||
                        _finishedDate == null
                    ? CustomButtonType.DISABLE
                    : CustomButtonType.ACCENT,
                text: 'Lanjutkan',
                onPressed: () {
                  _nameFocus.unfocus();
                  _additionalInfoFocus.unfocus();
                  if (!(_name == null ||
                      _transactionServices == null ||
                      _createdDate == null ||
                      _finishedDate == null)) {
                    // Generate bill total
                    int billTotal = 0;
                    _transactionServices.forEach((element) {
                      billTotal += element.priceTotal;
                    });

                    Transaction transaction = Transaction(
                      additionalInfo: _additionalInfo,
                      createdDate: _createdDate,
                      customerName: _name,
                      finishedDate: _finishedDate,
                      billTotal: billTotal,
                      transactionId: _idTransaction,
                      services: _transactionServices,
                    );
                    Get.toNamed('/review-transaction', arguments: transaction);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _gap() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: GlobalData.COMPONENT_MARGIN_PADDING,
      ),
    );
  }
}
