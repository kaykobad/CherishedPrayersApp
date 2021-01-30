class ApiEndpoints {
  static const String BASE_URL = "https://cp.mycodeacademia.com/api/";

  // Auth URLs
  static const String LOGIN = BASE_URL + "account/auth/login/";
  static const String LOGOUT = BASE_URL + "account/auth/logout/";
  static const String REGISTER = BASE_URL + "account/auth/register/";
  static const String CHANGE_PASSWORD = BASE_URL + "account/auth/change-password/";
  static const String RESET_PASSWORD = BASE_URL + "account/auth/reset-password/";
  static const String RESET_PASSWORD_CONFIRMATION = BASE_URL + "account/auth/confirm-password-reset/";
  static const String EMAIL_VERIFY = BASE_URL + "account/auth/verify-email/";
  static const String EMAIL_VERIFY_CONFIRMATION = BASE_URL + "account/auth/confirm-email-verification/";

  // Profile URLs
  static const String GET_PROFILE = BASE_URL + "account/profile/get-profile/";
  static const String UPDATE_COUNTRY = BASE_URL + "account/profile/update-country/";
  static const String UPDATE_LANGUAGE = BASE_URL + "account/profile/update-language/";
  static const String UPDATE_RELIGION = BASE_URL + "account/profile/update-religion/";
  static const String UPDATE_PROFILE_PICTURE = BASE_URL + "account/profile/update-profile-picture/";

  // Feedback URLs
  static const String POST_FEEDBACK = BASE_URL + "feedback/post-feedback/";

  // Common URLs
  static const String GET_ALL_COUNTRIES = BASE_URL + "configuration/all-countries/";
  static const String GET_ALL_LANGUAGES = BASE_URL + "configuration/all-languages/";
  static const String GET_ALL_RELIGIONS = BASE_URL + "configuration/all-religions/";
}