import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/ktp_ocr/ktp_ocr_cubit.dart';
import 'package:flutter_cash_waqf/cubit/password_visibility/password_visibility_cubit.dart';
import 'package:flutter_cash_waqf/cubit/register/register_cubit.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/view/widgets/green_button.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RegisterScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formState = GlobalKey<FormState>();
  final _nikController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterFailureState) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.BOTTOMSLIDE,
                dismissOnBackKeyPress: false,
                dismissOnTouchOutside: false,
                buttonsBorderRadius: BorderRadius.circular(5),
                headerAnimationLoop: false,
                title: "Gagal",
                desc: state.errorMessage,
                btnCancelOnPress: () {},
                btnCancelText: "Oke",
              ).show();
            }
            if (state is RegisterSuccessState) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                dismissOnBackKeyPress: false,
                dismissOnTouchOutside: false,
                buttonsBorderRadius: BorderRadius.circular(5),
                headerAnimationLoop: false,
                title: "Berhasil",
                desc: "Akunmu berhasil dibuat, silakan masuk.",
                btnOkOnPress: () => Get.offNamed('/login'),
                btnOkText: "Oke",
              ).show();
            }
          },
        ),
        BlocListener<KtpOcrCubit, KtpOcrState>(
          listener: (context, state) {
            if (state is KtpOcrSuccessState) {
              _nikController.text = state.nik;
              _nameController.text = state.name;
            }

            if (state is KtpOcrFailureState) {
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
          },
        )
      ],
      child: Scaffold(
        key: _scaffoldKey,
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
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          physics: BouncingScrollPhysics(),
          children: [
            Text(
              "Selamat Datang!",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Lengkapi data berikut untuk membuat akun.",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            Divider(),
            TextButton(
              child: Text("Unggah Foto KTP"),
              onPressed: () => _selectImageSource(),
            ),
            Divider(),
            Form(
              key: _formState,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  TextFormField(
                    controller: _nikController,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    maxLength: 16,
                    decoration: InputDecoration(
                      prefixIcon: Icon(FontAwesomeIcons.solidIdCard),
                      labelText: 'NIK',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return "NIK harus diisi";
                      if (value.length != 16) return "NIK harus 16 digit";
                      return null;
                    },
                  ),
                  Divider(),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: 'Nama Lengkap',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Nama lengkap harus diisi!';
                      return null;
                    },
                  ),
                  Divider(),
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
                          ),
                        ),
                        onFieldSubmitted: (_) => _registerAction(),
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
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      if (state is RegisterLoadingState) {
                        return Loading(size: 30.0);
                      } else {
                        return GreenButton(
                          text: "DAFTAR",
                          onPressedFunction: () => _registerAction(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Divider(),
            TextButton(
              onPressed: () => Get.offNamed('/login'),
              child: Text(
                "Sudah punya akun? Masuk di sini!",
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

  _selectImageSource() {
    return showBarModalBottomSheet(
      context: _scaffoldKey.currentContext!,
      isDismissible: true,
      topControl: Material(
        borderRadius: BorderRadius.circular(50.0),
        child: CloseButton(color: Colors.black),
      ),
      builder: (context) => ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(15.0),
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.cameraRetro,
              color: Constant.bwiGreenColor,
            ),
            title: Text("Ambil dari Kamera"),
            onTap: () async {
              final file =
                  await ImagePicker().getImage(source: ImageSource.camera);

              if (file != null) {
                Get.back();
                _cropImage(file);
              }
            },
          ),
          ListTile(
            leading: FaIcon(
              FontAwesomeIcons.solidImages,
              color: Constant.bwiGreenColor,
            ),
            title: Text("Pilih dari Galeri"),
            onTap: () async {
              final file =
                  await ImagePicker().getImage(source: ImageSource.gallery);

              if (file != null) {
                Get.back();
                _cropImage(file);
              }
            },
          ),
        ],
      ),
    );
  }

  _cropImage(PickedFile file) async {
    final _croppedImage = await ImageCropper.cropImage(
      sourcePath: file.path,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Potong Foto KTP",
        toolbarColor: Constant.bwiGreenColor,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
        title: "Potong Foto KTP",
      ),
    );

    if (_croppedImage != null) {
      _scaffoldKey.currentContext!
          .read<KtpOcrCubit>()
          .startRecognize(_croppedImage.path);
    }
  }

  _registerAction() {
    if (_formState.currentState!.validate()) {
      String _name = _nameController.text.trim();
      String _email = _emailController.text.trim();
      String _password = _passwordController.text.trim();
      _scaffoldKey.currentContext!
          .read<RegisterCubit>()
          .tryRegister(_name, _email, _password);
    }
  }
}
