import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  static const String baseUrl =
      'https://mybhakti.sndbox.my.id';

  static const String apiUrl =
      '$baseUrl/api/v1';

  // ================= SINGLETON =================
  static final ApiService _instance =
      ApiService._internal();

  factory ApiService() => _instance;

  ApiService._internal();

  // ================= HTTP CLIENT (shared for cookies) =================
  HttpClient? _ioClient;
  
  HttpClient get _httpClient {
    _ioClient ??= HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              true;
    return _ioClient!;
  }

  // ================= TOKEN/SESSION STORAGE =================
  String? _accessToken;
  String? _refreshToken;
  String? _sessionId;
  String? _csrfToken;

  String? get accessToken => _accessToken;
  bool get isLoggedIn =>
      _accessToken != null || _sessionId != null;

  // ================= LOAD TOKEN =================
  Future<void> loadTokens() async {
    final prefs =
        await SharedPreferences.getInstance();

    _accessToken = prefs.getString('access_token');
    _refreshToken = prefs.getString('refresh_token');
    _sessionId = prefs.getString('session_id');
    _csrfToken = prefs.getString('csrf_token');
  }

  // ================= SAVE TOKEN =================
  Future<void> _saveTokens({
    String? access,
    String? refresh,
    String? sessionId,
    String? csrfToken,
  }) async {
    if (access != null) _accessToken = access;
    if (refresh != null) _refreshToken = refresh;
    if (sessionId != null) _sessionId = sessionId;
    if (csrfToken != null) _csrfToken = csrfToken;

    final prefs =
        await SharedPreferences.getInstance();

    if (access != null) {
      await prefs.setString('access_token', access);
    }
    if (refresh != null) {
      await prefs.setString('refresh_token', refresh);
    }
    if (sessionId != null) {
      await prefs.setString('session_id', sessionId);
    }
    if (csrfToken != null) {
      await prefs.setString('csrf_token', csrfToken);
    }
  }

  // ================= CLEAR TOKEN =================
  Future<void> _clearTokens() async {
    _accessToken = null;
    _refreshToken = null;
    _sessionId = null;
    _csrfToken = null;

    final prefs =
        await SharedPreferences.getInstance();

    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('session_id');
    await prefs.remove('csrf_token');
  }

  // ================= EXTRACT COOKIES =================
  void _extractCookies(HttpClientResponse response) {
    final cookies = response.cookies;

    for (final cookie in cookies) {
      debugPrint('[API] Cookie: ${cookie.name}=${cookie.value.substring(0, cookie.value.length > 20 ? 20 : cookie.value.length)}...');

      if (cookie.name == 'csrftoken') {
        _csrfToken = cookie.value;
      } else if (cookie.name == 'sessionid') {
        _sessionId = cookie.value;
      }
    }
  }

  String _buildCookieHeader() {
    final parts = <String>[];
    if (_csrfToken != null) parts.add('csrftoken=$_csrfToken');
    if (_sessionId != null) parts.add('sessionid=$_sessionId');
    return parts.join('; ');
  }

  // ================= LOGIN =================
  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    try {
      // Step 1: GET login page to obtain CSRF token
      debugPrint('[API] Step 1: Getting CSRF token...');

      final getRequest = await _httpClient.getUrl(
        Uri.parse('$baseUrl/login/'),
      );
      getRequest.followRedirects = false;

      final getResponse = await getRequest.close();
      await getResponse.drain();

      _extractCookies(getResponse);

      debugPrint('[API] CSRF token: ${_csrfToken != null ? "obtained" : "not found"}');

      // Step 2: POST login with CSRF token
      debugPrint('[API] Step 2: Posting login...');

      final postRequest = await _httpClient.postUrl(
        Uri.parse('$baseUrl/login/'),
      );

      postRequest.followRedirects = false;

      // Set headers
      postRequest.headers.set('Content-Type', 'application/x-www-form-urlencoded');
      postRequest.headers.set('Referer', '$baseUrl/login/');
      postRequest.headers.set('Origin', baseUrl);

      if (_csrfToken != null) {
        postRequest.headers.set('X-CSRFToken', _csrfToken!);
        postRequest.headers.set('Cookie', _buildCookieHeader());
      }

      // Form data
      final formData =
          'username=${Uri.encodeComponent(username)}'
          '&password=${Uri.encodeComponent(password)}'
          '&csrfmiddlewaretoken=${Uri.encodeComponent(_csrfToken ?? '')}';

      postRequest.write(formData);

      final postResponse = await postRequest.close();
      final responseBody = await postResponse.transform(utf8.decoder).join();

      _extractCookies(postResponse);

      debugPrint('[API] Login response status: ${postResponse.statusCode}');
      debugPrint('[API] Session ID: ${_sessionId != null ? "obtained" : "not found"}');

      // 302 redirect setelah login = sukses
      if (postResponse.statusCode == 302 &&
          _sessionId != null) {
        debugPrint('[API] Login successful! Session obtained.');

        await _saveTokens(
          sessionId: _sessionId,
          csrfToken: _csrfToken,
        );

        // Step 3: Coba ambil JWT token jika ada
        await _tryGetJwtToken(username, password);

        return {
          'success': true,
          'data': {'username': username},
        };
      }

      // Cek apakah response mengandung error
      if (responseBody.contains('incorrect') ||
          responseBody.contains('salah') ||
          responseBody.contains('invalid') ||
          responseBody.contains('error')) {
        return {
          'success': false,
          'message': 'Username atau password salah.',
        };
      }

      // Kalau status 200 tapi ga redirect, mungkin login gagal
      if (postResponse.statusCode == 200) {
        return {
          'success': false,
          'message': 'Login gagal. Periksa username dan password.',
        };
      }

      return {
        'success': false,
        'message':
            'Login gagal. Status: ${postResponse.statusCode}',
      };
    } catch (e, stackTrace) {
      debugPrint('[API] Login error: $e');
      debugPrint('[API] Stack: $stackTrace');

      return {
        'success': false,
        'message': 'Tidak dapat terhubung ke server: $e',
      };
    }
  }

  // ================= TRY GET JWT =================
  Future<void> _tryGetJwtToken(String username, String password) async {
    try {
      final request = await _httpClient.postUrl(
        Uri.parse('$apiUrl/auth/login/'),
      );

      request.headers.set('Content-Type', 'application/json');
      request.headers.set('Accept', 'application/json');
      request.headers.set('Cookie', _buildCookieHeader());

      if (_csrfToken != null) {
        request.headers.set('X-CSRFToken', _csrfToken!);
      }

      request.write(jsonEncode({
        'username': username,
        'password': password,
      }));

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      debugPrint('[API] JWT attempt status: ${response.statusCode}');
      debugPrint('[API] JWT attempt body: $body');

      if (response.statusCode == 200) {
        final data = jsonDecode(body);
        final access = data['access'] ?? data['token'];
        final refresh = data['refresh'] ?? data['refresh_token'];
        if (access != null) {
          await _saveTokens(
            access: access,
            refresh: refresh ?? '',
          );
          debugPrint('[API] JWT token obtained successfully!');
        }
      }
    } catch (e) {
      debugPrint('[API] JWT attempt failed: $e');
    }
  }

  // ================= AUTHENTICATED REQUEST =================
  Future<HttpClientResponse> _authenticatedRequest(
    String method,
    String url, {
    String? body,
  }) async {
    final request = await (method == 'GET'
        ? _httpClient.getUrl(Uri.parse(url))
        : method == 'POST'
            ? _httpClient.postUrl(Uri.parse(url))
            : method == 'PUT'
                ? _httpClient.putUrl(Uri.parse(url))
                : _httpClient.deleteUrl(Uri.parse(url)));

    request.headers.set('Accept', 'application/json');
    request.headers.set('Cookie', _buildCookieHeader());

    if (_csrfToken != null) {
      request.headers.set('X-CSRFToken', _csrfToken!);
    }

    if (_accessToken != null) {
      request.headers.set(
        'Authorization',
        'Bearer $_accessToken',
      );
    }

    if (body != null) {
      request.headers.set('Content-Type', 'application/json');
      request.write(body);
    }

    request.followRedirects = false;

    return await request.close();
  }

  // ================= LOGOUT =================
  Future<Map<String, dynamic>> logout() async {
    try {
      await _authenticatedRequest(
        'POST',
        '$apiUrl/auth/logout/',
        body: jsonEncode({'refresh': _refreshToken}),
      );
    } catch (_) {}

    await _clearTokens();
    return {'success': true};
  }

  // ================= GET ME =================
  Future<Map<String, dynamic>> getMe() async {
    try {
      final response = await _authenticatedRequest(
        'GET',
        '$apiUrl/auth/me/',
      );

      final body =
          await response.transform(utf8.decoder).join();

      debugPrint('[API] GetMe status: ${response.statusCode}');

      if (response.statusCode == 302) {
        return {
          'success': false,
          'message': 'Session expired',
        };
      }

      if (body.trimLeft().startsWith('<!') ||
          body.trimLeft().startsWith('<html')) {
        return {
          'success': false,
          'message': 'Session expired',
        };
      }

      final data = jsonDecode(body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': data,
        };
      }

      return {
        'success': false,
        'message': data['detail'] ?? 'Gagal memuat data.',
      };
    } catch (e) {
      debugPrint('[API] GetMe error: $e');
      return {
        'success': false,
        'message': 'Tidak dapat terhubung ke server.',
      };
    }
  }

  // ================= REFRESH TOKEN =================
  Future<bool> refreshToken() async {
    if (_refreshToken == null) return false;

    try {
      final response = await _authenticatedRequest(
        'POST',
        '$apiUrl/auth/token/refresh/',
        body: jsonEncode({'refresh': _refreshToken}),
      );

      final body =
          await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        final data = jsonDecode(body);

        if (data['access'] != null) {
          await _saveTokens(
            access: data['access'],
          );
          return true;
        }
      }

      await _clearTokens();
      return false;
    } catch (e) {
      await _clearTokens();
      return false;
    }
  }
}
