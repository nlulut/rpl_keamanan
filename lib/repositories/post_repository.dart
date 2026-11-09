import '../models/post.dart';

/// Abstraksi repository untuk mengelola data Post[cite: 6, 20].
///
/// Interface ini mendefinisikan kontrak untuk operasi data post[cite: 13, 20].
/// Implementasi konkretnya ada di [PostRepositoryImpl][cite: 13, 20].
abstract class PostRepository {
  /// Mengambil daftar semua post dari API[cite: 10, 20].
  ///
  /// Mengembalikan [List<Post>] jika berhasil[cite: 10, 20].
  /// Melempar [Exception] jika terjadi error[cite: 10, 20].
  Future<List<Post>> getPosts();
}