class KannadaPhoneticCode {
  // A mapping of Kannada characters to their phonetic equivalents.
  static const Map<String, String> _kannadaPhoneticMap = {
    'ಅ': 'a',
    'ಆ': 'aa',
    'ಇ': 'i',
    'ಈ': 'ii',
    'ಉ': 'u',
    'ಊ': 'uu',
    'ಋ': 'ru',
    'ೠ': 'ruu',
    'ಎ': 'e',
    'ಏ': 'ee',
    'ಐ': 'ai',
    'ಒ': 'o',
    'ಓ': 'oo',
    'ಔ': 'au',
    'ಅಂ': 'am',
    'ಅಃ': 'aha',
    'ಕ': 'ka',
    'ಖ': 'kha',
    'ಗ': 'ga',
    'ಘ': 'gha',
    'ಙ': 'nga',
    'ಚ': 'cha',
    'ಛ': 'chha',
    'ಜ': 'ja',
    'ಝ': 'jha',
    'ಞ': 'nya',
    'ಟ': 'Ta',
    'ಠ': 'Tha',
    'ಡ': 'Da',
    'ಢ': 'Dha',
    'ಣ': 'Na',
    'ತ': 'ta',
    'ಥ': 'tha',
    'ದ': 'da',
    'ಧ': 'dha',
    'ನ': 'na',
    'ಪ': 'pa',
    'ಫ': 'pha',
    'ಬ': 'ba',
    'ಭ': 'bha',
    'ಮ': 'ma',
    'ಯ': 'ya',
    'ರ': 'ra',
    'ಲ': 'la',
    'ವ': 'va',
    'ಶ': 'sha',
    'ಷ': 'Shha',
    'ಸ': 'sa',
    'ಹ': 'ha',
    'ಳ': 'La',
    'ಕ್ಷ': 'ksha',
    'ಱ': 'Ra',

    // 'ಕ': 'ka',
    'ಕಾ': 'kaa',
    'ಕಿ': 'ki',
    'ಕೀ': 'kii',
    'ಕು': 'ku',
    'ಕೂ': 'kuu',
    'ಕೃ': 'kru',
    'ಕೄ': 'kruu',
    'ಕೆ': 'ke',
    'ಕೇ': 'kee',
    'ಕೈ': 'kai',
    'ಕೊ': 'ko',
    'ಕೋ': 'koo',
    'ಕೌ': 'kau',
    'ಕಂ': 'kam',
    'ಕಃ': 'kaha',

    // 'ಖ' (kha) Kagunita
    'ಖಾ': 'khaa',
    'ಖಿ': 'khi',
    'ಖೀ': 'khii',
    'ಖು': 'khu',
    'ಖೂ': 'khuu',
    'ಖೃ': 'khru',
    'ಖೄ': 'khruu',
    'ಖೆ': 'khe',
    'ಖೇ': 'khee',
    'ಖೈ': 'khai',
    'ಖೊ': 'kho',
    'ಖೋ': 'khoo',
    'ಖೌ': 'khau',
    'ಖಂ': 'kham',
    'ಖಃ': 'khaha',

    // 'ಗ' (ga) Kagunita
    'ಗಾ': 'gaa',
    'ಗಿ': 'gi',
    'ಗೀ': 'gii',
    'ಗು': 'gu',
    'ಗೂ': 'guu',
    'ಗೃ': 'gru',
    'ಗೄ': 'gruu',
    'ಗೆ': 'ge',
    'ಗೇ': 'gee',
    'ಗೈ': 'gai',
    'ಗೊ': 'go',
    'ಗೋ': 'goo',
    'ಗೌ': 'gau',
    'ಗಂ': 'gam',
    'ಗಃ': 'gaha',

    // 'ಘ' (gha) Kagunita
    'ಘಾ': 'ghaa',
    'ಘಿ': 'ghi',
    'ಘೀ': 'ghii',
    'ಘು': 'ghu',
    'ಘೂ': 'ghuu',
    'ಘೃ': 'ghru',
    'ಘೄ': 'ghruu',
    'ಘೆ': 'ghe',
    'ಘೇ': 'ghee',
    'ಘೈ': 'ghai',
    'ಘೊ': 'gho',
    'ಘೋ': 'ghoo',
    'ಘೌ': 'ghau',
    'ಘಂ': 'gham',
    'ಘಃ': 'ghaha',
  };


  // Method to convert a given Kannada word into its phonetic representation.
  static String convertToPhonetic(String input) {
    String result = '';
    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      final nextChar = (i + 1 < input.length) ? input[i + 1] : null;
      final phonetic = _kannadaPhoneticMap[char];

      if (phonetic != null) {
        // If the character has a phonetic representation, add it to the result.
        result += phonetic;
      } else if (nextChar != null) {
        // If the character is not in the map and the next character is 'ಂ' or 'ಃ',
        // then consider it as part of a compound character like 'ಕಂ' or 'ಕಃ'.
        final compoundPhonetic = _kannadaPhoneticMap[char + nextChar];
        if (compoundPhonetic != null) {
          result += compoundPhonetic;
          i++; // Skip the next character as it is already processed.
        } else {
          // If neither the character nor the compound character is in the map,
          // simply add the character to the result as is.
          result += char;
        }
      } else {
        // If there is no next character and the character is not in the map,
        // simply add the character to the result as is.
        result += char;
      }
    }
    return result;
  }
}


test(String word) {
  final phoneticCode = KannadaPhoneticCode.convertToPhonetic(word);
  print('Input: $word');
  print('Phonetic Code: $phoneticCode');
}

void main() {
  test("ರಾಘವೇಂದ್ರ");
  test("ಕನ್ನಡ");
  test("ಚಿಕ್ಕ ತಾಯಮ್ಮ");
}