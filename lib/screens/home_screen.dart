import 'package:flutter/material.dart';

import 'user_list_screen.dart';

/// Halaman utama aplikasi.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RPL & Keamanan'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.people),
          label: const Text('Lihat Daftar Pengguna'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const UserListScreen()),
            );
          },
        ),
      ),
    );
  }
}