class SearchQueryDetector {
  String? query;

  SearchQueryDetector(this.query);

  Map<String, List>? parseQuery() {
    if(query == null || query!.isEmpty) return null;
    query = query!.trim();
    var commandPatterns = [
      CommandPattern('name', RegExp(r"^show me user (.+)")),
      CommandPattern('name', RegExp(r"^ಓಪನ್ (.+)")),
      CommandPattern('name', RegExp(r"^show me (.+)")),
      CommandPattern('name', RegExp(r"^show (.+)")),
      CommandPattern('hemoglobinLessThan', RegExp(r"^hemoglobin less than (\d+(\.\d+)?)")),
      CommandPattern('hemoglobinGreaterThan', RegExp(r"^hemoglobin greater than (\d+(\.\d+)?)")),
      CommandPattern('hemoglobinLessThan', RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್ (\d+(\.\d+)?) ಗಿಂತ ಕಡಿಮೆ")),
      CommandPattern('hemoglobinGreaterThan', RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್ (\d+(\.\d+)?) ಗಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('ageLessThan', RegExp(r"^age less than (\d+)")),
      CommandPattern('ageGreaterThan', RegExp(r"^age greater than (\d+)")),
      CommandPattern('ageBetween', RegExp(r"^age between (\d+) and (\d+)")),
    ];

    // Try to match the query with each command's pattern
    for (var commandPattern in commandPatterns) {
      var pattern = commandPattern.pattern;
      var match = pattern.firstMatch(query!);
      if (match != null) {
        return _parseParameters(commandPattern.command, match);
      }
    }

    return null; // No match found
  }

  Map<String, List>? _parseParameters(String command, RegExpMatch match) {
    switch (command) {
      case 'name':
        return {
          command: [match.group(1)]
        };
      case 'hemoglobinLessThan':
      case 'hemoglobinGreaterThan':
        return {
          command: [double.tryParse(match.group(1) ?? '') ?? 0.0]
        };
      case 'ageLessThan':
      case 'ageGreaterThan':
        return {
          command: [int.tryParse(match.group(1) ?? '') ?? 0]
        };
      case 'ageBetween':
        return {
          'ageBetween': [
            int.tryParse(match.group(1) ?? '') ?? 0,
            int.tryParse(match.group(2) ?? '') ?? 0
          ]
        };
      default:
        return null;
    }
  }
}

class CommandPattern {
  final String command;
  final RegExp pattern;

  CommandPattern(this.command, this.pattern);
}

void runTest(String query) {
  SearchQueryDetector searchQueryDetector = SearchQueryDetector(query);
  var result = searchQueryDetector.parseQuery();

  // ignore: avoid_print
  print(result.toString());
}

void main() {
  runTest('show me user John Doe');
  runTest('show me John');
  runTest('show John Doe');
  runTest('hemoglobin less than 7');
  runTest('hemoglobin greater than 7');
  runTest('age less than 40');
  runTest('age greater than 18');
  runTest('age between 18 and 40');
  runTest('ಓಪನ್ ಪ್ರಮಿಳಾ');
  runTest('ಹಿಮೋಗ್ಲೋಬಿನ್ 7 ಗಿಂತ ಕಡಿಮೆ');
  runTest('ಹಿಮೋಗ್ಲೋಬಿನ್ 7 ಗಿಂತ ಹೆಚ್ಚು');
}
