import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cash_waqf/cubit/create_wakaf_abadi/create_wakaf_abadi_cubit.dart';
import 'package:flutter_cash_waqf/cubit/create_wakaf_berjangka/create_wakaf_berjangka_cubit.dart';
import 'package:flutter_cash_waqf/cubit/payment_method/payment_method_cubit.dart';
import 'package:flutter_cash_waqf/cubit/waqf_on_behalf_of/waqf_on_behalf_of_cubit.dart';
import 'package:flutter_cash_waqf/cubit/waqf_type/waqf_type_cubit.dart';
import 'package:flutter_cash_waqf/model/program_wakaf.dart';
import 'package:flutter_cash_waqf/model/wakaf_abadi.dart';
import 'package:flutter_cash_waqf/model/wakaf_berjangka.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/utilities/extensions.dart';
import 'package:flutter_cash_waqf/view/widgets/green_button.dart';
import 'package:flutter_cash_waqf/view/widgets/loading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class WaqfFormScreen extends StatefulWidget {
  @override
  _WaqfFormScreenState createState() => _WaqfFormScreenState();
}

class _WaqfFormScreenState extends State<WaqfFormScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formState = GlobalKey<FormState>();
  final ProgramWakaf programWakaf = Get.arguments as ProgramWakaf;
  final _waqfNominalController = TextEditingController();
  final _wakifNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _accountNameController = TextEditingController();
  late int _waqfPeriod;
  late String _bankRefund;

  @override
  void initState() {
    super.initState();
    context.read<WaqfTypeCubit>().resetState();
    context.read<WaqfOnBehalfOfCubit>().resetState();
    context.read<PaymentMethodCubit>().resetState();
    context.read<CreateWakafAbadiCubit>().resetState();
    context.read<CreateWakafBerjangkaCubit>().resetState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateWakafAbadiCubit, CreateWakafAbadiState>(
          listener: (context, state) {
            if (state is CreateWakafAbadiFailureState) {
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
            } else if (state is CreateWakafAbadiSuccessState) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                dismissOnBackKeyPress: false,
                dismissOnTouchOutside: false,
                buttonsBorderRadius: BorderRadius.circular(5),
                headerAnimationLoop: false,
                title: "Berhasil",
                desc: "Transaksi wakaf uang abadi berhasil dibuat.",
                btnOkOnPress: () => Get.offNamedUntil(
                    '/wakaf-abadi-receipt', ModalRoute.withName('/main-page'),
                    arguments: state.wakafAbadi.id),
                btnOkText: "Oke",
              ).show();
            }
          },
        ),
        BlocListener<CreateWakafBerjangkaCubit, CreateWakafBerjangkaState>(
          listener: (context, state) {
            if (state is CreateWakafBerjangkaFailureState) {
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
            } else if (state is CreateWakafBerjangkaSuccessState) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.SUCCES,
                animType: AnimType.BOTTOMSLIDE,
                dismissOnBackKeyPress: false,
                dismissOnTouchOutside: false,
                buttonsBorderRadius: BorderRadius.circular(5),
                headerAnimationLoop: false,
                title: "Berhasil",
                desc: "Transaksi wakaf uang berjangka berhasil dibuat.",
                btnOkOnPress: () => Get.offNamedUntil(
                    '/wakaf-berjangka-receipt',
                    ModalRoute.withName('/main-page'),
                    arguments: state.wakafBerjangka.id),
                btnOkText: "Oke",
              ).show();
            }
          },
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Formulir Wakaf Uang"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back_ios),
            padding: EdgeInsets.zero,
            color: Colors.white,
          ),
        ),
        body: Form(
          key: _formState,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(15.0),
            physics: BouncingScrollPhysics(),
            children: [
              TextFormField(
                controller: _waqfNominalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Nominal Wakaf Uang",
                  border: OutlineInputBorder(),
                  prefixText: 'Rp',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) return 'Nominal wakaf harus diisi';
                  return null;
                },
              ),
              Divider(),
              _buildFormTitle("Jenis Wakaf Uang"),
              BlocBuilder<WaqfTypeCubit, WaqfTypeState>(
                builder: (context, state) {
                  final _waqfTypeCubit = context.read<WaqfTypeCubit>();
                  return Wrap(
                    spacing: 10.0,
                    children: [
                      ChoiceChip(
                        padding: EdgeInsets.all(10.0),
                        label: Text("Wakaf Abadi"),
                        selected:
                            (state is TimelessWaqfTypeState) ? true : false,
                        onSelected: (_) => _waqfTypeCubit.selectTimelessWaqf(),
                      ),
                      ChoiceChip(
                        padding: EdgeInsets.all(10.0),
                        label: Text("Wakaf Berjangka"),
                        selected: (state is TimedWaqfTypeState) ? true : false,
                        onSelected: (_) => _waqfTypeCubit.selectTimedWaqf(),
                      ),
                    ],
                  );
                },
              ),
              BlocBuilder<WaqfTypeCubit, WaqfTypeState>(
                builder: (context, state) {
                  if (state is TimedWaqfTypeState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DropdownButtonFormField(
                              items: [1, 2, 3, 4, 5].map((value) {
                                return DropdownMenuItem(
                                  child: Text("${value.toString()} tahun"),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) =>
                                  _waqfPeriod = int.parse(value.toString()),
                              validator: (value) {
                                if (value == null)
                                  return 'Jangka waktu wakaf harus dipilih';
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Pilih Jangka Waktu Wakaf",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Divider(),
                            DropdownButtonFormField(
                              items: ["BCA", "BNI", "Mandiri", "BRI", "BTN"]
                                  .map((value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) =>
                                  _bankRefund = value.toString(),
                              validator: (value) {
                                if (value == null)
                                  return 'Bank pengembalian dana harus dipilih';
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Pilih Bank Pengembalian Dana",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            Divider(),
                            TextFormField(
                              controller: _accountNumberController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Nomor Rekening",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Nomor rekening harus diisi';
                                return null;
                              },
                            ),
                            Divider(),
                            TextFormField(
                              controller: _accountNameController,
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              maxLength: 30,
                              maxLines: 1,
                              decoration: InputDecoration(
                                labelText: "Nama Pemilik Rekening",
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'Nama pemilik rekening harus diisi';
                                if (value.length > 30)
                                  return 'Nama pemilik rekening maksimal 30 karakter';
                                return null;
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Container(width: 0.0, height: 0.0);
                  }
                },
              ),
              Divider(),
              _buildFormTitle("Berwakaf Atas Nama"),
              BlocBuilder<WaqfOnBehalfOfCubit, WaqfOnBehalfOfState>(
                builder: (context, state) {
                  final _waqfOnBehalfOfCubit =
                      context.read<WaqfOnBehalfOfCubit>();
                  return Wrap(
                    spacing: 10.0,
                    children: [
                      ChoiceChip(
                        padding: EdgeInsets.all(10.0),
                        label: Text("Diri Sendiri"),
                        selected:
                            (state is WaqfOnBehalfOfOwnState) ? true : false,
                        onSelected: (_) =>
                            _waqfOnBehalfOfCubit.selectOnBehalfOfOwn(),
                      ),
                      ChoiceChip(
                        padding: EdgeInsets.all(10.0),
                        label: Text("Orang Lain"),
                        selected:
                            (state is WaqfOnBehalfOfOtherState) ? true : false,
                        onSelected: (_) =>
                            _waqfOnBehalfOfCubit.selectOnBehalfOfOther(),
                      ),
                    ],
                  );
                },
              ),
              BlocBuilder<WaqfOnBehalfOfCubit, WaqfOnBehalfOfState>(
                builder: (context, state) {
                  if (state is WaqfOnBehalfOfOtherState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Divider(),
                        TextFormField(
                          controller: _wakifNameController,
                          keyboardType: TextInputType.name,
                          maxLines: 1,
                          maxLength: 30,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            labelText: 'Nama Wakif',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) return 'Nama wakif harus diisi';
                            return null;
                          },
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildFormTitle("Metode Pembayaran"),
                  GestureDetector(
                    onTap: () => _showPaymentMethods(),
                    child: Text(
                      "Lihat Semua",
                      style: TextStyle(color: Constant.bwiGreenColor),
                    ),
                  ),
                ],
              ),
              BlocBuilder<PaymentMethodCubit, PaymentMethodState>(
                builder: (context, state) {
                  if (state is PaymentMethodSelectedState) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.asset(
                        'images/${state.code}.png',
                        height: 50,
                        width: 50,
                      ),
                      title: Text(state.code.toPaymentMethodDisplay()),
                    );
                  } else {
                    return Container(width: 0.0, height: 0.0);
                  }
                },
              ),
              Divider(),
              GreenButton(
                text: "Lanjutkan",
                onPressedFunction: () async {
                  if (_validator()) {
                    if (_formState.currentState!.validate()) {
                      _showConfirmation();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormTitle(String title) => Text(title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18.0,
      ));

  _getNamaWakif() async {
    final _waqfOnBehalfOfState =
        _scaffoldKey.currentContext!.read<WaqfOnBehalfOfCubit>().state;
    final _storage = FlutterSecureStorage();

    if (_waqfOnBehalfOfState is WaqfOnBehalfOfOtherState)
      return _wakifNameController.text.trim();
    else
      return await _storage.read(key: 'name');
  }

  String _getPaymentMethodType() {
    final _paymentMethodState =
        _scaffoldKey.currentContext!.read<PaymentMethodCubit>().state;
    return (_paymentMethodState as PaymentMethodSelectedState).type;
  }

  String _getPaymentMethodCode() {
    final _paymentMethodState =
        _scaffoldKey.currentContext!.read<PaymentMethodCubit>().state;
    return (_paymentMethodState as PaymentMethodSelectedState).code;
  }

  Future<WakafAbadi> _createWakafAbadi() async {
    return WakafAbadi(
      programWakafId: programWakaf.id,
      nominal: int.parse(_waqfNominalController.text.trim()),
      namaWakif: await _getNamaWakif(),
      jenisPembayaran: _getPaymentMethodType(),
      metodePembayaran: _getPaymentMethodCode(),
    );
  }

  Future<WakafBerjangka> _createWakafBerjangka() async {
    return WakafBerjangka(
      programWakafId: programWakaf.id,
      nominal: int.parse(_waqfNominalController.text.trim()),
      namaWakif: await _getNamaWakif(),
      jenisPembayaran: _getPaymentMethodType(),
      metodePembayaran: _getPaymentMethodCode(),
      jangkaWaktu: _waqfPeriod,
      namaBank: _bankRefund,
      nomorRekening: _accountNumberController.text.trim(),
      namaPemilikRekening: _accountNameController.text.trim(),
    );
  }

  bool _validator() {
    final _waqfTypeState =
        _scaffoldKey.currentContext!.read<WaqfTypeCubit>().state;
    final _waqfOnBehalfOfState =
        _scaffoldKey.currentContext!.read<WaqfOnBehalfOfCubit>().state;
    final _paymentMethodState =
        _scaffoldKey.currentContext!.read<PaymentMethodCubit>().state;

    if (_waqfTypeState is WaqfTypeInitialState) {
      AwesomeDialog(
        context: _scaffoldKey.currentContext!,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        autoHide: Duration(seconds: 10),
        buttonsBorderRadius: BorderRadius.circular(5),
        headerAnimationLoop: false,
        title: "Gagal",
        desc: "Anda belum memilih jenis wakaf uang.",
        btnCancelOnPress: () {},
        btnCancelText: "Tutup",
      ).show();
      return false;
    } else if (_waqfOnBehalfOfState is WaqfOnBehalfOfInitialState) {
      AwesomeDialog(
        context: _scaffoldKey.currentContext!,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        autoHide: Duration(seconds: 10),
        buttonsBorderRadius: BorderRadius.circular(5),
        headerAnimationLoop: false,
        title: "Gagal",
        desc: "Anda belum memilih atas nama wakaf.",
        btnCancelOnPress: () {},
        btnCancelText: "Tutup",
      ).show();
      return false;
    } else if (_paymentMethodState is PaymentMethodInitialState) {
      AwesomeDialog(
        context: _scaffoldKey.currentContext!,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        dismissOnBackKeyPress: false,
        dismissOnTouchOutside: false,
        autoHide: Duration(seconds: 10),
        buttonsBorderRadius: BorderRadius.circular(5),
        headerAnimationLoop: false,
        title: "Gagal",
        desc: "Anda belum memilih metode pembayaran.",
        btnCancelOnPress: () {},
        btnCancelText: "Tutup",
      ).show();
      return false;
    } else {
      return true;
    }
  }

  void _showPaymentMethods() => showBarModalBottomSheet(
        context: _scaffoldKey.currentContext!,
        isDismissible: true,
        topControl: Material(
          borderRadius: BorderRadius.circular(50.0),
          child: CloseButton(color: Colors.black),
        ),
        builder: (context) => ListView(
          padding: EdgeInsets.all(15.0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Text(
              "Pilih Metode Pembayaran",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(color: Colors.black),
            _buildPaymentMethodListTile(
                "bca", () => _selectPaymentMethod("bank", "bca")),
            _buildPaymentMethodListTile(
                "bri", () => _selectPaymentMethod("bank", "bri")),
            _buildPaymentMethodListTile(
                "bni", () => _selectPaymentMethod("bank", "bni")),
            _buildPaymentMethodListTile(
                "qris", () => _selectPaymentMethod("qris", "qris")),
            _buildPaymentMethodListTile(
                "indomaret", () => _selectPaymentMethod("cstore", "indomaret")),
            _buildPaymentMethodListTile(
                "alfamart", () => _selectPaymentMethod("cstore", "alfamart")),
          ],
        ),
      );

  Widget _buildPaymentMethodListTile(String code, Function() onTap) => ListTile(
        onTap: onTap,
        leading: Image.asset(
          'images/$code.png',
          height: 50,
          width: 50,
        ),
        title: Text(code.toPaymentMethodDisplay()),
        trailing: Icon(Icons.chevron_right),
        contentPadding: EdgeInsets.zero,
      );

  void _selectPaymentMethod(String type, String code) {
    _scaffoldKey.currentContext!.read<PaymentMethodCubit>().select(type, code);
    Get.back();
  }

  Widget _buildConfirmationRow(String title, String data) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
          Text(
            data,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
          Divider(),
        ],
      );

  _showConfirmation() {
    final _waqfTypeState =
        _scaffoldKey.currentContext!.read<WaqfTypeCubit>().state;

    showBarModalBottomSheet(
      context: _scaffoldKey.currentContext!,
      isDismissible: true,
      topControl: Material(
        borderRadius: BorderRadius.circular(50.0),
        child: CloseButton(color: Colors.black),
      ),
      builder: (context) => ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(15.0),
        children: [
          Text(
            "Konfirmasi Data Transaksi Wakaf",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          _buildConfirmationRow("Program Wakaf", programWakaf.judul!),
          _buildConfirmationRow("Nominal Wakaf",
              int.parse(_waqfNominalController.text.trim()).toRupiahFormat()),
          _buildConfirmationRow("Metode Pembayaran",
              _getPaymentMethodCode().toPaymentMethodDisplay()),
          FutureBuilder(
            future: _getNamaWakif(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return _buildConfirmationRow(
                    "Nama Wakif", snapshot.data.toString());
              } else {
                return Container(width: 0.0, height: 0.0);
              }
            },
          ),
          _buildConfirmationRow(
              "Jenis Wakaf Uang",
              (_waqfTypeState is TimelessWaqfTypeState)
                  ? "Wakaf Abadi"
                  : "Wakaf Berjangka"),
          if (_waqfTypeState is TimedWaqfTypeState) ...[
            _buildConfirmationRow("Jangka Waktu", "$_waqfPeriod tahun"),
            _buildConfirmationRow("Bank Pengembalian", _bankRefund),
            _buildConfirmationRow(
                "Nomor Rekening", _accountNumberController.text.trim()),
            _buildConfirmationRow(
                "Nama Pemilik Rekening", _accountNameController.text.trim()),
          ],
          Builder(
            builder: (context) {
              final wakafAbadiState =
                  context.watch<CreateWakafAbadiCubit>().state;
              final wakafBerjangkaState =
                  context.watch<CreateWakafBerjangkaCubit>().state;

              if (wakafAbadiState is CreateWakafAbadiLoadingState ||
                  wakafBerjangkaState is CreateWakafBerjangkaLoadingState) {
                return Loading(size: 30.0);
              } else if (wakafAbadiState is CreateWakafAbadiSuccessState ||
                  wakafBerjangkaState is CreateWakafBerjangkaSuccessState) {
                return Container();
              } else {
                return GreenButton(
                  text: "Bayar",
                  onPressedFunction: () async {
                    if (_waqfTypeState is TimelessWaqfTypeState) {
                      context
                          .read<CreateWakafAbadiCubit>()
                          .create(await _createWakafAbadi());
                    } else if (_waqfTypeState is TimedWaqfTypeState) {
                      context
                          .read<CreateWakafBerjangkaCubit>()
                          .create(await _createWakafBerjangka());
                    }
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}
