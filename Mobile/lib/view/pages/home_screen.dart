import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/display_category/display_category_cubit.dart';
import 'package:flutter_cash_waqf/cubit/waqf_program/waqf_program_cubit.dart';
import 'package:flutter_cash_waqf/model/kategori.dart';
import 'package:flutter_cash_waqf/model/program_wakaf.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/utilities/extensions.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:flutter_cash_waqf/view/widgets/waqf_program_card.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WaqfProgramCubit>().getAll();
    context.read<DisplayCategoryCubit>().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        title: InkWell(
          onTap: () => Get.toNamed('/search-waqf-program'),
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Constant.bwiGreenColor,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cari program wakaf...",
                  style: TextStyle(
                    fontSize: 12,
                    color: Constant.bwiGreenColor,
                  ),
                ),
                Icon(
                  Icons.search_outlined,
                  color: Constant.bwiGreenColor,
                ),
              ],
            ),
          ),
        ),
      ),
      body: EasyRefresh(
        header: MaterialHeader(),
        onRefresh: () async {
          context.read<WaqfProgramCubit>().refresh();
          context.read<DisplayCategoryCubit>().refresh();
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Builder(
            builder: (context) {
              final _categoryState =
                  context.watch<DisplayCategoryCubit>().state;
              final _waqfProgramState = context.watch<WaqfProgramCubit>().state;

              if (_categoryState is DisplayCategorySuccessState &&
                  _waqfProgramState is WaqfProgramFilledState) {
                return ListView(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  children: [
                    Text(
                      "Kategori",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: Get.height * 0.06,
                      child: _buildCategoryList(_categoryState.listKategori),
                    ),
                    Divider(),
                    Text(
                      "Program Wakaf Terbaru",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    _buildWaqfProgramList(_waqfProgramState.listProgramWakaf),
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

  Widget _buildCategoryList(List<Kategori> data) => ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, index) => VerticalDivider(),
        itemCount: data.length,
        itemBuilder: (context, index) => _buildCategoryItem(data[index]),
      );

  Widget _buildCategoryItem(Kategori kategori) => InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () => Get.toNamed('/waqf-program-category', arguments: kategori),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Constant.bwiGreenColor,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(
                kategori.nama!.toFontAwesomeIcon(),
                color: Constant.bwiGreenColor,
              ),
              VerticalDivider(),
              Text(
                kategori.nama!,
                style: TextStyle(color: Constant.bwiGreenColor),
              ),
            ],
          ),
        ),
      );

  Widget _buildWaqfProgramList(List<ProgramWakaf> data) => ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => NewWaqfProgramCard(data[index]),
        itemCount: data.length,
      );
}
