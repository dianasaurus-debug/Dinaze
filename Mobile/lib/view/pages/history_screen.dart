import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/riwayat_wakaf/riwayat_wakaf_cubit.dart';
import 'package:flutter_cash_waqf/model/wakaf_abadi.dart';
import 'package:flutter_cash_waqf/model/wakaf_berjangka.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/utilities/extensions.dart';
import 'package:flutter_cash_waqf/view/widgets/empty_data_screen.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<RiwayatWakafCubit>().getAll();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        title: Text(
          'Riwayat Wakaf',
          style: TextStyle(
            color: Constant.bwiGreenColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: EasyRefresh(
        header: MaterialHeader(),
        onRefresh: () async =>
            context.read<RiwayatWakafCubit>().getAllRefresh(),
        child: BlocBuilder<RiwayatWakafCubit, RiwayatWakafState>(
          builder: (context, state) {
            if (state is RiwayatWakafSuccessState) {
              return ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(10.0),
                separatorBuilder: (context, int) {
                  return Divider();
                },
                itemCount: state.listRiwayatWakaf.length,
                itemBuilder: (context, index) {
                  if (state.listRiwayatWakaf[index] is WakafAbadi) {
                    return _buildWakafAbadiCard(
                        state.listRiwayatWakaf[index] as WakafAbadi);
                  } else {
                    return _buildWakafBerjangkaCard(
                        state.listRiwayatWakaf[index] as WakafBerjangka);
                  }
                },
              );
            } else if (state is RiwayatWakafEmptyState) {
              return EmptyDataScreen(state.message);
            } else if (state is RiwayatWakafFailureState) {
              return Text(state.message);
            } else {
              return Loading();
            }
          },
        ),
      ),
    );
  }

  Widget _buildWakafAbadiCard(WakafAbadi wakafAbadi) {
    return InkWell(
      onTap: () =>
          Get.toNamed('/wakaf-abadi-receipt', arguments: wakafAbadi.id),
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
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
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${wakafAbadi.tanggal} • ${wakafAbadi.waktu}",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13.0,
                    ),
                  ),
                  Text(
                    wakafAbadi.programWakaf!.judul!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Abadi • ${wakafAbadi.statusPembayaran!.toPaymentStatusDisplay()}",
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
                wakafAbadi.nominal!.toRupiahFormat(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  color: Constant.bwiGreenColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWakafBerjangkaCard(WakafBerjangka wakafBerjangka) {
    return InkWell(
      onTap: () =>
          Get.toNamed('/wakaf-berjangka-receipt', arguments: wakafBerjangka.id),
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
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
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${wakafBerjangka.tanggal} • ${wakafBerjangka.waktu}",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 13.0,
                    ),
                  ),
                  Text(
                    wakafBerjangka.programWakaf!.judul!,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Berjangka • ${wakafBerjangka.statusPembayaran?.toPaymentStatusDisplay()}",
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
                wakafBerjangka.nominal!.toRupiahFormat(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  color: Constant.bwiGreenColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
