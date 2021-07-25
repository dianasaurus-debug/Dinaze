import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/search_waqf_program/search_waqf_program_cubit.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:flutter_cash_waqf/view/widgets/waqf_program_card.dart';

class SearchWaqfProgram extends StatelessWidget {
  final TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<SearchWaqfProgramCubit>().resetState();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: CloseButton(
          color: Constant.bwiGreenColor,
        ),
        title: TextField(
          autofocus: true,
          controller: _queryController,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: "Masukkan kata kunci...",
            border: InputBorder.none,
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty)
              context.read<SearchWaqfProgramCubit>().search(value);
          },
        ),
      ),
      body: BlocBuilder<SearchWaqfProgramCubit, SearchWaqfProgramState>(
        builder: (context, state) {
          if (state is SearchWaqfProgramLoadingState) {
            return Loading();
          } else if (state is SearchWaqfProgramEmptyState) {
            return _buildMessage(state.message);
          } else if (state is SearchWaqfProgramFailureState) {
            return _buildMessage(state.message);
          } else if (state is SearchWaqfProgramSuccessState) {
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(10.0),
              physics: BouncingScrollPhysics(),
              itemCount: state.listProgramWakaf.length,
              itemBuilder: (context, index) =>
                  NewWaqfProgramCard(state.listProgramWakaf[index]),
            );
          } else {
            return Container(width: 0.0, height: 0.0);
          }
        },
      ),
    );
  }

  Widget _buildMessage(String message) => Center(
        child: Text(message),
      );
}
