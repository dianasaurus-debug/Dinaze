import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/cubit/login/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/password_visibility/password_visibility_cubit.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/view/widgets/green_button.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  final _formState = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailureState) {
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
          _passwordController.clear();
        }
        if (state is LoginSuccessState) {
          Get.offAllNamed('/main-page');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
        ),
        body: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          children: [
            Text(
              "Halo!",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Masukkan alamat surel dan kata sandi kamu.",
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
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
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
                  BlocBuilder<PasswordVisibilityCubit, PasswordVisibilityState>(
                    builder: (context, state) {
                      return TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.send,
                        obscureText:
                            (state is PasswordVisibleState) ? false : true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: 'Kata Sandi',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                (state is PasswordVisibleState)
                                    ? context
                                        .read<PasswordVisibilityCubit>()
                                        .hidePassword()
                                    : context
                                        .read<PasswordVisibilityCubit>()
                                        .showPassword();
                              },
                              icon: (state is PasswordVisibleState)
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                            )),
                        onFieldSubmitted: (_) => _loginAction(context),
                        validator: (value) {
                          if (value!.isEmpty) return 'Kata sandi harus diisi';
                          if (value.length < 8)
                            return 'Kata sandi minimal 8 karakter';
                          return null;
                        },
                      );
                    },
                  ),
                  Divider(),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoadingState) {
                        return Loading(size: 30.0);
                      } else {
                        return GreenButton(
                          text: "MASUK",
                          onPressedFunction: () => _loginAction(context),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            TextButton(
              onPressed: () => Get.offNamed('/register'),
              child: Text(
                "Belum punya akun? Daftar di sini!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Constant.bwiGreenColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Get.toNamed('/forgot-password'),
              child: Text(
                "Lupa Kata Sandi? Atur ulang di sini!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Constant.bwiGreenColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loginAction(BuildContext context) {
    if (_formState.currentState!.validate()) {
      String _email = _emailController.text.trim();
      String _password = _passwordController.text.trim();
      context.read<LoginCubit>().login(_email, _password);
    }
  }
}
