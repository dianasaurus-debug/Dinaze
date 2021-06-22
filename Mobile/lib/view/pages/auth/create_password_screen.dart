import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/firebase_auth/firebase_auth_cubit.dart';
import 'package:flutter_cash_waqf/cubit/password_visibility/password_visibility_cubit.dart';
import 'package:flutter_cash_waqf/view/widgets/green_button.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:get/get.dart';

class CreatePasswordScreen extends StatefulWidget {
  @override
  _CreatePasswordScreen createState() => _CreatePasswordScreen();
}

class _CreatePasswordScreen extends State<CreatePasswordScreen> {
  final _formState = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<PasswordVisibilityCubit>().hidePassword();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FirebaseAuthCubit, FirebaseAuthState>(
      listener: (context, state) {
        if (state is FirebaseAuthFailureState) {
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
        }

        if (state is FirebaseAuthRegisteredState) {
          Get.offAllNamed('/main-page');
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
              "Atur Kata Sandi",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Buat kata sandi untuk akunmu!",
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
                    title: "Kata Sandi",
                    autoFocus: true,
                    controller: _passwordController,
                    action: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) return "Kata sandi harus diisi";
                      if (value.length < 8)
                        return "Kata sandi minimal 8 karakter";
                      if (value != _confirmPasswordController.text.trim())
                        return "Kata sandi tidak sama";
                      return null;
                    },
                  ),
                  Divider(),
                  _buildPasswordFormField(
                    title: "Konfirmasi Kata Sandi",
                    controller: _confirmPasswordController,
                    action: TextInputAction.send,
                    validator: (value) {
                      if (value!.isEmpty)
                        return "Konfirmasi kata sandi harus diisi";
                      if (value.length < 8)
                        return "Kata sandi minimal 8 karakter";
                      if (value != _passwordController.text.trim())
                        return "Kata sandi tidak sama";
                      return null;
                    },
                    onSubmit: (_) => _createPasswordAction(),
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
                  BlocBuilder<FirebaseAuthCubit, FirebaseAuthState>(
                    builder: (context, state) {
                      if (state is FirebaseAuthLoadingState) {
                        return Loading();
                      } else {
                        return GreenButton(
                          text: "Simpan Kata Sandi",
                          onPressedFunction: _createPasswordAction,
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
  }) {
    return BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
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
  }

  _createPasswordAction() {
    print("FUNCTION: _createPasswordAction()");
    final String _password = _passwordController.text.trim();
    context.read<FirebaseAuthCubit>().register(_password);
  }
}
