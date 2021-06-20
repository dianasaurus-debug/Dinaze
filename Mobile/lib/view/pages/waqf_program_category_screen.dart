import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/waqf_program_by_category/waqf_program_by_category_cubit.dart';
import 'package:flutter_cash_waqf/model/kategori.dart';
import 'package:flutter_cash_waqf/model/program_wakaf.dart';
import 'package:flutter_cash_waqf/view/widgets/empty_data_screen.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:flutter_cash_waqf/view/widgets/waqf_program_card.dart';
import 'package:get/get.dart';

class WaqfProgramCategoryScreen extends StatelessWidget {
  final Kategori _kategori = Get.arguments as Kategori;

  @override
  Widget build(BuildContext context) {
    context.read<WaqfProgramByCategoryCubit>().get(_kategori.id!);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: Text(_kategori.nama!),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.close),
          padding: EdgeInsets.zero,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<WaqfProgramByCategoryCubit, WaqfProgramByCategoryState>(
        builder: (context, state) {
          if (state is WaqfProgramByCategoryEmptyState) {
            return EmptyDataScreen(state.message);
          } else if (state is WaqfProgramByCategoryFailureState) {
            return Text(state.message);
          } else if (state is WaqfProgramByCategorySuccessState) {
            return _buildWaqfProgramList(state.listProgramWakaf);
          } else {
            return Loading();
          }
        },
      ),
    );
  }

  Widget _buildWaqfProgramList(List<ProgramWakaf> data) => ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(10.0),
        itemBuilder: (context, index) => NewWaqfProgramCard(data[index]),
        itemCount: data.length,
      );
}
