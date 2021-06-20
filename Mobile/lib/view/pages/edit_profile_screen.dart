import 'package:flutter/material.dart';
import 'package:flutter_cash_waqf/cubit/get_wakif_data/get_wakif_data_cubit.dart';
import 'package:flutter_cash_waqf/cubit/update_wakif_data/update_wakif_data_cubit.dart';
import 'package:flutter_cash_waqf/model/wakif.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  final Wakif _wakif = Get.arguments as Wakif;
  final _formState = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _nikController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;

  EditProfileScreen() {
    _nameController = TextEditingController(text: _wakif.nama);
    _emailController = TextEditingController(text: _wakif.email);
    _nikController = TextEditingController(text: _wakif.nik);
    _phoneController = TextEditingController(text: _wakif.nomorPonsel);
    _addressController = TextEditingController(text: _wakif.alamat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(),
        title: Text("Sunting Profil"),
        centerTitle: true,
        actions: [
          BlocBuilder<UpdateWakifDataCubit, UpdateWakifDataState>(
            builder: (context, state) {
              if (state is UpdateWakifDataLoadingState) {
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
                  onPressed: () {
                    if (_formState.currentState!.validate()) {
                      context
                          .read<UpdateWakifDataCubit>()
                          .update(_createWakif());
                    }
                  },
                );
              }
            },
          )
        ],
      ),
      body: BlocListener<UpdateWakifDataCubit, UpdateWakifDataState>(
        listener: (context, state) {
          if (state is UpdateWakifDataFailureState) {
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
          } else if (state is UpdateWakifDataSuccessState) {
            Get.back();
            context.read<GetWakifDataCubit>().get();
          }
        },
        child: Form(
          key: _formState,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            physics: BouncingScrollPhysics(),
            children: [
              TextFormField(
                controller: _nikController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                maxLength: 16,
                decoration: _inputDecoration("NIK"),
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
                decoration: _inputDecoration("Nama Lengkap"),
                validator: (value) {
                  if (value!.isEmpty) return "Nama lengkap harus diisi";
                  return null;
                },
              ),
              Divider(),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: _inputDecoration("Alamat Email"),
                validator: (value) {
                  if (value!.isEmpty) return "Alamat email harus diisi";
                  if (!value.isEmail) return "Alamat email tidak valid";
                  return null;
                },
              ),
              Divider(),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                maxLength: 13,
                decoration: _inputDecoration("Nomor Ponsel"),
                validator: (value) {
                  if (value!.isEmpty) return "Nomor ponsel harus diisi";
                  if (!value.startsWith('0'))
                    return "Nomor ponsel harus diawali angka 0";
                  return null;
                },
              ),
              Divider(),
              TextFormField(
                controller: _addressController,
                keyboardType: TextInputType.streetAddress,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                decoration: _inputDecoration("Alamat"),
                validator: (value) {
                  if (value!.isEmpty) return "Alamat harus diisi";
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _inputDecoration(String title) => InputDecoration(
        labelText: title,
        border: OutlineInputBorder(),
      );

  Wakif _createWakif() => Wakif(
        nik: _nikController.text.trim(),
        nama: _nameController.text.trim(),
        email: _emailController.text.trim(),
        nomorPonsel: _phoneController.text.trim(),
        alamat: _addressController.text.trim(),
      );
}
