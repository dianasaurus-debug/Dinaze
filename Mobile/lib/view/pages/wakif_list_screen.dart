import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/get_wakif/get_wakif_cubit.dart';
import 'package:flutter_cash_waqf/model/wakaf_abadi.dart';
import 'package:flutter_cash_waqf/model/wakaf_berjangka.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/utilities/extensions.dart';
import 'package:flutter_cash_waqf/view/widgets/empty_data_screen.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class WakifListScreen extends StatelessWidget {
  final int _id = Get.arguments as int;
  @override
  Widget build(BuildContext context) {
    context.read<GetWakifCubit>().get(_id);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text("Daftar Wakif"),
        centerTitle: true,
        leading: CloseButton(),
      ),
      body: EasyRefresh(
        header: MaterialHeader(),
        onRefresh: () => context.read<GetWakifCubit>().refresh(_id),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: BlocBuilder<GetWakifCubit, GetWakifState>(
            builder: (context, state) {
              if (state is GetWakifSuccessState) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: state.listWakaf.length,
                  itemBuilder: (context, index) {
                    if (state.listWakaf[index] is WakafAbadi) {
                      final WakafAbadi _wakafAbadi =
                          (state.listWakaf[index] as WakafAbadi);
                      return _buildContainer(
                          "Abadi",
                          _wakafAbadi.tanggal!,
                          _wakafAbadi.waktu!,
                          _wakafAbadi.namaWakif!,
                          _wakafAbadi.nominal!);
                    } else {
                      final WakafBerjangka _wakafBerjangka =
                          (state.listWakaf[index] as WakafBerjangka);
                      return _buildContainer(
                          "Berjangka",
                          _wakafBerjangka.tanggal!,
                          _wakafBerjangka.waktu!,
                          _wakafBerjangka.namaWakif!,
                          _wakafBerjangka.nominal!);
                    }
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                );
              } else if (state is GetWakifEmptyState) {
                return EmptyDataScreen(state.message);
              } else if (state is GetWakifFailureState) {
                return Text(state.message);
              } else {
                return Loading();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(String jenis, String tanggal, String waktu,
      String namaWakif, int nominal) {
    return Container(
      padding: EdgeInsets.all(10.0),
      width: Get.width,
      decoration: BoxDecoration(
        border: Border.all(
          color: Constant.bwiGreenColor,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$tanggal • $waktu",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 13.0,
                  ),
                ),
                Text(
                  namaWakif,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  jenis,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 13.0,
                    color: Constant.bwiGreenColor,
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Text(
              nominal.toRupiahFormat(),
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
                color: Constant.bwiGreenColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
