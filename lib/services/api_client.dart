// lib/services/api_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart';  // << เพิ่ม

class _Api {
  // ใช้ค่าเดียวกับ config.dart
  final String baseUrl = AppConfig.baseUrl;

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    final uri = Uri.parse('$baseUrl$path').replace(
      queryParameters: query?.map((k, v) => MapEntry(k, v.toString())),
    );
    final res = await http.get(uri, headers: _headers());
    return _handle(res);
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$baseUrl$path');
    final res = await http.post(uri, headers: _headers(), body: jsonEncode(body ?? {}));
    return _handle(res);
  }

  Future<dynamic> patch(String path, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$baseUrl$path');
    final res = await http.patch(uri, headers: _headers(), body: jsonEncode(body ?? {}));
    return _handle(res);
  }

  Future<dynamic> delete(String path, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$baseUrl$path');
    final req = http.Request('DELETE', uri)
      ..headers.addAll(_headers())
      ..body = jsonEncode(body ?? {});
    final streamed = await req.send();
    final res = await http.Response.fromStream(streamed);
    return _handle(res);
  }

  Map<String, String> _headers() => {'Content-Type': 'application/json'};

  dynamic _handle(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (res.body.isEmpty) return null;
      return jsonDecode(res.body);
    }
    throw 'HTTP ${res.statusCode}: ${res.body}';
  }
}

final api = _Api();
