import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/reset_password/request_reset_password_cubit.dart';
import 'package:flutter_cash_waqf/view/widgets/green_button.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:get/get.dart';

class RequestResetPasswordScreen extends StatelessWidget {
  final _formState = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestResetPasswordCubit, RequestResetPasswordState>(
      listener: (context, state) {
        if (state is RequestResetPasswordFailureState) {
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
          _emailController.clear();
        }

        if (state is RequestResetPasswordSuccessState) {
          Get.offNamed('/verify-reset-password-token',
              arguments: _emailController.text.trim());
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
              "Lupa Kata Sandi?",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Masukkan alamat surel kamu.",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Divider(
              height: 20.0,
            ),
            Form(
              key: _formState,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.send,
                    onFieldSubmitted: (_) => _onPressedAction(context),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Alamat Surel',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Alamat surel harus diisi';
                      if (!value.isEmail) return 'Alamat surel tidak valid';
                      return null;
                    },
                  ),
                  Divider(),
                  BlocBuilder<RequestResetPasswordCubit,
                      RequestResetPasswordState>(
                    builder: (context, state) {
                      if (state is RequestResetPasswordLoadingState) {
                        return Loading(size: 30.0);
                      } else {
                        return GreenButton(
                          text: "Atur Ulang Kata Sandi",
                          onPressedFunction: () => _onPressedAction(context),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onPressedAction(BuildContext context) {
    if (_formState.currentState!.validate()) {
      context
          .read<RequestResetPasswordCubit>()
          .requestResetPassword(_emailController.text.trim());
    }
  }
}
