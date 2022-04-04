import 'package:flutter_test/flutter_test.dart';

import 'package:test_itti_flutter/shared/utils/date_format_utils.dart';

void main() {
  group('Date Format Utils', () {
    test('Conversion de Date a String ', () {
      var date = DateTime.now();
      var dateString = DateFormatUtils.formatDate(date);
      print(dateString);
      expect(dateString, isNotNull);
      expect(dateString, isInstanceOf<String>());
    });
    test('Conversion de Date a String en Formato Correcto', () {
      var date = DateTime.now();
      var dateString = DateFormatUtils.formatDate(date);

      var isRightFormat = RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(dateString);
      print("dateString: $dateString isRightFormat: $isRightFormat");
      expect(isRightFormat, isTrue);
    });
  });
}
