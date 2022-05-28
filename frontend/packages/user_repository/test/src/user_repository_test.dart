// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  group('AuthRepository', () {
    test('can be instantiated', () {
      expect(UserRepository(), isNotNull);
    });
  });
}
