import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:laundry/app/blocs/get_service_bloc.dart';
import 'package:laundry/app/models/service.dart';
import 'package:laundry/app/models/transaction.dart';
import 'package:laundry/app/ui/components/custom_app_bar.dart';
import 'package:laundry/app/ui/components/custom_button.dart';
import 'package:laundry/app/ui/components/custom_input_text.dart';
import 'package:laundry/app/ui/components/error_page.dart';
import 'package:laundry/app/ui/components/loading_page.dart';
import 'package:laundry/global_data.dart';

class InputTransaction extends StatefulWidget {
  @override
  _InputTransactionState createState() => _InputTransactionState();
}

class _InputTransactionState extends State<InputTransaction> {
  GetServiceBloc _getServiceBloc;

  String _name;
  Service _service;
  int _quantity;
  DateTime _createdDate;
  DateTime _finishedDate;
  String _additionalInfo;

  String _nameErr;
  String _quantityErr;

  // Set service in here because support setstate
  _setService(service) {
    setState(() {
      _service = service;
    });
  }

  // Servis list UI
  _openServicesList(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SingleChildScrollView(
          child: BlocBuilder<GetServiceBloc, GetServiceBlocResults>(
              builder: (context, snapshot) {
            if (snapshot.status == GlobalStreamStatus.SUCCESS &&
                snapshot.services.length != 0) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(GlobalData.BODY_MARGIN_PADDING),
                    child: CustomInputText(
                      onChanged: (e) {
                        _getServiceBloc.add(GetServiceBlocParams(
                          query: e,
                          services: snapshot.services,
                        ));
                      },
                      hint: 'Tulis nama layanan',
                      label: 'Cari Layanan',
                    ),
                  ),
                  Wrap(
                    children: snapshot.services.map((e) {
                      return ListTile(
                        leading: Icon(
                          Icons.local_laundry_service,
                          color: e.isSearched != null && e.isSearched
                              ? GlobalData.PRIMARY_COLOR
                              : GlobalData.FOREGROUND_COLOR,
                        ),
                        title: Text(
                          e.name,
                          style: TextStyle(
                            color: e.isSearched != null && e.isSearched
                                ? GlobalData.PRIMARY_COLOR
                                : GlobalData.FOREGROUND_COLOR,
                          ),
                        ),
                        subtitle: Text(
                          '${e.price.parseToIdrCurrency()} - ${(e.completeDuration / 3.6e+6).round()} JAM',
                          style: TextStyle(
                            color: e.isSearched != null && e.isSearched
                                ? GlobalData.PRIMARY_COLOR
                                : GlobalData.FOREGROUND_COLOR,
                          ),
                        ),
                        onTap: () {
                          _setService(e);
                          Get.back();
                        },
                      );
                    }).toList(),
                  ),
                ],
              );
            }

            if (snapshot.status == GlobalStreamStatus.SUCCESS &&
                snapshot.services.length != 0)
              return ErrorPage(text: 'Data tidak tersedia');

            if (snapshot.status == GlobalStreamStatus.FAILED)
              return ErrorPage();

            return LoadingPage();
          }),
        );
      },
    );
  }

  @override
  void initState() {
    _getServiceBloc = BlocProvider.of<GetServiceBloc>(context);
    _getServiceBloc.add(GetServiceBlocParams());
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
                    // Input service
                    _name != null && _name != '' ? _gap() : Container(),
                    _name != null && _name != ''
                        ? CustomButton(
                            type: CustomButtonType.PRIMARY,
                            text: 'Pilih Layanan',
                            onPressed: () async {
                              _openServicesList(context);
                            },
                            isFullWidth: true,
                          )
                        : Container(),
                    // Input quantity service
                    _service != null ? _gap() : Container(),
                    _service != null
                        ? CustomInputText(
                            onChanged: (e) {
                              setState(() {
                                _quantityErr = null;
                              });
                              if (e == null || e == '') {
                                setState(() {
                                  _quantityErr = 'Tidak boleh kosong';
                                });
                              }
                              setState(() {
                                _quantity = int.parse(e);
                              });
                            },
                            label: 'Kuantitas (${_service.unitName})',
                            err: _quantityErr,
                            hint: 'Masukkan kuantitas',
                            type: TextInputType.number)
                        : Container(),
                    // Input created date
                    _service != null ? _gap() : Container(),
                    _service != null
                        ? CustomButton(
                            type: CustomButtonType.PRIMARY,
                            text: 'Pilih Tanggal Transaksi',
                            onPressed: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                onConfirm: (date) {
                                  setState(() {
                                    _createdDate = date;
                                  });
                                },
                                currentTime: DateTime.now(),
                                locale: LocaleType.id,
                              );
                            },
                            isFullWidth: true,
                          )
                        : Container(),
                    // Input finish date
                    _createdDate != null ? _gap() : Container(),
                    _createdDate != null
                        ? CustomButton(
                            type: CustomButtonType.PRIMARY,
                            text: 'Pilih Tanggal Penyelesaian',
                            onPressed: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: _createdDate,
                                maxTime: _createdDate.add(
                                  Duration(
                                    milliseconds: _service.completeDuration,
                                  ),
                                ),
                                onConfirm: (date) {
                                  setState(() {
                                    _finishedDate = date;
                                  });
                                },
                                currentTime: _createdDate,
                                locale: LocaleType.id,
                              );
                            },
                            isFullWidth: true,
                          )
                        : Container(),
                    // Input description info date
                    _service != null ? _gap() : Container(),
                    _service != null
                        ? CustomInputText(
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
                        _quantity == null ||
                        _service == null ||
                        _createdDate == null ||
                        _finishedDate == null
                    ? CustomButtonType.DISABLE
                    : CustomButtonType.ACCENT,
                text: 'Lanjutkan',
                onPressed: () {
                  if (!(_name == null ||
                      _quantity == null ||
                      _service == null ||
                      _createdDate == null ||
                      _finishedDate == null)) {
                    Transaction transaction = Transaction(
                      additionalInfo: _additionalInfo,
                      createdDate: _createdDate,
                      customerName: _name,
                      finishedDate: _finishedDate,
                      quantity: _quantity,
                      service: _service,
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
