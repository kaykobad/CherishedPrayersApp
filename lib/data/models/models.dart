library models;

import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

// Auth Models
part 'auth_models/verify_email_request.dart';
part 'auth_models/confirm_verify_email_request.dart';
part 'auth_models/register_request.dart';
part 'auth_models/login_request.dart';
part 'auth_models/change_password_request.dart';
part 'auth_models/reset_password_request.dart';
part 'auth_models/confirm_password_reset_request.dart';
part 'auth_models/confirm_verify_email_response.dart';
part 'auth_models/email_verification_response.dart';

// Profile, Feedback and Rating Models
part 'profile_feedback_rating_models/update_value_request.dart';
part 'profile_feedback_rating_models/update_profile_picture_request.dart';
part 'profile_feedback_rating_models/feedback_request.dart';
part 'profile_feedback_rating_models/update_profile_picture_response.dart';
part 'profile_feedback_rating_models/report_bug_request.dart';

// Shared Models
part 'shared_models/error_model.dart';
part 'shared_models/detail_only_response.dart';
part 'shared_models/auth_user_response.dart';
part 'shared_models/generic_user_model.dart';

// Configuration Models
part 'configurations/country_model.dart';
part 'configurations/language_model.dart';
part 'configurations/religion_model.dart';
part 'configurations/all_countries_response.dart';
part 'configurations/all_languages_model.dart';
part 'configurations/all_religions_response.dart';

// Chat Models
part 'chat_models/thread_model.dart';
part 'chat_models/message_model.dart';

// Friends Models
part 'friends_models/get_all_friends_response.dart';
part 'friends_models/single_friend_response.dart';
part 'friends_models/single_sent_friend_request_response.dart';
part 'friends_models/get_all_sent_friend_request_response.dart';
part 'friends_models/single_received_friend_request_response.dart';
part 'friends_models/get_all_received_friend_request_response.dart';
part 'friends_models/get_friend_suggestion_response.dart';
part 'friends_models/search_people_request.dart';
part 'friends_models/single_people_response.dart';
part 'friends_models/search_people_response.dart';
part 'friends_models/get_all_blocked_users_response.dart';

// Feed Models
part 'feed_models/post_request.dart';
part 'feed_models/post_response.dart';
part 'feed_models/single_comment_response.dart';
part 'feed_models/generic_post_response.dart';
part 'feed_models/all_posts_response.dart';
part 'feed_models/add_comment_request.dart';
part 'feed_models/update_comment_request.dart';