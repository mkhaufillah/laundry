import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:laundry/app/blocs/get_service_bloc.dart';
import 'package:laundry/app/models/service.dart';
import 'package:laundry/app/models/transaction_service.dart';
import 'package:laundry/app/ui/components/custom_app_bar.dart';
import 'package:laundry/app/ui/components/custom_button.dart';
import 'package:laundry/app/ui/components/custom_input_text.dart';
import 'package:laundry/app/ui/components/error_page.dart';
import 'package:laundry/app/ui/components/loading_page.dart';
import 'package:laundry/global_data.dart';

class ListService extends StatefulWidget {
  @override
  _ListServiceState createState() => _ListServiceState();
}

class _ListServiceState extends State<ListService> {
  GetServiceBloc _getServiceBloc;

  List<Service> _services;
  List<TransactionService> _transactionServices;

  String _idTransaction;
  int _buyQty;

  int _page;
  bool _loadPage;
  String _q;

  ScrollController _scrollController;

  bool _isStarting;

  Future<bool> _onWillPop() async {
    Get.back(result: _transactionServices);
    return false;
  }

  _makePageLoaded(bool v) {
    if (v) {
      _page++;
      _getServiceBloc.add(GetServiceBlocParams(
          page: _page,
          q: _q,
          callback: () {
            _makePageLoaded(false);
          }));
    }
    setState(() {
      _loadPage = v;
    });
  }

  _addService(Service service) {
    Get.bottomSheet(
      Container(
        color: GlobalData.BACKGROUND_COLOR,
        padding: EdgeInsets.all(GlobalData.BODY_MARGIN_PADDING),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tambah ' + service.serviceName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(GlobalData.COMPONENT_MARGIN_PADDING),
              ),
              CustomInputText(
                onChanged: (e) {
                  _buyQty = int.parse(e);
                },
                hint: 'Masukkan jumlah pesanan',
                type: TextInputType.number,
                label: 'Jumlah (${service.unitName})',
              ),
              Padding(
                padding: EdgeInsets.all(GlobalData.COMPONENT_MARGIN_PADDING),
              ),
              CustomButton(
                  text: 'Tambah',
                  isFullWidth: true,
                  type: CustomButtonType.ACCENT,
                  onPressed: () {
                    if (_buyQty != null && _buyQty > 0) {
                      Get.back();
                      setState(() {
                        _transactionServices.add(TransactionService(
                          transactionId: _idTransaction,
                          serviceId: service.serviceId,
                          serviceName: service.serviceName,
                          buyQty: _buyQty,
                          servicePrice: service.price,
                          priceTotal: service.price * _buyQty,
                          completeDuration: service.completeDuration,
                          unitName: service.unitName,
                        ));
                      });
                      _buyQty = 0;
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _getServiceBloc = BlocProvider.of<GetServiceBloc>(context);

    _idTransaction = Get.arguments as String;
    _buyQty = 0;

    _transactionServices = [];

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
    _page = 1;
    _services = [];
    _getServiceBloc.add(GetServiceBlocParams(page: _page));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _isStarting = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: PreferredSize(
          child: CustomAppBar(title: 'Daftar Layanan'),
          preferredSize: Size.fromHeight(kToolbarHeight),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              BlocBuilder<GetServiceBloc, GetServiceBlocResults>(
                builder: (context, snapshot) {
                  // Fill snapshot data to local scope data
                  if (_services == null || _services.length == 0)
                    _services = snapshot.services;
                  else if (snapshot.services.length != 0 &&
                      _services[0].serviceId != snapshot.services[0].serviceId)
                    _services = [..._services, ...snapshot.services];

                  // Reset previous pagination
                  if (_isStarting == null) {
                    _isStarting = true;
                    _services = [];
                  }

                  // If result stream success
                  if ((snapshot.status == GlobalStreamStatus.SUCCESS &&
                          _services.length != 0) ||
                      _page > 1) {
                    return SingleChildScrollView(
                      controller: _scrollController,
                      child: Wrap(
                        children: _services.map((e) {
                          return ListTile(
                            contentPadding: _services.indexOf(e) == 0
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
                              Icons.local_laundry_service,
                              color: GlobalData.PRIMARY_COLOR,
                            ),
                            title: Text(
                              e.serviceName,
                              style: TextStyle(
                                  color: GlobalData.PRIMARY_COLOR,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              'Harga ${e.price.parseToIdrCurrency()}\nPengerjaan ${(e.completeDuration / 8.64e+7).round()} hari ${((e.completeDuration % 8.64e+7) / 3.6e+6).ceil()} jam / ${e.unitName}',
                              style: TextStyle(
                                color: GlobalData.FOREGROUND_COLOR,
                              ),
                            ),
                            onTap: () {
                              _addService(e);
                            },
                          );
                        }).toList(),
                      ),
                    );
                  }

                  if (snapshot.status == GlobalStreamStatus.SUCCESS &&
                      _services.length == 0)
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
                    _q = e;
                    _page = 1;
                    _services = [];
                    _getServiceBloc.add(GetServiceBlocParams(
                      page: _page,
                      q: _q,
                    ));
                  },
                  hint: 'Tulis nama layanan',
                  label: 'Cari Layanan',
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
      ),
    );
  }
}
