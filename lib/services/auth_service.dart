import 'dart:developer';
import 'package:flutter/foundation.dart';
import '../models/user.dart';
import 'api_service.dart';

class AuthService extends ChangeNotifier {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  static AuthService get instance => _instance;

  User? _currentUser;

  User? get currentUser => _currentUser;
  static User? get staticCurrentUser => _instance._currentUser;

  bool get isLoggedIn => _currentUser != null;
  static bool get staticIsLoggedIn => _instance._currentUser != null;
  // Register new user
  static Future<User> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    String? phone,
    String? companyName,
    String? website,
    String? bio,
  }) async {
    try {
      log('Registering user: $email');

      final data = {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        if (phone != null) 'phone': phone,
        if (companyName != null) 'company_name': companyName,
        if (website != null) 'website': website,
        if (bio != null) 'bio': bio,
      };

      final response = await ApiService.post('/register', data);

      log('Registration response: ${response.toString()}');

      // Store the token
      final token = response['data']['token'];
      await ApiService.setToken(token);

      // Create user object
      _instance._currentUser = User.fromJson(response['data']['user']);
      _instance.notifyListeners();

      log('User registered successfully: ${_instance._currentUser?.name}');
      return _instance._currentUser!;
    } catch (e) {
      log('Registration error: $e');
      rethrow;
    }
  }
  
  // Login user
  static Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      log('Logging in user: $email');

      final data = {
        'email': email,
        'password': password,
      };

      final response = await ApiService.post('/login', data);

      log('Login response: ${response.toString()}');

      // Store the token
      final token = response['data']['token'];
      await ApiService.setToken(token);

      // Create user object
      _instance._currentUser = User.fromJson(response['data']['user']);
      _instance.notifyListeners();

      log('User logged in successfully: ${_instance._currentUser?.name}');
      return _instance._currentUser!;
    } catch (e) {
      log('Login error: $e');
      rethrow;
    }
  }
  
  // Logout user
  static Future<void> logout() async {
    try {
      log('Logging out user');

      // Call logout endpoint if user is logged in
      if (_instance.isLoggedIn) {
        await ApiService.post('/logout', {});
      }
    } catch (e) {
      log('Logout API error (continuing anyway): $e');
    } finally {
      // Clear local data regardless of API call result
      _instance._currentUser = null;
      _instance.notifyListeners();
      await ApiService.clearToken();
      log('User logged out successfully');
    }
  }
  
  // Get current user profile
  static Future<User> getProfile() async {
    try {
      log('Fetching user profile');

      final response = await ApiService.get('/profile');

      log('Profile response: ${response.toString()}');

      _instance._currentUser = User.fromJson(response['data']);
      _instance.notifyListeners();
      return _instance._currentUser!;
    } catch (e) {
      log('Get profile error: $e');
      rethrow;
    }
  }
  
  // Update user profile
  static Future<User> updateProfile({
    String? name,
    String? phone,
    String? companyName,
    String? website,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      log('Updating user profile');

      final data = <String, dynamic>{};

      if (name != null) data['name'] = name;
      if (phone != null) data['phone'] = phone;
      if (companyName != null) data['company_name'] = companyName;
      if (website != null) data['website'] = website;
      if (bio != null) data['bio'] = bio;
      if (avatarUrl != null) data['avatar_url'] = avatarUrl;

      final response = await ApiService.put('/profile', data);

      log('Update profile response: ${response.toString()}');

      _instance._currentUser = User.fromJson(response['data']);
      _instance.notifyListeners();
      return _instance._currentUser!;
    } catch (e) {
      log('Update profile error: $e');
      rethrow;
    }
  }

  /// Initialize auth service (check if user is already logged in)
  static Future<void> initialize() async {
    try {
      final token = await ApiService.getToken();
      if (token != null) {
        log('Found existing token, fetching user profile');
        await getProfile();
      }
    } catch (e) {
      log('Auth initialization error: $e');
      // Clear invalid token
      await ApiService.clearToken();
      _instance._currentUser = null;
      _instance.notifyListeners();
    }
  }
}
