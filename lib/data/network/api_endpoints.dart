class ApiEndpoints {
  static const String URL_ROOT = "http://cp.kaykobadreza.com";
  static const String BASE_URL = "http://cp.kaykobadreza.com/api/";

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
  static const String UPDATE_PROFILE_PICTURE = "account/profile/update-avatar/";

  // Feedback URLs
  static const String POST_FEEDBACK = "feedback/post-feedback/";
  static const String REPORT_BUG = "feedback/report-bug/";

  // Common URLs
  static const String GET_ALL_COUNTRIES = "configuration/all-countries/";
  static const String GET_ALL_LANGUAGES = "configuration/all-languages/";
  static const String GET_ALL_RELIGIONS = "configuration/all-religions/";

  // Friends URLs
  static const String SEND_FRIEND_REQUEST = "friends/send-friend-request/uid/";
  static const String GET_ALL_FRIENDS = "friends/get-all-friends/";
  static const String GET_ALL_SENT_REQUEST = "friends/get-all-sent-request/";
  static const String GET_ALL_RECEIVED_REQUEST = "friends/get-all-received-request/";
  static const String UN_FRIEND = "friends/un-friend/uid/";
  static const String ACCEPT_FRIEND_REQUEST = "friends/accept-friend-request/rid/";
  static const String REJECT_FRIEND_REQUEST = "friends/reject-friend-request/rid/";
  static const String CANCEL_FRIEND_REQUEST = "friends/cancel-friend-request/rid/";
  static const String FRIEND_SUGGESTIONS = "friends/friend-suggestions/";
  static const String SEARCH_PEOPLE = "friends/search-people/";
  static const String BLOCK_USER = "friends/block/uid/";
  static const String UN_BLOCK_USER = "friends/unblock/uid/";
  static const String GET_BLOCKED_USERS = "friends/get-blocked-users/";

  // Feed URLs
  static const String CREATE_POST = "feed/create-post/";
  static const String UPDATE_POST = "feed/update-post/pid/";
  static const String MY_ALL_POSTS = "feed/my-posts/";
  static const String DELETE_POST = "feed/delete-post/pid/";
  static const String POST_DETAILS = "feed/post-details/pid/";
  static const String LIKE_POST = "feed/like-post/pid/";
  static const String MY_FEED = "feed/my-feed/";
  static const String ADD_COMMENT = "feed/add-comment/";
  static const String UPDATE_COMMENT = "feed/update-comment/cid/";
  static const String DELETE_COMMENT = "feed/delete-comment/cid/";
  static const String LIKE_COMMENT = "feed/like-comment/cid/";
}