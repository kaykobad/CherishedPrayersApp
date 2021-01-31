import 'package:email_validator/email_validator.dart';

bool validateEmail(String email) {
  return EmailValidator.validate(email);
}

bool validatePassword(String password) {
  RegExp passwordValidator = RegExp(r"^[a-zA-Z\d_]{8,50}");
  return passwordValidator.hasMatch(password);
}

bool validateBothPassword(String p1, String p2) {
  return p1==p2 && validatePassword(p1);
}