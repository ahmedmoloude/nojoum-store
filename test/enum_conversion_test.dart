import 'package:flutter_test/flutter_test.dart';
import 'package:noujoum_store/models/mauritanian_app.dart';

void main() {
  group('Enum Conversion Tests', () {
    test('AppType enum should convert to string correctly', () {
      // Test enum to string conversion
      String enumToString(dynamic enumValue) {
        if (enumValue == null) return '';
        return enumValue.toString().split('.').last;
      }

      expect(enumToString(AppType.mobile), equals('mobile'));
      expect(enumToString(AppType.web), equals('web'));
      expect(enumToString(AppType.desktop), equals('desktop'));
      expect(enumToString(AppType.saas), equals('saas'));
      expect(enumToString(null), equals(''));
    });

    test('Platform enum list should convert to string list correctly', () {
      // Test enum list to string list conversion
      List<String> enumListToStringList(List<dynamic>? enumList) {
        if (enumList == null) return [];
        return enumList.map((e) => e.toString().split('.').last).toList();
      }

      final platforms = [Platform.android, Platform.iOS, Platform.web];
      final result = enumListToStringList(platforms);
      
      expect(result, equals(['android', 'iOS', 'web']));
      expect(enumListToStringList(null), equals([]));
      expect(enumListToStringList([]), equals([]));
    });

    test('PricingModel enum should convert to string correctly', () {
      String enumToString(dynamic enumValue) {
        if (enumValue == null) return '';
        return enumValue.toString().split('.').last;
      }

      expect(enumToString(PricingModel.free), equals('free'));
      expect(enumToString(PricingModel.paid), equals('paid'));
      expect(enumToString(PricingModel.freemium), equals('freemium'));
    });

    test('SupportType enum list should convert to string list correctly', () {
      List<String> enumListToStringList(List<dynamic>? enumList) {
        if (enumList == null) return [];
        return enumList.map((e) => e.toString().split('.').last).toList();
      }

      final supportTypes = [SupportType.email, SupportType.chat, SupportType.phone];
      final result = enumListToStringList(supportTypes);
      
      expect(result, equals(['email', 'chat', 'phone']));
    });

    test('Key features parsing should work correctly', () {
      List<String> parseKeyFeatures(dynamic keyFeatures) {
        if (keyFeatures == null) return [];
        if (keyFeatures is List) return keyFeatures.map((e) => e.toString()).toList();
        if (keyFeatures is String) {
          return keyFeatures.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
        }
        return [keyFeatures.toString()];
      }

      // Test string input
      expect(parseKeyFeatures('feature1, feature2, feature3'), 
             equals(['feature1', 'feature2', 'feature3']));
      
      // Test list input
      expect(parseKeyFeatures(['feature1', 'feature2']), 
             equals(['feature1', 'feature2']));
      
      // Test null input
      expect(parseKeyFeatures(null), equals([]));
      
      // Test empty string
      expect(parseKeyFeatures(''), equals([]));
      
      // Test single feature
      expect(parseKeyFeatures('single feature'), equals(['single feature']));
    });
  });
}
