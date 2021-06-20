import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/cubit/password_visibility/password_visibility_cubit.dart';
import 'package:flutter_cash_waqf/cubit/reset_password/reset_password_cubit.dart';
import 'package:flutter_cash_waqf/view/widgets/green_button.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatelessWidget {
  final _email = Get.arguments[0] as String;
  final _token = Get.arguments[1] as String;
  final _formState = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<PasswordVisibilityCubit>().hidePassword();

    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordFailureState) {
          Get.snackbar(
            "Gagal",
            state.message,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            icon: Icon(
              Icons.error,
              color: Colors.white,
            ),
            isDismissible: true,
            duration: Duration(seconds: 2),
            borderRadius: 10.0,
            padding: EdgeInsets.all(15.0),
            snackPosition: SnackPosition.TOP,
            margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
          );
        }

        if (state is ResetPasswordSuccessState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.SUCCES,
            animType: AnimType.BOTTOMSLIDE,
            dismissOnBackKeyPress: false,
            dismissOnTouchOutside: false,
            buttonsBorderRadius: BorderRadius.circular(5),
            headerAnimationLoop: false,
            title: "Berhasil",
            desc: "Kata sandi berhasil diatur ulang",
            btnOkOnPress: () => Get.back(),
            btnOkText: "Oke",
          ).show();
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
              "Atur Ulang Kata Sandi",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Masukkan kata sandi baru untuk akunmu!",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Divider(),
            Form(
              key: _formState,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildPasswordFormField(
                    title: "Kata Sandi Baru",
                    autoFocus: true,
                    controller: _passwordController,
                    action: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) return "Kata sandi baru harus diisi";
                      if (value.length < 8)
                        return "Kata sandi minimal 8 karakter";
                      if (value != _confirmPasswordController.text.trim())
                        return "Kata sandi baru tidak sama";
                      return null;
                    },
                  ),
                  Divider(),
                  _buildPasswordFormField(
                    title: "Konfirmasi Kata Sandi Baru",
                    controller: _confirmPasswordController,
                    action: TextInputAction.send,
                    validator: (value) {
                      if (value!.isEmpty)
                        return "Konfirmasi kata sandi baru harus diisi";
                      if (value.length < 8)
                        return "Kata sandi minimal 8 karakter";
                      if (value != _passwordController.text.trim())
                        return "Kata sandi baru tidak sama";
                      return null;
                    },
                    onSubmit: (_) => _resetPasswordAction(context),
                  ),
                  BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
                    builder: (context, state) {
                      return SwitchListTile(
                        title: Text("Tampilkan Kata Sandi"),
                        value: (state is PasswordInvisibleState) ? false : true,
                        onChanged: (bool) {
                          if (state is PasswordInvisibleState)
                            context
                                .read<PasswordVisibilityCubit>()
                                .showPassword();
                          if (state is PasswordVisibleState)
                            context
                                .read<PasswordVisibilityCubit>()
                                .hidePassword();
                        },
                        contentPadding: EdgeInsets.zero,
                      );
                    },
                  ),
                  BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                    builder: (context, state) {
                      if (state is ResetPasswordLoadingState) {
                        return Loading(size: 30.0);
                      } else {
                        return GreenButton(
                          text: "Simpan Kata Sandi",
                          onPressedFunction: () =>
                              _resetPasswordAction(context),
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

  Widget _buildPasswordFormField({
    required String title,
    bool autoFocus = false,
    required TextEditingController controller,
    required TextInputAction action,
    void Function(String?)? onSubmit,
    String? Function(String?)? validator,
  }) =>
      BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
        builder: (context, state) {
          return TextFormField(
            autofocus: autoFocus,
            controller: controller,
            obscureText: (state is PasswordInvisibleState) ? true : false,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: action,
            onFieldSubmitted: onSubmit,
            decoration: InputDecoration(
              labelText: title,
              border: OutlineInputBorder(),
            ),
            validator: validator,
          );
        },
      );

  void _resetPasswordAction(BuildContext context) {
    final String _password = _passwordController.text.trim();
    context.read<ResetPasswordCubit>().resetPassword(_email, _token, _password);
  }
}
