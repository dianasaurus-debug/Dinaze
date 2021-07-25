import 'dart:convert';
import 'package:flutter_cash_waqf/services/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cash_waqf/utilities/constant.dart';

class RiwayatWakafService extends BaseService {
  final _url = "${Constant.urlApi}/riwayat-wakaf/";

  Future<dynamic> getAll() async {
    try {
      final _response = await http.get(
        Uri.parse(_url),
        headers: {
          "x-access-token": await getToken(),
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getByProgram(int id) async {
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
