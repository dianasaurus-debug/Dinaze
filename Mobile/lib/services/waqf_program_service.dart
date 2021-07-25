import 'dart:convert';
import 'package:flutter_cash_waqf/services/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_cash_waqf/utilities/constant.dart';

class WaqfProgramService extends BaseService {
  final _url = "${Constant.urlApi}/program-wakaf";

  Future<dynamic> getAll() async {
    try {
      final _response = await http.get(
        Uri.parse("$_url/all"),
        headers: {
          'x-access-token': await getToken(),
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getSingle(int id) async {
    try {
      final _response = await http.get(
        Uri.parse("$_url/view/$id"),
        headers: {
          "x-access-token": await getToken(),
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getByCategory(int id) async {
    try {
      final _response = await http.get(
        Uri.parse("$_url/category/$id"),
        headers: {
          "x-access-token": await getToken(),
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> search(String query) async {
    try {
      final _response = await http.get(
        Uri.parse("$_url/search/$query"),
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
