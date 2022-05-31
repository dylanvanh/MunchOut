// ignore_for_file: prefer_const_constructors
import 'package:customer_repository/customer_repository.dart';
import 'package:test/test.dart';

void main() {
  group('CustomerRepository', () {
    test('can be instantiated', () {
      expect(CustomerRepository(), isNotNull);
    });
  });
}
