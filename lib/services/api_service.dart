import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8011/api'; // Change this to your actual API URL
  
  static String? _token;
  
  // Get auth token
  static Future<String?> getToken() async {
    if (_token != null) return _token;
    
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    return _token;
  }
  
  // Set auth token
  static Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }
  
  // Clear auth token
  static Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
  
  // Get headers with auth token
  static Future<Map<String, String>> getHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
  
  // Generic GET request
  static Future<Map<String, dynamic>> get(String endpoint) async {

    log('Endpoint: $endpoint');
    
    final headers = await getHeaders();

    log('Headers: $headers');
    log('Full URL: $baseUrl$endpoint');

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );

    log('Response Status: ${response.statusCode}');
    log('Response: ${response.body}');
    
    return _handleResponse(response);
  }
  
  // Generic POST request
  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    final headers = await getHeaders();
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(data),
    );

    log('Response Status: ${response.statusCode}');
    log('Response: ${response.body}');
    
    return _handleResponse(response);
  }
  
  // Generic PUT request
  static Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> data) async {
    final headers = await getHeaders();
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(data),
    );
    
    return _handleResponse(response);
  }
  
  // Generic DELETE request
  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final headers = await getHeaders();
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
    );
    
    return _handleResponse(response);
  }
  
  // Handle HTTP response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);
    
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw ApiException(
        message: data['message'] ?? 'An error occurred',
        statusCode: response.statusCode,
        errors: data['errors'],
      );
    }
  }

  // Upload file
  static Future<Map<String, dynamic>> uploadFile(File file, {String fieldName = 'file', Map<String, String>? fields}) async {
    try {
      final token = await getToken();
      final uri = Uri.parse('$baseUrl/upload');
      
      var request = http.MultipartRequest('POST', uri);
      
      // Add headers
      request.headers['Authorization'] = 'Bearer $token';
      
      // Add file
      final fileName = file.path.split('/').last;
      final fileExtension = fileName.split('.').last.toLowerCase();
      final mimeType = _getMimeType(fileExtension);
      
      request.files.add(
        await http.MultipartFile.fromPath(
          fieldName,
          file.path,
          contentType: MediaType.parse(mimeType),
        ),
      );
      
      // Add additional fields if provided
      if (fields != null) {
        request.fields.addAll(fields);
      }
      
      // Send request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      
      return _handleResponse(response);
    } catch (e) {
      log('Error uploading file: $e');
      rethrow;
    }
  }
  
  static String _getMimeType(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'xls':
        return 'application/vnd.ms-excel';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'zip':
        return 'application/zip';
      default:
        return 'application/octet-stream';
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;
  final Map<String, dynamic>? errors;
  
  ApiException({
    required this.message,
    required this.statusCode,
    this.errors,
  });
  
  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}
