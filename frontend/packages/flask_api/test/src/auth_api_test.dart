// ignore_for_file: prefer_const_constructors
import 'package:flask_api/flask_api.dart';
import 'package:test/test.dart';

void main() {
  group('AuthApi', () {
    test('can be instantiated', () {
      expect(FlaskApi(), isNotNull);
    });
  });
}
