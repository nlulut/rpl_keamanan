import 'package:flutter/material.dart';
import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../services/api_service.dart';

/// Class DependencyInjector menggunakan InheritedWidget.
///
/// Menyediakan instance terpusat dari ApiService, UserRepository, dan PostRepository[cite: 20].
class DependencyInjector extends InheritedWidget {
  /// Singleton instance untuk ApiService[cite: 20].
  static final ApiService _apiService = ApiService();

  final UserRepository userRepository;
  final PostRepository postRepository;

  DependencyInjector({
    super.key,
    required super.child,
    UserRepository? userRepository,
    PostRepository? postRepository,
  })  : userRepository =
            userRepository ?? UserRepositoryImpl(apiService: _apiService),
        postRepository =
            postRepository ?? PostRepositoryImpl(apiService: _apiService);

  /// Getter statis untuk mengambil instance ApiService (Singleton)[cite: 20].
  static ApiService get apiService => _apiService;

  /// Helper method untuk mengambil DependencyInjector dari BuildContext.
  static DependencyInjector of(BuildContext context) {
    final DependencyInjector? result =
        context.dependOnInheritedWidgetOfExactType<DependencyInjector>();
    assert(result != null, 'No DependencyInjector found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DependencyInjector oldWidget) {
    return userRepository != oldWidget.userRepository ||
        postRepository != oldWidget.postRepository;
  }
}