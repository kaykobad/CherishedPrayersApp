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

// Profile, Feedback and Rating Models
part 'profile_feedback_rating_models/update_value_request.dart';
part 'profile_feedback_rating_models/update_profile_picture_request.dart';
part 'profile_feedback_rating_models/feedback_request.dart';

// Error Model
part 'shared_models/error_model.dart';