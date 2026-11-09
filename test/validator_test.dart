import 'package:flutter_test/flutter_test.dart';
import 'package:rpl_keamanan/utils/validator.dart'; // Sesuaikan nama import filemu

void main() {
  group('Unit Test Validators', () {
    
    // a) Test isValidEmail()
    group('a) isValidEmail()', () {
      test('Mengembalikan true jika email valid', () {
        expect(Validators.isValidEmail('user@example.com'), isTrue);
        expect(Validators.isValidEmail('nama.belakang@domain.co.id'), isTrue);
      });

      test('Mengembalikan false jika format email tidak valid', () {
        expect(Validators.isValidEmail('userexample.com'), isFalse);
        expect(Validators.isValidEmail('user@'), isFalse);
        expect(Validators.isValidEmail('user@domain'), isFalse);
      });
    });

    // b) Test sanitize() input berbahaya
    group('b) sanitize() input berbahaya', () {
      test('Menghapus tag script berbahaya dari input', () {
        const input = '<script>alert("xss")</script>';
        final result = Validators.sanitize(input);
        expect(result.contains('<script>'), isFalse);
      });
    });

    // c) Test validateText() berbagai panjang
    group('c) validateText() berbagai panjang', () {
      test('Mengembalikan error jika kurang dari minLength', () {
        expect(Validators.validateText('ab', minLength: 3), 'Field harus antara 3-100 karakter');
      });

      test('Mengembalikan null jika panjang memenuhi syarat', () {
        expect(Validators.validateText('abc', minLength: 3), isNull);
      });
    });

  });
}