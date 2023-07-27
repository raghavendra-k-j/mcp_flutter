
import 'package:flutter_test/flutter_test.dart';
import 'package:mcp_app/ml/search_command_detector.dart';

void main() {
  // Test cases for the SearchQueryDetector class
  test('Test parsing a query with name command', () {
    SearchQueryDetector detector = SearchQueryDetector("show me user JohnDoe");
    Map<String, dynamic> result = detector.parseCommand();

    expect(result['commandType'], 'name');
    expect(result['name'], 'John Doe');
  });

  test('Test parsing a query with age less than', () {
    SearchQueryDetector detector = SearchQueryDetector("show me users age less than 30");
    Map<String, dynamic> result = detector.parseCommand();

    expect(result['commandType'], 'age_less_than');
    expect(result['age'], 30);
  });

  test('Test parsing a query with age greater than', () {
    SearchQueryDetector detector = SearchQueryDetector("show me users age greater than 25");
    Map<String, dynamic> result = detector.parseCommand();

    expect(result['commandType'], 'age_greater_than');
    expect(result['age'], 25);
  });

  test('Test parsing a query with age between', () {
    SearchQueryDetector detector = SearchQueryDetector("show me users age between 20 and 30");
    Map<String, dynamic> result = detector.parseCommand();

    expect(result['commandType'], 'age_between');
    expect(result['minAge'], 20);
    expect(result['maxAge'], 30);
  });

  test('Test parsing a query with hb level less than', () {
    SearchQueryDetector detector = SearchQueryDetector("show me users having hb level less than 12.5");
    Map<String, dynamic> result = detector.parseCommand();

    expect(result['commandType'], 'hb_level');
    expect(result['hbLevel'], 12.5);
  });

  // Add more test cases for other command types and edge cases...
}
