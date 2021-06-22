import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/firebase_auth/firebase_auth_cubit.dart';
import 'package:flutter_cash_waqf/view/widgets/green_button.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:get/get.dart';

class BoardingScreen extends StatelessWidget {
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

        if (state is FirebaseAuthNotRegisteredState) {
          Get.toNamed('/create-password');
        }

        if (state is FirebaseAuthRegisteredState) {
          Get.offAllNamed('/main-page');
        }
      },
      child: Scaffold(
        body: Center(
          child: BlocBuilder<FirebaseAuthCubit, FirebaseAuthState>(
            builder: (context, state) {
              if (state is FirebaseAuthLoadingState) {
                return Loading();
              } else {
                return ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Image.asset(
                      'images/bwi-logo-2.png',
                    ),
                    Divider(),
                    GreenButton(
                      text: "Registrasi",
                      onPressedFunction: () => Get.toNamed('/register'),
                    ),
                    Divider(),
                    GreenButton(
                      text: "Masuk",
                      onPressedFunction: () => Get.toNamed('/login'),
                    ),
                    Divider(),
                    GreenButton(
                      text: "Autentikasi dengan Akun Google",
                      onPressedFunction: () =>
                          context.read<FirebaseAuthCubit>().getUserData(),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
