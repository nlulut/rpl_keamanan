/// Kumpulan fungsi validasi dan sanitasi input.
///
/// Class ini menyediakan method statis untuk memvalidasi input
/// pengguna dan membersihkan karakter berbahaya.
class Validators {
  Validators._();

  static final RegExp _emailRegex =
      RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  /// Memvalidasi format email.
  ///
  /// Mengembalikan `true` jika [email] memiliki format yang valid.
  /// Regex dikunci dengan `^` dan `$` serta melarang spasi dan `@` ganda.
  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email);
  }

  /// Memvalidasi bahwa [value] tidak kosong.
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Memvalidasi panjang [value] antara [min] dan [max].
  static bool hasValidLength(String value, {int min = 1, int max = 100}) {
    final length = value.trim().length;
    return length >= min && length <= max;
  }

  /// Membersihkan input dari karakter berbahaya.
  ///
  /// Mengganti `&`, `<`, `>`, `"`, dan `'` dengan HTML entities.
  /// Karakter `&` harus diganti pertama agar entity hasil penggantian
  /// lain tidak ter-escape dua kali.
  static String sanitize(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#39;')
        .trim();
  }

  /// Memvalidasi input teks.
  ///
  /// Mengembalikan pesan error jika tidak valid, atau `null` jika valid.
  static String? validateText(
    String? value, {
    String fieldName = 'Field',
    int minLength = 1,
    int maxLength = 100,
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    if (!hasValidLength(value, min: minLength, max: maxLength)) {
      return '$fieldName harus antara $minLength-$maxLength karakter';
    }
    return null;
  }

  /// Validasi nomor telepon (hanya angka, 10-13 digit)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
  
    final phoneRegex = RegExp(r'^[0-9]{10,13}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Nomor telepon harus berupa 10-13 digit angka';
    }
    return null; 
  }

  /// Validasi URL (harus dimulai dengan http:// atau https://)
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL tidak boleh kosong';
    }

    final urlRegex = RegExp(r'^https?://.+');
    if (!urlRegex.hasMatch(value)) {
      return 'URL harus dimulai dengan http:// atau https://';
    }
    return null; 
  }

  /// Validasi password (minimal 8 karakter, ada huruf kapital, angka, dan simbol)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password minimal 8 karakter';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password harus mengandung minimal 1 huruf kapital';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password harus mengandung minimal 1 angka';
    }
    
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password harus mengandung minimal 1 simbol';
    }
    return null; 
  }

  /// Memvalidasi email.
  ///
  /// Mengembalikan pesan error jika tidak valid, atau `null` jika valid.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!isValidEmail(value.trim())) {
      return 'Format email tidak valid';
    }
    return null;
  }
}