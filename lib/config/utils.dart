class UserInfo {
  static String _userId = '';

  static String get userId => _userId;

  static setUser(String val) {
    _userId = val;
  }
}
