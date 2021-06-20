import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/get_wakaf_abadi/get_wakaf_abadi_cubit.dart';
import 'package:flutter_cash_waqf/model/wakaf_abadi.dart';
import 'package:flutter_cash_waqf/utilities/extensions.dart';
import 'package:flutter_cash_waqf/view/widgets/green_button.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:flutter_cash_waqf/view/widgets/payment_method_list_tile.dart';
import 'package:flutter_cash_waqf/view/widgets/waqf_program_list_tile.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class WakafAbadiReceiptScreen extends StatelessWidget {
  final String _id = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    context.read<GetWakafAbadiCubit>().get(_id);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        brightness: Brightness.dark,
        titleSpacing: 0.0,
        title: Text("Transaksi Wakaf Uang"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.close),
          padding: EdgeInsets.zero,
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: EasyRefresh(
          header: MaterialHeader(),
          onRefresh: () => context.read<GetWakafAbadiCubit>().refresh(_id),
          child: BlocBuilder<GetWakafAbadiCubit, GetWakafAbadiState>(
            builder: (context, state) {
              if (state is GetWakafAbadiSuccessState) {
                final WakafAbadi _wakafAbadi = state.wakafAbadi;
                return ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Text(
                      "${_wakafAbadi.tanggal} • ${_wakafAbadi.waktu}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Table(
                        border: TableBorder.all(style: BorderStyle.none),
                        children: [
                          _buildTableRow("Jenis Wakaf Uang", "Wakaf Abadi"),
                          _buildTableRow(
                              "Nominal", _wakafAbadi.nominal!.toRupiahFormat()),
                          _buildTableRow("Nama Wakif", _wakafAbadi.namaWakif!),
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: WaqfProgramListTile(_wakafAbadi.programWakaf!),
                    ),
                    Divider(),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: PaymentMethodListTile(
                          _wakafAbadi.metodePembayaran!,
                          _wakafAbadi.kodePembayaran!,
                          _wakafAbadi.statusPembayaran!),
                    ),
                    if (_wakafAbadi.statusPembayaran == 'success' &&
                        _wakafAbadi.aktaIkrarWakaf != null &&
                        _wakafAbadi.sertifikatWakafUang != null) ...[
                      Divider(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: GreenButton(
                          text: "Sertifikat Wakaf Uang",
                          onPressedFunction: () => Get.toNamed('/pdf-viewer',
                              arguments: [
                                "Sertifikat Wakaf Uang",
                                _wakafAbadi.sertifikatWakafUang
                              ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: GreenButton(
                          text: "Akta Ikrar Wakaf",
                          onPressedFunction: () => Get.toNamed('/pdf-viewer',
                              arguments: [
                                "Akta Ikrar Wakaf",
                                _wakafAbadi.aktaIkrarWakaf
                              ]),
                        ),
                      ),
                    ],
                  ],
                );
              } else {
                return Loading();
              }
            },
          ),
        ),
      ),
    );
  }

  _buildTableRow(String title, String data) => TableRow(
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            data,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      );
}
