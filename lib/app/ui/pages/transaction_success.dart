import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:laundry/app/ui/components/custom_app_bar.dart';
import 'package:laundry/app/ui/components/custom_button.dart';
import 'package:laundry/global_data.dart';

class TransactionSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        child: CustomAppBar(title: 'Transaksi berhasil'),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: height - GlobalData.BODY_MARGIN_PADDING * 2,
          padding: EdgeInsets.all(
            GlobalData.BODY_MARGIN_PADDING,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/receipt.svg',
                semanticsLabel: 'Success add transaction',
                alignment: Alignment.center,
                width: (width - GlobalData.BODY_MARGIN_PADDING * 2) * 0.5,
              ),
              Padding(
                padding: EdgeInsets.all(
                  GlobalData.COMPONENT_MARGIN_PADDING * 2,
                ),
              ),
              Text('Sukses menyimpan transaksi'),
              Padding(
                padding: EdgeInsets.all(
                  GlobalData.COMPONENT_MARGIN_PADDING,
                ),
              ),
              CustomButton(
                type: CustomButtonType.ACCENT,
                text: 'Kembali Ke Halaman Utama',
                onPressed: () {
                  Get.offAllNamed('/home');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
