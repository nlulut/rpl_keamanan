/// Model data pengguna dari JSONPlaceholder.
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String website;
  final String companyName;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.website,
    required this.companyName,
  });

  /// Membuat [User] dari JSON.
  ///
  /// Field yang hilang diberi nilai default agar aplikasi tidak crash.
  factory User.fromJson(Map<String, dynamic> json) {
    final company = json['company'];
    return User(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '-',
      username: json['username'] as String? ?? '-',
      email: json['email'] as String? ?? '-',
      phone: json['phone'] as String? ?? '-',
      website: json['website'] as String? ?? '-',
      companyName: company is Map<String, dynamic>
          ? (company['name'] as String? ?? '-')
          : '-',
    );
  }
}