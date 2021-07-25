import 'dart:convert';
import 'package:flutter_cash_waqf/model/wakaf_abadi.dart';
import 'package:flutter_cash_waqf/services/base_service.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:http/http.dart' as http;

class WakafAbadiService extends BaseService {
  final String _url = "${Constant.urlApi}/wakaf-abadi";

  Future<dynamic> create(WakafAbadi wakafAbadi) async {
    try {
      final _response = await http.post(
        Uri.parse(_url),
        headers: {
          "Content-Type": "application/json",
          "x-access-token": await getToken(),
        },
        body: jsonEncode({
          'program_wakaf_id': wakafAbadi.programWakafId,
          'nominal': wakafAbadi.nominal,
          'nama_wakif': wakafAbadi.namaWakif,
          'jenis_pembayaran': wakafAbadi.jenisPembayaran,
          'metode_pembayaran': wakafAbadi.metodePembayaran,
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
