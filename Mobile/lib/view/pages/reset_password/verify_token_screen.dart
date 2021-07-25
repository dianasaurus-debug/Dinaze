import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/reset_password/verify_reset_password_token_cubit.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyTokenScreen extends StatelessWidget {
  final String _email = Get.arguments as String;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyResetPasswordTokenCubit,
        VerifyResetPasswordTokenState>(
      listener: (context, state) {
        if (state is VerifyResetPasswordTokenFailureState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.BOTTOMSLIDE,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            buttonsBorderRadius: BorderRadius.circular(5),
            headerAnimationLoop: false,
            title: "Gagal",
            desc: state.message,
            btnCancelOnPress: () {},
            btnCancelText: "Oke",
          ).show();
          _controller.clear();
        }

        if (state is VerifyResetPasswordTokenSuccessState) {
          Get.offNamed('/reset-password',
              arguments: [_email, _controller.text.trim()]);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: CloseButton(color: Colors.black),
        ),
        body: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(15.0),
          children: [
            Text(
              "Verifikasi Kode",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Kode telah dikirim ke $_email.",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            PinCodeTextField(
              controller: _controller,
              appContext: context,
              autoFocus: true,
              length: 6,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.send,
              animationType: AnimationType.scale,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                inactiveColor: Colors.black,
                selectedColor: Constant.bwiGreenColor,
                activeColor: Constant.bwiGreenColor,
              ),
              onChanged: (_) {},
              onSubmitted: (_) => _onPressedAction(context),
              onCompleted: (_) => _onPressedAction(context),
            ),
            Divider(),
            BlocBuilder<VerifyResetPasswordTokenCubit,
                VerifyResetPasswordTokenState>(
              builder: (context, state) {
                if (state is VerifyResetPasswordTokenLoadingState) {
                  return Loading(size: 30.0);
                } else {
                  return Container(width: 0.0, height: 0.0);
                  // return GreenButton(
                  //   text: "VERIFIKASI",
                  //   onPressedFunction: () => _onPressedAction(context),
                  // );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedAction(BuildContext context) {
    final String _token = _controller.text.trim();
    context.read<VerifyResetPasswordTokenCubit>().verify(_email, _token);
  }
}
