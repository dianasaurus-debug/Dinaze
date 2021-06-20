import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BaseService {
  final _storage = FlutterSecureStorage();

  getToken() async {
    return await _storage.read(key: 'token');
  }
}
