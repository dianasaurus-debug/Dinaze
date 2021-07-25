import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/cubit/get_wakif_data/get_wakif_data_cubit.dart';
import 'package:flutter_cash_waqf/cubit/logout/logout_cubit.dart';
import 'package:flutter_cash_waqf/cubit/upload_image/upload_image_cubit.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/view/widgets/green_button.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfileScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    context.read<GetWakifDataCubit>().get();
    return MultiBlocListener(
      listeners: [
        BlocListener<LogoutCubit, LogoutState>(
          listener: (context, state) async {
            if (state is LogoutSuccessState) {
              await FlutterSecureStorage().deleteAll();
              Get.offAllNamed('/boarding');
              context.read<LogoutCubit>().resetState();
            }
          },
        ),
        BlocListener<UploadImageCubit, UploadImageState>(
          listener: (context, state) {
            if (state is UploadImageSuccessState) {
              Navigator.pop(context);
              context.read<GetWakifDataCubit>().get();
            }

            if (state is UploadImageFailureState) {
              Navigator.pop(context);
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          centerTitle: true,
          title: Text(
            'Profil',
            style: TextStyle(
              color: Constant.bwiGreenColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: BlocBuilder<GetWakifDataCubit, GetWakifDataState>(
          builder: (context, state) {
            if (state is GetWakifDataSuccessState) {
              final _wakif = state.wakif;
              return ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GFAvatar(
                          backgroundImage: (_wakif.foto != null)
                              ? NetworkImage(
                                  "${Constant.imageUrlApi}/${_wakif.foto}")
                              : null,
                          radius: Get.width * 0.25,
                          foregroundColor: Constant.bwiGreenColor,
                          shape: GFAvatarShape.standard,
                        ),
                        Divider(),
                        Text(
                          _wakif.nama!,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _wakif.email!,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.zero,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildMenu(
                          FontAwesomeIcons.userEdit,
                          "Ubah Profil",
                          () => Get.toNamed('/edit-profile', arguments: _wakif),
                        ),
                        Divider(height: 0.0, color: Colors.grey),
                        _buildMenu(
                          FontAwesomeIcons.solidImage,
                          "Ubah Foto Profil",
                          () async => _selectImage(),
                        ),
                        Divider(height: 0.0, color: Colors.grey),
                        _buildMenu(
                          FontAwesomeIcons.lock,
                          "Ubah Kata Sandi",
                          () => Get.toNamed('/change-password'),
                        ),
                        Divider(height: 0.0, color: Colors.grey),
                        BlocBuilder<LogoutCubit, LogoutState>(
                          builder: (context, state) {
                            if (state is LogoutLoadingState) {
                              return Loading();
                            } else {
                              return _buildMenu(
                                FontAwesomeIcons.signOutAlt,
                                "Keluar",
                                () => context.read<LogoutCubit>().logout(),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is GetWakifDataFailureState) {
              return Text(state.message);
            } else {
              return Loading();
            }
          },
        ),
      ),
    );
  }

  ListTile _buildMenu(IconData icon, String name, Function() onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Constant.bwiGreenColor,
      ),
      title: Text(
        name,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Icon(Icons.chevron_right),
    );
  }

  void _selectImage() => showBarModalBottomSheet(
        context: _scaffoldKey.currentContext!,
        isDismissible: true,
        topControl: CloseButton(color: Colors.white),
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
              title: Text("Ambil Gambar dari Kamera"),
              onTap: () async {
                final _pickedFile =
                    await ImagePicker().getImage(source: ImageSource.camera);
                if (_pickedFile != null) {
                  Navigator.pop(context);
                  _cropImage(_pickedFile.path);
                }
              },
              contentPadding: EdgeInsets.zero,
            ),
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.solidImages,
                color: Constant.bwiGreenColor,
              ),
              title: Text("Pilih Gambar dari Galeri"),
              onTap: () async {
                final _pickedFile =
                    await ImagePicker().getImage(source: ImageSource.gallery);
                if (_pickedFile != null) {
                  Navigator.pop(context);
                  _cropImage(_pickedFile.path);
                }
              },
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      );

  _cropImage(String path) async {
    final _croppedImage = await ImageCropper.cropImage(
      sourcePath: path,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Potong Foto Profil",
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

    if (_croppedImage != null) _showUploadImageConfirmation(_croppedImage.path);
  }

  _showUploadImageConfirmation(String path) => showBarModalBottomSheet(
        context: _scaffoldKey.currentState!.context,
        isDismissible: true,
        topControl: CloseButton(color: Colors.white),
        builder: (context) => ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(15.0),
          physics: NeverScrollableScrollPhysics(),
          children: [
            Text(
              "Ubah Foto Profil?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(),
            GFAvatar(
              backgroundImage: FileImage(File(path)),
              radius: Get.width * 0.25,
              shape: GFAvatarShape.standard,
            ),
            Divider(),
            BlocBuilder<UploadImageCubit, UploadImageState>(
              builder: (context, state) {
                if (state is UploadImageLoadingState) {
                  return Loading();
                } else {
                  return GreenButton(
                    text: "Unggah Foto",
                    onPressedFunction: () =>
                        context.read<UploadImageCubit>().upload(path),
                  );
                }
              },
            ),
          ],
        ),
      );
}
