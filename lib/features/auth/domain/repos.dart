import 'package:auth_app1/features/auth/data/models/profile.dart';
import 'package:auth_app1/features/auth/domain/shared_preference_helper.dart';

SharedPreferencesHelper userProfileSpRepo =
    const SharedPreferencesHelper('user', fromJson: UserProfile.fromJson);

