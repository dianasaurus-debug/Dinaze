import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

extension NumberExtension on int {
  String toRupiahFormat() {
    return NumberFormat.currency(
      locale: 'id',
      decimalDigits: 0,
      symbol: 'Rp',
    ).format(this);
  }
}

extension StringExtension on String {
  String toPaymentStatusDisplay() {
    if (this == 'success') {
      return "Pembayaran Sukses";
    } else if (this == 'pending') {
      return "Menunggu Pembayaran";
    } else if (this == 'failure') {
      return "Pembayaran Gagal";
    } else {
      return "Pembayaran Belum Selesai";
    }
  }

  String toPaymentMethodDisplay() {
    switch (this) {
      case 'bca':
        return 'BCA Virtual Account';
      case 'bni':
        return 'BNI Virtual Account';
      case 'bri':
        return 'BRI Virtual Account (BRIVA)';
      case 'qris':
        return 'QRIS';
      case 'indomaret':
        return 'Indomaret';
      case 'alfamart':
        return 'Alfamart';
      default:
        return 'Undefined';
    }
  }

  IconData toFontAwesomeIcon() {
    switch (this) {
      case 'Pendidikan':
        return FontAwesomeIcons.graduationCap;
      case 'Kesehatan':
        return FontAwesomeIcons.hospital;
      case 'Tempat Ibadah':
        return FontAwesomeIcons.mosque;
      case 'Umum':
        return FontAwesomeIcons.handsHelping;
      case 'Bencana':
        return FontAwesomeIcons.houseDamage;
      default:
        return FontAwesomeIcons.questionCircle;
    }
  }
}
