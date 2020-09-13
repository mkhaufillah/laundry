import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:laundry/app/blocs/get_transaction_bloc.dart';
import 'package:laundry/app/models/transaction.dart';
import 'package:laundry/app/ui/components/custom_app_bar.dart';
import 'package:laundry/app/ui/components/custom_input_text.dart';
import 'package:laundry/app/ui/components/error_page.dart';
import 'package:laundry/app/ui/components/loading_page.dart';
import 'package:laundry/global_data.dart';

class ListTransaction extends StatefulWidget {
  @override
  _ListTransactionState createState() => _ListTransactionState();
}

class _ListTransactionState extends State<ListTransaction> {
  GetTransactionBloc _getTransactionBloc;

  List<Transaction> _transactions;

  DateTime _startAfter;
  bool _loadPage;
  String _customerName;

  ScrollController _scrollController;

  _makePageLoaded(bool v) {
    if (v) {
      _startAfter = _transactions[_transactions.length].createdDate;
      _getTransactionBloc.add(GetTransactionBlocParams(
          startAfter: _startAfter,
          customerName: _customerName,
          callback: () {
            _makePageLoaded(false);
          }));
    }
    setState(() {
      _loadPage = v;
    });
  }

  @override
  void initState() {
    _getTransactionBloc = BlocProvider.of<GetTransactionBloc>(context);
    _getTransactionBloc.add(GetTransactionBlocParams());

    _transactions = [];

    // For pagination
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        _makePageLoaded(true);
      }
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _startAfter = null;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'Daftar Layanan'),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            BlocBuilder<GetTransactionBloc, GetTransactionBlocResults>(
              builder: (context, snapshot) {
                // Fill snapshot data to local scope data
                if (_transactions == null || _transactions.length == 0)
                  _transactions = snapshot.transactions;
                else if (snapshot.transactions.length != 0 &&
                    _transactions[0].transactionId !=
                        snapshot.transactions[0].transactionId)
                  _transactions = [..._transactions, ...snapshot.transactions];

                // If result stream success
                if ((snapshot.status == GlobalStreamStatus.SUCCESS &&
                        _transactions.length != 0) ||
                    _startAfter != null) {
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: Wrap(
                      children: _transactions.map((e) {
                        return ListTile(
                          contentPadding: _transactions.indexOf(e) == 0
                              ? EdgeInsets.only(
                                  top: 90,
                                  bottom: GlobalData.COMPONENT_MARGIN_PADDING,
                                  left: GlobalData.COMPONENT_MARGIN_PADDING,
                                  right: GlobalData.COMPONENT_MARGIN_PADDING,
                                )
                              : EdgeInsets.all(
                                  GlobalData.COMPONENT_MARGIN_PADDING,
                                ),
                          leading: Icon(
                            Icons.done_all,
                            color: GlobalData.PRIMARY_COLOR,
                          ),
                          title: Text(
                            e.customerName,
                            style: TextStyle(
                                color: GlobalData.PRIMARY_COLOR,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Harga ${e.billTotal.parseToIdrCurrency()}\nPengerjaan ${e.services.length} Layanan',
                            style: TextStyle(
                              color: GlobalData.FOREGROUND_COLOR,
                            ),
                          ),
                          onTap: () {
                            Get.toNamed(
                              '/show-transaction',
                              arguments: e,
                            );
                          },
                        );
                      }).toList(),
                    ),
                  );
                }

                if (snapshot.status == GlobalStreamStatus.SUCCESS &&
                    _transactions.length == 0)
                  return ErrorPage(text: 'Data tidak tersedia');

                if (snapshot.status == GlobalStreamStatus.FAILED)
                  return ErrorPage();

                return LoadingPage();
              },
            ),
            // Search element
            Padding(
              padding: EdgeInsets.all(GlobalData.BODY_MARGIN_PADDING),
              child: CustomInputText(
                onChanged: (e) {
                  _transactions = [];
                  _startAfter = null;
                  _customerName = e;
                  _getTransactionBloc.add(GetTransactionBlocParams(
                    startAfter: _startAfter,
                    customerName: _customerName,
                  ));
                },
                hint: 'Tulis nama pelanggan',
                label: 'Cari Transaksi',
              ),
            ),
            _loadPage != null && _loadPage
                ? Container(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
