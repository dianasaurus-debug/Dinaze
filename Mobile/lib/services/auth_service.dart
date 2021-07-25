import 'dart:convert';
import 'package:flutter_cash_waqf/model/wakif.dart';
import 'package:flutter_cash_waqf/services/base_service.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter_cash_waqf/utilities/constant.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AuthService extends BaseService {
  final _url = "${Constant.urlApi}/wakif-auth";

  Future<String?> _getOneSignalId() async {
    final _deviceState = await OneSignal.shared.getDeviceState();
    if (_deviceState != null) {
      return _deviceState.userId;
    }
  }

  Future<dynamic> register(String name, String email, String password) async {
    try {
      final _response = await http.post(
        Uri.parse("$_url/register"),
        body: {
          "nama": name,
          "email": email,
          "password": password,
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> login(String email, String password) async {
    try {
      final _response = await http.post(
        Uri.parse("$_url/login"),
        body: {
          "email": email,
          "password": password,
          "player_id": await _getOneSignalId(),
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  firebaseCheck(String uid) async {
    try {
      final _response = await http.post(
        Uri.parse("$_url/google/cek"),
        body: {
          "googleId": uid,
          "player_id": await _getOneSignalId(),
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> firebaseRegister(
      String name, String email, String password, String uid) async {
    try {
      final _response = await http.post(
        Uri.parse("$_url/google/register"),
        body: {
          "googleId": uid,
          "nama": name,
          "email": email,
          "password": password,
          "player_id": await _getOneSignalId(),
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> logout() async {
    try {
      final _response = await http.post(
        Uri.parse("$_url/logout"),
        headers: {
          "x-access-token": await getToken(),
        },
        body: {
          "player_id": await _getOneSignalId(),
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> getWakifData() async {
    try {
      final _response = await http.get(
        Uri.parse("$_url/get-wakif-data"),
        headers: {
          "x-access-token": await getToken(),
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> updateWakifData(Wakif wakif) async {
    try {
      final _response = await http.put(
        Uri.parse("$_url/update"),
        headers: {
          "x-access-token": await getToken(),
        },
        body: {
          "nama": wakif.nama,
          "email": wakif.email,
          "nik": wakif.nik,
          "nomor_ponsel": wakif.nomorPonsel,
          "alamat": wakif.alamat,
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> changePassword(String oldPassword, String newPassword) async {
    try {
      final _response = await http.put(
        Uri.parse("$_url/change-password"),
        headers: {
          "x-access-token": await getToken(),
        },
        body: {
          "old_password": oldPassword,
          "new_password": newPassword,
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> requestTokenResetPassword(String email) async {
    try {
      final _response = await http.post(
        Uri.parse("$_url/reset-password/request"),
        body: {
          "email": email,
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> verifyTokenResetPassword(String email, String token) async {
    try {
      final _response = await http.post(
        Uri.parse("$_url/reset-password/verify"),
        body: {
          "email": email,
          "token": token,
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> resetPassword(
      String email, String token, String password) async {
    try {
      final _response = await http.post(
        Uri.parse("$_url/reset-password"),
        body: {
          "email": email,
          "token": token,
          "password": password,
        },
      );
      return jsonDecode(_response.body);
    } catch (e) {
      return e;
    }
  }

  Future<dynamic> uploadImage(String path) async {
    try {
      final _request =
          http.MultipartRequest("PUT", Uri.parse("$_url/upload-photo"));
      _request.headers.addAll({"x-access-token": await getToken()});
      _request.files.add(await http.MultipartFile.fromPath(
        'foto',
        path,
        contentType: MediaType('image', 'png'),
      ));
      final _response = await _request.send();
      return jsonDecode(await _response.stream.bytesToString());
    } catch (e) {
      return e;
    }
  }
}
