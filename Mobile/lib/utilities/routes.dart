import 'package:flutter_cash_waqf/view/pages/auth/change_password_screen.dart';
import 'package:flutter_cash_waqf/view/pages/auth/login_screen.dart';
import 'package:flutter_cash_waqf/view/pages/auth/register_screen.dart';
import 'package:flutter_cash_waqf/view/pages/boarding_screen.dart';
import 'package:flutter_cash_waqf/view/pages/edit_profile_screen.dart';
import 'package:flutter_cash_waqf/view/pages/laporan_screen.dart';
import 'package:flutter_cash_waqf/view/pages/main_screen.dart';
import 'package:flutter_cash_waqf/view/pages/pdf_viewer.dart';
import 'package:flutter_cash_waqf/view/pages/receipt/wakaf_abadi_receipt_screen.dart';
import 'package:flutter_cash_waqf/view/pages/receipt/wakaf_berjangka_receipt_screen.dart';
import 'package:flutter_cash_waqf/view/pages/reset_password/request_reset_password_screen.dart';
import 'package:flutter_cash_waqf/view/pages/reset_password/reset_password_screen.dart';
import 'package:flutter_cash_waqf/view/pages/reset_password/verify_token_screen.dart';
import 'package:flutter_cash_waqf/view/pages/search_waqf_program.dart';
import 'package:flutter_cash_waqf/view/pages/wakif_list_screen.dart';
import 'package:flutter_cash_waqf/view/pages/waqf_form.dart';
import 'package:flutter_cash_waqf/view/pages/waqf_program_category_screen.dart';
import 'package:flutter_cash_waqf/view/pages/waqf_program_screen.dart';
import 'package:flutter_cash_waqf/view/pages/wrapper.dart';
import 'package:get/get.dart';

final routes = [
  GetPage(
    name: '/wrapper',
    page: () => Wrapper(),
  ),
  GetPage(
    name: '/boarding',
    page: () => BoardingScreen(),
  ),
  GetPage(
    name: '/register',
    page: () => RegisterScreen(),
  ),
  GetPage(
    name: '/login',
    page: () => LoginScreen(),
  ),
  GetPage(
    name: '/forgot-password',
    page: () => RequestResetPasswordScreen(),
  ),
  GetPage(
    name: '/verify-reset-password-token',
    page: () => VerifyTokenScreen(),
  ),
  GetPage(
    name: '/reset-password',
    page: () => ResetPasswordScreen(),
  ),
  GetPage(
    name: '/main-page',
    page: () => MainScreen(),
  ),
  GetPage(
    name: '/search-waqf-program',
    page: () => SearchWaqfProgram(),
  ),
  GetPage(
    name: '/waqf-program',
    page: () => WaqfProgramScreen(),
  ),
  GetPage(
    name: '/waqf-program-category',
    page: () => WaqfProgramCategoryScreen(),
  ),
  GetPage(
    name: '/wakif-list',
    page: () => WakifListScreen(),
  ),
  GetPage(
    name: '/laporan',
    page: () => LaporanScreen(),
  ),
  GetPage(
    name: '/waqf-form',
    page: () => WaqfFormScreen(),
  ),
  GetPage(
    name: '/wakaf-abadi-receipt',
    page: () => WakafAbadiReceiptScreen(),
  ),
  GetPage(
    name: '/wakaf-berjangka-receipt',
    page: () => WakafBerjangkaReceiptScreen(),
  ),
  GetPage(
    name: '/edit-profile',
    page: () => EditProfileScreen(),
  ),
  GetPage(
    name: '/change-password',
    page: () => ChangePasswordScreen(),
  ),
  GetPage(
    name: '/pdf-viewer',
    page: () => PDFViewerScreen(),
  ),
];
