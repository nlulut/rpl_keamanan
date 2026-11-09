import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/user.dart';

/// Exception dengan pesan yang aman ditampilkan ke pengguna.
///
/// Detail teknis tidak dimasukkan ke [message] agar tidak bocor ke UI.
class ApiException implements Exception {
  /// Pesan ramah pengguna.
  final String message;

  const ApiException(this.message);

  @override
  String toString() => message;
}

/// Service untuk komunikasi HTTP dengan REST API.
///
/// Class ini menangani semua request HTTP ke API, termasuk
/// penanganan error dan timeout.
class ApiService {
  final http.Client _client;
  final String _baseUrl;

  ApiService({http.Client? client, String? baseUrl})
      : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? AppConfig.baseUrl;

  /// Mengambil daftar pengguna dari API.
  ///
  /// Mengembalikan [List<User>] jika berhasil.
  /// Melempar [ApiException] dengan pesan ramah pengguna jika gagal.
  Future<List<User>> getUsers() {
    return _get<List<User>>('/users', (data) {
      final list = data as List<dynamic>;
      return list
          .map((json) => User.fromJson(json as Map<String, dynamic>))
          .toList();
    });
  }

  /// Mengambil pengguna berdasarkan [id].
  ///
  /// Melempar [ApiException] jika gagal.
  Future<User> getUserById(int id) {
    return _get<User>(
      '/users/$id',
      (data) => User.fromJson(data as Map<String, dynamic>),
    );
  }

  /// Menjalankan GET ke [endpoint] lalu mengubah hasilnya dengan [parse].
  ///
  /// Semua error diterjemahkan menjadi [ApiException] bermessage aman
  Future<T> _get<T>(String endpoint, T Function(dynamic data) parse) async {
    try {
      _log('GET $endpoint');
      final response = await _client
          .get(Uri.parse('$_baseUrl$endpoint'), headers: _buildHeaders())
          .timeout(const Duration(seconds: AppConfig.timeoutSeconds));
      _log('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return parse(jsonDecode(response.body));
      }
      throw ApiException('Gagal memuat data. Status: ${response.statusCode}');
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw const ApiException(
          'Request timeout. Periksa koneksi internet Anda.');
    } on SocketException {
      throw const ApiException(
          'Tidak ada koneksi internet. Periksa jaringan Anda.');
    } on FormatException {
      throw const ApiException('Format data tidak valid.');
    } catch (e) {
      // Detail teknis hanya dicatat saat debug, tidak dikirim ke UI.
      _log('Unexpected error: ${e.runtimeType}');
      throw const ApiException('Terjadi kesalahan. Silakan coba lagi.');
    }
  }

  /// Membangun header untuk request HTTP.
  ///
  /// Menyertakan API key dari konfigurasi (tidak di-hardcode).
  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json',
      'X-API-Key': AppConfig.apiKey,
    };
  }

  /// Logging yang hanya aktif di mode debug.
  ///
  /// Jangan pernah mencetak API key, token, atau data pengguna di sini.
  void _log(String message) {
    if (kDebugMode) {
      debugPrint('[ApiService] $message');
    }
  }

  /// Menutup client.
  void dispose() {
    _client.close();
  }
}