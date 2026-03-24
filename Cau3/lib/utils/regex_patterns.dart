class RegexPatterns {
  static String email =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  static String username =
      r'^[a-zA-Z0-9_]{5,20}$';

  static String password =
      r'^(?=.*[A-Z])(?=.*[0-9]).{8,}$';
}
