class Session {
  static int? userId;     // เก็บจากผลลัพธ์ /login
  static String? role;    // 'student' | 'staff' | 'lecturer'

  static bool get isLoggedIn => userId != null;
  static void clear() {
    userId = null;
    role = null;
  }
}
