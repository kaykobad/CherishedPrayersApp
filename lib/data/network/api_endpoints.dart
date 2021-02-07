class ApiEndpoints {
  static const String URL_ROOT = "https://cp.mycodeacademia.com";
  static const String BASE_URL = "https://cp.mycodeacademia.com/api/";

  // Auth URLs
  static const String LOGIN = "account/auth/login/";
  static const String LOGOUT = "account/auth/logout/";
  static const String REGISTER = "account/auth/register/";
  static const String CHANGE_PASSWORD = "account/auth/change-password/";
  static const String RESET_PASSWORD = "account/auth/reset-password/";
  static const String RESET_PASSWORD_CONFIRMATION = "account/auth/confirm-password-reset/";
  static const String EMAIL_VERIFY = "account/auth/verify-email/";
  static const String EMAIL_VERIFY_CONFIRMATION = "account/auth/confirm-email-verification/";

  // Profile URLs
  static const String GET_PROFILE = "account/profile/get-profile/";
  static const String UPDATE_COUNTRY = "account/profile/update-country/";
  static const String UPDATE_LANGUAGE = "account/profile/update-language/";
  static const String UPDATE_RELIGION = "account/profile/update-religion/";
  static const String UPDATE_PROFILE_PICTURE = "api/account/profile/update-avatar/";

  // Feedback URLs
  static const String POST_FEEDBACK = "feedback/post-feedback/";

  // Common URLs
  static const String GET_ALL_COUNTRIES = "configuration/all-countries/";
  static const String GET_ALL_LANGUAGES = "configuration/all-languages/";
  static const String GET_ALL_RELIGIONS = "configuration/all-religions/";
}