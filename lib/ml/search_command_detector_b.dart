class SearchQueryDetector {
  String query;

  SearchQueryDetector(this.query);

  Map<String, dynamic>? parseQuery() {
    var commandPatterns = [
      CommandPattern('nameWithUser', RegExp(r"^show me user (.+)")),
      CommandPattern('nameKannada', RegExp(r"^ಓಪನ್ (.+)")),
      CommandPattern('nameEnglish', RegExp(r"^show me (.+)")),
      CommandPattern('nameAltEnglish', RegExp(r"^show (.+)")),
      CommandPattern(
          'hemoglobinLessThan', RegExp(r"^hemoglobin less than (\d+(\.\d+)?)")),
      CommandPattern('hemoglobinGreaterThan',
          RegExp(r"^hemoglobin greater than (\d+(\.\d+)?)")),
      CommandPattern('hemoglobinKannadaLessThan',
          RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್ (\d+(\.\d+)?) ಗಿಂತ ಕಡಿಮಿ")),
      CommandPattern('hemoglobinKannadaGreaterThan',
          RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್ (\d+(\.\d+)?) ಗಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('ageLessThan', RegExp(r"^age less than (\d+)")),
      CommandPattern('ageGreaterThan', RegExp(r"^age greater than (\d+)")),
      CommandPattern('ageBetween', RegExp(r"^age between (\d+) and (\d+)")),
    ];

    // Try to match the query with each command's pattern
    for (var commandPattern in commandPatterns) {
      var pattern = commandPattern.pattern;
      var match = pattern.firstMatch(query);
      if (match != null) {
        return _parseParameters(commandPattern.command, match);
      }
    }

    return null; // No match found
  }

  Map<String, dynamic> _parseParameters(String command, RegExpMatch match) {
    switch (command) {
      case 'nameWithUser':
      case 'nameEnglish':
      case 'nameAltEnglish':
      case 'nameKannada':
        return {
          command: [match.group(1)]
        };
      case 'hemoglobinLessThan':
      case 'hemoglobinGreaterThan':
      case 'hemoglobinKannadaLessThan':
      case 'hemoglobinKannadaGreaterThan':
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
        return {'command': null, 'params': []};
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
  runTest('ಹಿಮೋಗ್ಲೋಬಿನ್ 7 ಗಿಂತ ಕಡಿಮಿ');
  runTest('ಹಿಮೋಗ್ಲೋಬಿನ್ 7 ಗಿಂತ ಹೆಚ್ಚು');
}
