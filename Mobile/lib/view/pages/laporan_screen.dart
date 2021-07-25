import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/cubit/get_laporan/get_laporan_cubit.dart';
import 'package:flutter_cash_waqf/model/laporan.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

class LaporanScreen extends StatelessWidget {
  final int _id = Get.arguments as int;

  @override
  Widget build(BuildContext context) {
    context.read<GetLaporanCubit>().get(_id);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text("Laporan"),
        centerTitle: true,
        leading: CloseButton(),
      ),
      body: EasyRefresh(
        header: MaterialHeader(),
        onRefresh: () => context.read<GetLaporanCubit>().refresh(_id),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: BlocBuilder<GetLaporanCubit, GetLaporanState>(
            builder: (context, state) {
              if (state is GetLaporanSuccessState) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: state.listLaporan.length,
                  itemBuilder: (context, index) {
                    Laporan _laporan = state.listLaporan[index];
                    if (index == (state.listLaporan.length - 1)) {
                      return _buildTimelineTile(_laporan, true);
                    } else {
                      return _buildTimelineTile(_laporan, false);
                    }
                  },
                );
              } else if (state is GetLaporanFailureState) {
                return Text(state.message);
              } else if (state is GetLaporanEmptyState) {
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

  TimelineTile _buildTimelineTile(Laporan laporan, bool isLast) => TimelineTile(
        isLast: isLast,
        beforeLineStyle: LineStyle(color: Constant.bwiGreenColor, thickness: 3),
        afterLineStyle: LineStyle(color: Constant.bwiGreenColor, thickness: 3),
        indicatorStyle:
            IndicatorStyle(color: Constant.bwiGreenColor, width: 15.0),
        endChild: Container(
          color: Colors.white,
          padding: EdgeInsets.all(5.0),
          margin: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${laporan.tanggal} • ${laporan.waktu}",
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 13.0,
                ),
              ),
              if (laporan.gambar != null) ...[
                Divider(),
                Image.network(
                  "${Constant.imageUrlApi}/${laporan.gambar}",
                ),
                Divider(),
              ],
              Text(
                laporan.deskripsi!,
                style: TextStyle(),
              ),
            ],
          ),
        ),
      );
}
