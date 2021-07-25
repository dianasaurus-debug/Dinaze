import 'dart:convert';
import 'package:flutter_cash_waqf/model/wakaf_berjangka.dart';
import 'package:flutter_cash_waqf/services/base_service.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:http/http.dart' as http;

class WakafBerjangkaService extends BaseService {
  final String _url = "${Constant.urlApi}/wakaf-berjangka";

  Future<dynamic> create(WakafBerjangka wakafBerjangka) async {
    try {
      final _response = await http.post(
        Uri.parse(_url),
        headers: {
          "Content-Type": "application/json",
          "x-access-token": await getToken(),
        },
        body: jsonEncode({
          'program_wakaf_id': wakafBerjangka.programWakafId,
          'nominal': wakafBerjangka.nominal,
          'nama_wakif': wakafBerjangka.namaWakif,
          'jenis_pembayaran': wakafBerjangka.jenisPembayaran,
          'metode_pembayaran': wakafBerjangka.metodePembayaran,
          'jangka_waktu': wakafBerjangka.jangkaWaktu,
          'nama_bank': wakafBerjangka.namaBank,
          'nomor_rekening': wakafBerjangka.nomorRekening,
          'nama_pemilik_rekening': wakafBerjangka.namaPemilikRekening,
        }),
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getById(String id) async {
    try {
      final _response = await http.get(
        Uri.parse("$_url/$id"),
        headers: {
          "x-access-token": await getToken(),
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }
}
