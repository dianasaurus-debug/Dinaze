import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/change_password/change_password_cubit.dart';
import 'package:flutter_cash_waqf/cubit/password_visibility/password_visibility_cubit.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  final _formState = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<PasswordVisibilityCubit>().hidePassword();

    return BlocListener<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordFailureState) {
          Get.snackbar(
            "Gagal",
            state.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
            icon: Icon(
              Icons.error,
              color: Colors.white,
            ),
            borderRadius: 0.0,
            margin: EdgeInsets.zero,
          );
        }

        if (state is ChangePasswordSuccessState) {
          Get.back();
          Get.snackbar(
            "Berhasil",
            "Kata sandimu berhasil diubah.",
            backgroundColor: Colors.green,
            colorText: Colors.white,
            icon: Icon(
              Icons.check,
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
      },
      child: Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          title: Text("Ubah Kata Sandi"),
          centerTitle: true,
          actions: [
            BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
              builder: (context, state) {
                if (state is ChangePasswordLoadingState) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Loading(
                      size: 20.0,
                      color: Colors.white,
                      width: 3.0,
                    ),
                  );
                } else {
                  return IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () => _changePassword(context),
                  );
                }
              },
            ),
          ],
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formState,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            physics: BouncingScrollPhysics(),
            children: [
              _buildFormField(
                title: "Kata Sandi Lama",
                controller: _oldPasswordController,
                action: TextInputAction.next,
                autoFocus: true,
                validator: (value) {
                  if (value!.isEmpty) return "Kata sandi lama harus diisi";
                  if (value.length < 8) return "Kata sandi minimal 8 karakter";
                  return null;
                },
              ),
              Divider(),
              _buildFormField(
                title: "Kata Sandi Baru",
                controller: _newPasswordController,
                action: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) return "Kata sandi baru harus diisi";
                  if (value.length < 8) return "Kata sandi minimal 8 karakter";
                  if (value != _confirmNewPasswordController.text.trim())
                    return "Kata sandi baru tidak sama";
                  return null;
                },
              ),
              Divider(),
              _buildFormField(
                title: "Konfirmasi Kata Sandi Baru",
                controller: _confirmNewPasswordController,
                action: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty)
                    return "Konfirmasi kata sandi baru harus diisi";
                  if (value.length < 8) return "Kata sandi minimal 8 karakter";
                  if (value != _newPasswordController.text.trim())
                    return "Kata sandi baru tidak sama";
                  return null;
                },
              ),
              BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
                builder: (context, state) {
                  return SwitchListTile(
                    title: Text("Tampilkan Kata Sandi"),
                    value: (state is PasswordInvisibleState) ? false : true,
                    onChanged: (bool) {
                      if (state is PasswordInvisibleState)
                        context.read<PasswordVisibilityCubit>().showPassword();
                      if (state is PasswordVisibleState)
                        context.read<PasswordVisibilityCubit>().hidePassword();
                    },
                    contentPadding: EdgeInsets.zero,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String title,
    required TextEditingController controller,
    required TextInputAction action,
    bool autoFocus = false,
    required String? Function(String?)? validator,
  }) =>
      BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
        builder: (context, state) {
          return TextFormField(
            autofocus: autoFocus,
            controller: controller,
            obscureText: (state is PasswordInvisibleState) ? true : false,
            textInputAction: action,
            decoration: InputDecoration(
              labelText: title,
              border: OutlineInputBorder(),
            ),
            validator: validator,
          );
        },
      );

  void _changePassword(BuildContext context) {
    if (_formState.currentState!.validate()) {
      final String oldPassword = _oldPasswordController.text.trim();
      final String newPassword = _newPasswordController.text.trim();
      context.read<ChangePasswordCubit>().change(oldPassword, newPassword);
    }
  }
}
