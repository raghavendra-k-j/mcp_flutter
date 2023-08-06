class SearchQueryDetector {
  String? query;

  SearchQueryDetector(this.query);

  Map<String, List>? parseQuery() {
    if(query == null || query!.isEmpty) return null;
    query = query!.trim();
    query = query!.toLowerCase();
    var commandPatterns = [

      CommandPattern('name', RegExp(r"^display (.+) profile$")),
      CommandPattern('name', RegExp(r"^view (.+) profile$")),
      CommandPattern('name', RegExp(r"^(.+) mahiti$")),
      CommandPattern('name', RegExp(r"^(.+) profile$")),
      CommandPattern('name', RegExp(r"^(.+) mahithi$")),
      CommandPattern('name', RegExp(r"^(.+) ಮಾಹಿತಿಯನ್ನು ತೋರಿಸು$")),
      CommandPattern('name', RegExp(r"^(.+) ಮಾಹಿತಿ ತೋರಿಸು$")),
      CommandPattern('name', RegExp(r"^(.+) ಪ್ರೊಫೈಲ್ ಅನ್ನು ತೋರಿಸು$")),
      CommandPattern('name', RegExp(r"^(.+) ಪ್ರೊಫೈಲ್ ತೋರಿಸು$")),

      CommandPattern('hemoglobinLessThan', RegExp(r"^hemoglobin less than (\d+(?:\.\d+)?)")),
      CommandPattern('hemoglobinLessThan', RegExp(r"^hb less than (\d+(?:\.\d+)?)")),
      CommandPattern('hemoglobinLessThan', RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್ (\d+(?:\.\d+)?) ಗಿಂತ ಕಡಿಮೆ")),
      // CommandPattern('hemoglobinLessThan', RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್ (.+) ಗಿಂತ ಕಡಿಮೆ")),
      CommandPattern('hemoglobinLessThan', RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್(\d+(?:\.\d+)?) ಗಿಂತ ಕಡಿಮೆ")),
      CommandPattern('hemoglobinLessThan', RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್ (\d+(?:\.\d+)?) ಕ್ಕಿಂತ ಕಡಿಮೆ")),
      CommandPattern('hemoglobinLessThan', RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್ (\d+(?:\.\d+)?)ಕ್ಕಿಂತ ಕಡಿಮೆ")),
      CommandPattern('hemoglobinLessThan', RegExp(r"^ಹೆಚ್ ಬಿ (\d+(?:\.\d+)?) ಗಿಂತ ಕಡಿಮೆ")),
      CommandPattern('hemoglobinLessThan', RegExp(r"^ಹೆಚ್ ಬಿ (\d+(?:\.\d+)?) ಕ್ಕಿಂತ ಕಡಿಮೆ")),
      CommandPattern('hemoglobinLessThan', RegExp(r"^ಹೆಚ್ ಬಿ (\d+(?:\.\d+)?)ಕ್ಕಿಂತ ಕಡಿಮೆ")),

      CommandPattern('hemoglobinGreaterThan', RegExp(r"^hemoglobin greater than (\d+(?:\.\d+)?)")),
      CommandPattern('hemoglobinGreaterThan', RegExp(r"^hb greater than (\d+(?:\.\d+)?)")),
      CommandPattern('hemoglobinGreaterThan', RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್ (\d+(?:\.\d+)?) ಗಿಂತ ಹೆಚ್ಚು")),
      // CommandPattern('hemoglobinGreaterThan', RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್ (.+) ಗಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('hemoglobinGreaterThan', RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್(\d+(?:\.\d+)?) ಗಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('hemoglobinGreaterThan', RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್ (\d+(?:\.\d+)?) ಕ್ಕಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('hemoglobinGreaterThan', RegExp(r"^ಹಿಮೋಗ್ಲೋಬಿನ್ (\d+(?:\.\d+)?)ಕ್ಕಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('hemoglobinGreaterThan', RegExp(r"^ಹೆಚ್ ಬಿ (\d+(?:\.\d+)?) ಗಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('hemoglobinGreaterThan', RegExp(r"^ಹೆಚ್ ಬಿ (\d+(?:\.\d+)?) ಕ್ಕಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('hemoglobinGreaterThan', RegExp(r"^ಹೆಚ್ ಬಿ (\d+(?:\.\d+)?)ಕ್ಕಿಂತ ಹೆಚ್ಚು")),

      CommandPattern('ageLessThan', RegExp(r"^age less than (\d+)")),
      CommandPattern('ageLessThan', RegExp(r"^ವಯಸ್ಸು (\d+) ಗಿಂತ ಕಡಿಮೆ")),
      CommandPattern('ageLessThan', RegExp(r"^ವಯಸ್ಸು (\d+) ಕ್ಕಿಂತ ಕಡಿಮೆ")),
      CommandPattern('ageLessThan', RegExp(r"^ವಯಸ್ಸು (\d+)ಕ್ಕಿಂತ ಕಡಿಮೆ")),

      CommandPattern('ageGreaterThan', RegExp(r"^age greater than (\d+)")),
      CommandPattern('ageGreaterThan', RegExp(r"^ವಯಸ್ಸು (\d+) ಗಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('ageGreaterThan', RegExp(r"^ವಯಸ್ಸು (\d+) ಕ್ಕಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('ageGreaterThan', RegExp(r"^ವಯಸ್ಸು (\d+)ಕ್ಕಿಂತ ಹೆಚ್ಚು")),

      CommandPattern('ageBetween', RegExp(r"^ವಯಸ್ಸು (\d+) ಮತ್ತು (\d+) ರ ನಡುವೆ")),
      CommandPattern('ageBetween', RegExp(r"^age between (\d+) and (\d+)")),

      CommandPattern('bpLessThan', RegExp(r"^ಬಿಪಿ (\d+)/(\d+) ಗಿಂತ ಕಡಿಮೆ")),
      CommandPattern('bpLessThan', RegExp(r"^ಬಿಪಿ (\d+)/(\d+) ಕ್ಕಿಂತ ಕಡಿಮೆ")),
      CommandPattern('bpLessThan', RegExp(r"^ಬಿಪಿ (\d+)/(\d+)ಕ್ಕಿಂತ ಕಡಿಮೆ")),
      CommandPattern('bpLessThan', RegExp(r"^bp less than (\d+)/(\d+)")),
      CommandPattern('bpLessThan', RegExp(r"^bp less than (\d+) / (\d+)")),
      CommandPattern('bpLessThan', RegExp(r"^bp less than (\d+) bar (\d+)")),

      CommandPattern('bpGreaterThan', RegExp(r"^ಬಿಪಿ (\d+)/(\d+) ಗಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('bpGreaterThan', RegExp(r"^ಬಿಪಿ (\d+)/(\d+) ಕ್ಕಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('bpGreaterThan', RegExp(r"^ಬಿಪಿ (\d+)/(\d+)ಕ್ಕಿಂತ ಹೆಚ್ಚು")),
      CommandPattern('bpGreaterThan', RegExp(r"^bp greater than (\d+)/(\d+)")),
      CommandPattern('bpGreaterThan', RegExp(r"^bp greater than (\d+) / (\d+)")),
      CommandPattern('bpGreaterThan', RegExp(r"^bp greater than (\d+) bar (\d+)")),

      CommandPattern('lowBp', RegExp(r"^view profiles having low bp$")),
      CommandPattern('highBp', RegExp(r"^view profiles having high bp$")),
    ];

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
    List<String> params = [];
    for(int i = 1; i <= match.groupCount; i ++) {
      params.add(match.group(i)!);
    }
    return {
      command : params
    };
    // switch (command) {
    //   case 'name':
    //     return {
    //       command: [match.group(1)]
    //     };
    //   case 'hemoglobinLessThan':
    //   case 'hemoglobinGreaterThan':
    //     return {
    //       command: [double.tryParse(match.group(1) ?? '') ?? 0.0]
    //     };
    //   case 'ageLessThan':
    //   case 'ageGreaterThan':
    //     return {
    //       command: [int.tryParse(match.group(1) ?? '') ?? 0]
    //     };
    //   case 'bpGreaterThan':
    //   case 'bpLessThan':
    //     return {
    //       command: [int.tryParse(match.group(1) ?? '') ?? 0, int.tryParse(match.group(2) ?? '') ?? 0]
    //     };
    //   case 'ageBetween':
    //     return {
    //       'ageBetween': [
    //         int.tryParse(match.group(1) ?? '') ?? 0,
    //         int.tryParse(match.group(2) ?? '') ?? 0
    //       ]
    //     };
    //   default:
    //     return null;
    // }
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
