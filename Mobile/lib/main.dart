import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cash_waqf/cubit/ktp_ocr/ktp_ocr_cubit.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:flutter_cash_waqf/utilities/routes.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_cash_waqf/cubit/change_password/change_password_cubit.dart';
import 'package:flutter_cash_waqf/cubit/create_wakaf_abadi/create_wakaf_abadi_cubit.dart';
import 'package:flutter_cash_waqf/cubit/create_wakaf_berjangka/create_wakaf_berjangka_cubit.dart';
import 'package:flutter_cash_waqf/cubit/display_category/display_category_cubit.dart';
import 'package:flutter_cash_waqf/cubit/get_laporan/get_laporan_cubit.dart';
import 'package:flutter_cash_waqf/cubit/get_wakaf_abadi/get_wakaf_abadi_cubit.dart';
import 'package:flutter_cash_waqf/cubit/get_wakaf_berjangka/get_wakaf_berjangka_cubit.dart';
import 'package:flutter_cash_waqf/cubit/get_wakif/get_wakif_cubit.dart';
import 'package:flutter_cash_waqf/cubit/get_wakif_data/get_wakif_data_cubit.dart';
import 'package:flutter_cash_waqf/cubit/login/login_cubit.dart';
import 'package:flutter_cash_waqf/cubit/login_check/login_check_cubit.dart';
import 'package:flutter_cash_waqf/cubit/logout/logout_cubit.dart';
import 'package:flutter_cash_waqf/cubit/password_visibility/password_visibility_cubit.dart';
import 'package:flutter_cash_waqf/cubit/payment_method/payment_method_cubit.dart';
import 'package:flutter_cash_waqf/cubit/register/register_cubit.dart';
import 'package:flutter_cash_waqf/cubit/reset_password/request_reset_password_cubit.dart';
import 'package:flutter_cash_waqf/cubit/reset_password/reset_password_cubit.dart';
import 'package:flutter_cash_waqf/cubit/reset_password/verify_reset_password_token_cubit.dart';
import 'package:flutter_cash_waqf/cubit/riwayat_wakaf/riwayat_wakaf_cubit.dart';
import 'package:flutter_cash_waqf/cubit/search_waqf_program/search_waqf_program_cubit.dart';
import 'package:flutter_cash_waqf/cubit/single_waqf_program/single_waqf_program_cubit.dart';
import 'package:flutter_cash_waqf/cubit/update_wakif_data/update_wakif_data_cubit.dart';
import 'package:flutter_cash_waqf/cubit/upload_image/upload_image_cubit.dart';
import 'package:flutter_cash_waqf/cubit/waqf_on_behalf_of/waqf_on_behalf_of_cubit.dart';
import 'package:flutter_cash_waqf/cubit/waqf_program/waqf_program_cubit.dart';
import 'package:flutter_cash_waqf/cubit/waqf_program_by_category/waqf_program_by_category_cubit.dart';
import 'package:flutter_cash_waqf/cubit/waqf_type/waqf_type_cubit.dart';
import 'package:flutter_cash_waqf/services/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.shared.setAppId(oneSignalAppId);
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    OneSignal.shared.setNotificationOpenedHandler((result) {
      final _data = result.notification.additionalData;
      if (_data?['jenis_wakaf'] == "Abadi") {
        Get.toNamed('/wakaf-abadi-receipt', arguments: _data?['id']);
      }

      if (_data?['jenis_wakaf'] == "Berjangka") {
        Get.toNamed('/wakaf-berjangka-receipt', arguments: _data?['id']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginCheckCubit()),
        BlocProvider(create: (_) => RegisterCubit(AuthService())),
        BlocProvider(create: (_) => LoginCubit(AuthService())),
        BlocProvider(create: (_) => LogoutCubit()),
        BlocProvider(create: (_) => GetWakifDataCubit()),
        BlocProvider(create: (_) => UpdateWakifDataCubit()),
        BlocProvider(create: (_) => DisplayCategoryCubit()),
        BlocProvider(create: (_) => WaqfProgramCubit()),
        BlocProvider(create: (_) => SingleWaqfProgramCubit()),
        BlocProvider(create: (_) => WaqfProgramByCategoryCubit()),
        BlocProvider(create: (_) => GetWakifCubit()),
        BlocProvider(create: (_) => PasswordVisibilityCubit()),
        BlocProvider(create: (_) => WaqfTypeCubit()),
        BlocProvider(create: (_) => WaqfOnBehalfOfCubit()),
        BlocProvider(create: (_) => PaymentMethodCubit()),
        BlocProvider(create: (_) => CreateWakafAbadiCubit()),
        BlocProvider(create: (_) => CreateWakafBerjangkaCubit()),
        BlocProvider(create: (_) => RiwayatWakafCubit()),
        BlocProvider(create: (_) => GetWakafAbadiCubit()),
        BlocProvider(create: (_) => GetWakafBerjangkaCubit()),
        BlocProvider(create: (_) => ChangePasswordCubit()),
        BlocProvider(create: (_) => SearchWaqfProgramCubit()),
        BlocProvider(create: (_) => RequestResetPasswordCubit()),
        BlocProvider(create: (_) => VerifyResetPasswordTokenCubit()),
        BlocProvider(create: (_) => ResetPasswordCubit()),
        BlocProvider(create: (_) => UploadImageCubit()),
        BlocProvider(create: (_) => GetLaporanCubit()),
        BlocProvider(create: (_) => KtpOcrCubit()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: bwiGreenColor,
          ),
          primarySwatch: generateMaterialColor(bwiGreenColor),
          fontFamily: 'Poppins',
          dividerTheme: DividerThemeData(
            thickness: 0.0,
            space: 10.0,
            color: Colors.transparent,
          ),
        ),
        getPages: routes,
        initialRoute: '/wrapper',
      ),
    );
  }

  MaterialColor generateMaterialColor(Color color) {
    return MaterialColor(color.value, {
      50: tintColor(color, 0.9),
      100: tintColor(color, 0.8),
      200: tintColor(color, 0.6),
      300: tintColor(color, 0.4),
      400: tintColor(color, 0.2),
      500: color,
      600: shadeColor(color, 0.1),
      700: shadeColor(color, 0.2),
      800: shadeColor(color, 0.3),
      900: shadeColor(color, 0.4),
    });
  }

  int tintValue(int value, double factor) =>
      max(0, min((value + ((255 - value) * factor)).round(), 255));

  Color tintColor(Color color, double factor) => Color.fromRGBO(
      tintValue(color.red, factor),
      tintValue(color.green, factor),
      tintValue(color.blue, factor),
      1);

  int shadeValue(int value, double factor) =>
      max(0, min(value - (value * factor).round(), 255));

  Color shadeColor(Color color, double factor) => Color.fromRGBO(
      shadeValue(color.red, factor),
      shadeValue(color.green, factor),
      shadeValue(color.blue, factor),
      1);
}
