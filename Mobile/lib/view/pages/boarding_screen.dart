import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/face_detection_cubit.dart';
import 'package:flutter_cash_waqf/cubit/firebase_auth/firebase_auth_cubit.dart';
import 'package:flutter_cash_waqf/view/widgets/green_button.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BoardingScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FirebaseAuthCubit, FirebaseAuthState>(
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
        ),
        BlocListener<FaceDetectionCubit, FaceDetectionState>(
          listener: (context, state) {
            if (state is FaceDetectionFailureState) {
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

            if (state is FaceDetectionSuccessState) {
              Get.toNamed('/register');
            }
          },
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        body: Center(
          child: Builder(
            builder: (context) {
              final firebaseAuthState =
                  context.watch<FirebaseAuthCubit>().state;
              final faceDetectionState =
                  context.watch<FaceDetectionCubit>().state;

              if (firebaseAuthState is FirebaseAuthLoadingState ||
                  faceDetectionState is FaceDetectionLoadingState) {
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

  void _showKycPopup() => AwesomeDialog(
        context: _scaffoldKey.currentContext!,
        dialogType: DialogType.INFO_REVERSED,
        animType: AnimType.BOTTOMSLIDE,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        buttonsBorderRadius: BorderRadius.circular(5),
        headerAnimationLoop: false,
        title: "KYC (Know Your Customer)",
        desc:
            "Ambil gambar dengan pose mata kiri tertutup dan mata kanan terbuka",
        btnOkText: "Oke",
        btnOkOnPress: () => _detectFace(),
      ).show();

  _detectFace() async {
    final image = await ImagePicker().getImage(source: ImageSource.camera);

    if (image != null) {
      _scaffoldKey.currentContext!
          .read<FaceDetectionCubit>()
          .detectFace(image.path);
    } else {
      AwesomeDialog(
        context: _scaffoldKey.currentContext!,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        buttonsBorderRadius: BorderRadius.circular(5),
        headerAnimationLoop: false,
        title: "Gagal",
        desc: "Anda belum mengambil gambar",
        btnCancelText: "Oke",
        btnCancelOnPress: () {},
      ).show();
    }
  }
}
