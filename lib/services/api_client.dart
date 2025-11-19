// lib/services/api_client.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config.dart'; // ใช้ AppConfig.baseUrl

class _Api {
  // ใช้ค่าเดียวกับ config.dart
  final String baseUrl = AppConfig.baseUrl;

  // 👇 ตัวแปรเก็บ session cookie (เช่น connect.sid=xxxx)
  String? _cookie;

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    final qp = {
      ...?query,
      '_': DateTime.now().millisecondsSinceEpoch.toString(), // กัน cache
    };

    final uri = Uri.parse('$baseUrl$path').replace(
      queryParameters: qp.map((k, v) => MapEntry(k, v.toString())),
    );

    final res = await http.get(uri, headers: _headers());
    return _handle(res);
  }

  Future<dynamic> post(String path, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$baseUrl$path');
    final res = await http.post(
      uri,
      headers: _headers(),
      body: jsonEncode(body ?? {}),
    );
    return _handle(res);
  }

  Future<dynamic> patch(String path, {Map<String, dynamic>? body}) async {
    final uri = Uri.parse('$baseUrl$path');
    final res = await http.patch(
      uri,
      headers: _headers(),
      body: jsonEncode(body ?? {}),
    );
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

  // 👇 เพิ่ม Cookie เข้า header ถ้ามี
  Map<String, String> _headers() {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    if (_cookie != null) {
      headers['Cookie'] = _cookie!; // เช่น "connect.sid=xxxxx"
    }
    return headers;
  }

  // แปลง response เป็น JSON ถ้าเป็น JSON จริง ๆ
  // ถ้าไม่ใช่ JSON ให้คืนเป็นข้อความธรรมดา (String)
  dynamic _safeDecode(http.Response res) {
    final text = utf8.decode(res.bodyBytes);
    final ct = (res.headers['content-type'] ?? '').toLowerCase();
    final isJson = ct.contains('application/json');

    if (!isJson) return text; // server ตอบเป็นข้อความธรรมดา
    if (text.isEmpty) return null; // ไม่มีเนื้อหา
    return jsonDecode(text);
  }

  dynamic _handle(http.Response res) {
    // 👇 ดึง Set-Cookie จาก response แล้วเก็บไว้ใช้ครั้งถัดไป
    final setCookie = res.headers['set-cookie'];
    if (setCookie != null && setCookie.isNotEmpty) {
      // โดยปกติ express-session จะส่งอะไรประมาณ:
      // "connect.sid=xxxxx; Path=/; HttpOnly"
      // เราเก็บเฉพาะส่วนหน้า "connect.sid=xxxxx"
      final firstPart = setCookie.split(',').first; // กันกรณีมีหลาย cookie
      _cookie = firstPart.split(';').first.trim();
      // debug:
      // print('Saved cookie: $_cookie');
    }

    final ok = res.statusCode >= 200 && res.statusCode < 300;

    if (ok) {
      if (res.statusCode == 204 || res.body.isEmpty) return null; // no content
      return _safeDecode(res);
    }

    // error: ดึงข้อความแบบ utf8 (กันภาษาต่างๆเพี้ยน)
    final text = utf8.decode(res.bodyBytes);
    throw 'HTTP ${res.statusCode}: $text';
  }
}

final api = _Api();
