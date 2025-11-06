// lib/services/image_registry.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ImageRegistry {
  static const _key = 'room_images'; // Map<String, String>: roomId(or name) -> asset path
  static Map<String, String>? _cache;

  /// ใช้ roomId ถ้ามี (ดีกว่าไม่ซ้ำ), ถ้าไม่มีให้ใช้ roomName ก็ได้
  static String _makeKey({int? roomId, required String fallbackName}) {
    return roomId != null ? 'id:$roomId' : 'name:$fallbackName';
  }

  static Future<void> setImagePath({
    int? roomId,
    required String roomName,
    required String assetPath,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    final map = raw == null ? <String, String>{} : Map<String, String>.from(jsonDecode(raw));
    final k = _makeKey(roomId: roomId, fallbackName: roomName);
    map[k] = assetPath;
    await prefs.setString(_key, jsonEncode(map));
    _cache = map;
  }

  static Future<String?> getImagePath({int? roomId, required String roomName}) async {
    if (_cache == null) {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_key);
      _cache = raw == null ? <String, String>{} : Map<String, String>.from(jsonDecode(raw));
    }
    // หาแบบ roomId ก่อน ถ้าไม่มีค่อยหาแบบชื่อห้อง
    final idKey = _makeKey(roomId: roomId, fallbackName: roomName);
    final nameKey = _makeKey(roomId: null, fallbackName: roomName);
    return _cache![idKey] ?? _cache![nameKey];
  }
}
