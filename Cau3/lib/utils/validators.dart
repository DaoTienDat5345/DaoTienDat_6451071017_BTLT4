import 'regex_patterns.dart';

class Validators {

  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName không được để trống';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email không được để trống';
    }

    RegExp regex = RegExp(RegexPatterns.email);
    if (!regex.hasMatch(value)) {
      return 'Email không đúng định dạng';
    }
    return null;
  }

  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username là bắt buộc';
    }

    if (value.length < 5) {
      return 'Username phải ít nhất 5 ký tự';
    }

    RegExp regex = RegExp(RegexPatterns.username);
    if (!regex.hasMatch(value)) {
      return 'Username chỉ gồm chữ, số và dấu _';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password là bắt buộc';
    }

    RegExp regex = RegExp(RegexPatterns.password);
    if (!regex.hasMatch(value)) {
      return 'Password phải ≥ 8 ký tự, có chữ hoa và số';
    }
    return null;
  }

  /// Cross-field validation
  static String? confirmPasswordValidator(
      String? value,
      String password,
      ) {
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập lại mật khẩu';
    }

    if (value != password) {
      return 'Mật khẩu xác nhận không khớp';
    }
    return null;
  }

  /// Custom business rule
  static String? weightValidator(double weight) {
    if (weight < 30 || weight > 150) {
      return 'Cân nặng phải trong khoảng 30 – 150 kg';
    }
    return null;
  }
}
