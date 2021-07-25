import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/cubit/single_waqf_program/single_waqf_program_cubit.dart';
import 'package:flutter_cash_waqf/model/program_wakaf.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/view/widgets/green_button.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:flutter_cash_waqf/view/widgets/waqf_info_row.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WaqfProgramScreen extends StatelessWidget {
  final int _id = Get.arguments as int;

  @override
  Widget build(BuildContext context) {
    context.read<SingleWaqfProgramCubit>().getSingle(_id);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: BlocBuilder<SingleWaqfProgramCubit, SingleWaqfProgramState>(
        builder: (context, state) {
          if (state is SingleWaqfProgramSuccessState) {
            final ProgramWakaf _programWakaf = state.programWakaf;
            return SafeArea(
              child: NestedScrollView(
                physics: BouncingScrollPhysics(),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: Get.height * 0.25,
                      floating: true,
                      snap: false,
                      pinned: true,
                      elevation: 0,
                      stretch: true,
                      leading: CloseButton(),
                      flexibleSpace: LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return FlexibleSpaceBar(
                            background: Image.network(
                              _programWakaf.gambar!,
                              fit: BoxFit.contain,
                            ),
                            // title: (constraints.biggest.height ==
                            //         MediaQuery.of(context).padding.top + kToolbarHeight)
                            //     ? Text(
                            //         waqfProgram.title,
                            //         maxLines: 1,
                            //         overflow: TextOverflow.ellipsis,
                            //       )
                            //     : null,
                          );
                        },
                      ),
                    ),
                  ];
                },
                body: ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      margin: EdgeInsets.all(0.0),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              _programWakaf.judul!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Divider(),
                            WaqfProgramInfoRow(_programWakaf),
                            Divider(),
                            GreenButton(
                              text: "Saya Ingin Berwakaf",
                              onPressedFunction: () => Get.toNamed('/waqf-form',
                                  arguments: _programWakaf),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deskripsi",
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Divider(),
                            ExpandableText(
                              _programWakaf.deskripsi!,
                              maxLines: 5,
                              expandText: 'selengkapnya',
                              collapseText: 'sembunyikan',
                              linkColor: Constant.bwiGreenColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              onTap: () => Get.toNamed('/wakif-list',
                                  arguments: _programWakaf.id),
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                Icons.people,
                                color: Constant.bwiGreenColor,
                              ),
                              title: Text('Daftar Wakif'),
                              trailing: Icon(Icons.chevron_right),
                            ),
                            ListTile(
                              onTap: () => Get.toNamed('/laporan',
                                  arguments: _programWakaf.id),
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(
                                Icons.shopping_cart,
                                color: Constant.bwiGreenColor,
                              ),
                              title: Text("Laporan Penggunaan Dana"),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
