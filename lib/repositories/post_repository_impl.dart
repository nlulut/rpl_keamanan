import '../models/post.dart';
import '../services/api_service.dart';
import 'post_repository.dart';

/// Implementasi konkret dari [PostRepository][cite: 15, 20].
///
/// Class ini menggunakan [ApiService] untuk mengambil data post dari API[cite: 15, 20].
class PostRepositoryImpl implements PostRepository {
  final ApiService _apiService;

  PostRepositoryImpl({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  @override
  Future<List<Post>> getPosts() async {
    return await _apiService.getPosts();
  }

  /// Menutup resource yang digunakan[cite: 15].
  void dispose() {
    _apiService.dispose();
  }
}