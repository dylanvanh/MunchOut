// ignore_for_file: prefer_const_constructors
import 'package:restaurant_repository/restaurant_repository.dart';
import 'package:test/test.dart';

void main() {
  group('RestaurantRepository', () {
    test('can be instantiated', () {
      expect(RestaurantRepository(), isNotNull);
    });
  });
}
