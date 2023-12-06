class UserManager {
  static String? _userId;
  static String? _userPhoneNumber;

  static String? get userId => _userId;
  static String? get userPhoneNumber => _userPhoneNumber;
  
  static setUserId(String? userId, String? userPhoneNumber) {
    _userId = userId;
   
    _userPhoneNumber = userPhoneNumber;
  }
  
}
