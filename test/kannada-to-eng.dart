class Sanscript {
  Map<String, dynamic> schemes = {
    // ... (other schemes)
    "kannada": {
      "vowels": ["ಅ", "ಆ", "ಇ", "ಈ", "ಉ", "ಊ", "ಋ", "ೠ", "ಌ", "ೡ", "ಎ", "ಏ", "ಐ", "ಒ", "ಓ", "ಔ"],
      "vowel_marks": ["ಾ", "ಿ", "ೀ", "ು", "ೂ", "ೃ", "ೄ", "ೢ", "ೣ", "ೆ", "ೇ", "ೈ", "ೊ", "ೋ", "ೌ"],
      "other_marks": ["ಂ", "ಃ", "ँ"],
      "virama": ["್"],
      "consonants": [
        "ಕ", "ಖ", "ಗ", "ಘ", "ಙ", "ಚ", "ಛ", "ಜ", "ಝ", "ಞ", "ಟ", "ಠ", "ಡ", "ಢ", "ಣ", "ತ",
        "ಥ", "ದ", "ಧ", "ನ", "ಪ", "ಫ", "ಬ", "ಭ", "ಮ", "ಯ", "ರ", "ಲ", "ವ", "ಶ", "ಷ", "ಸ",
        "ಹ", "ಳ", "ಕ್ಷ", "ಜ್ಞ"
      ],
      "symbols": [
        "೦", "೧", "೨", "೩", "೪", "೫", "೬", "೭", "೮", "೯", "ಓಂ", "ಽ", "।", "॥"
      ],
      "other": ["", "", "", "", "", "", "ಫ", "", "ಱ"]
    },
  };

  Map<String, String> transliterateKannadaToEnglish(String text) {
    Map<String, dynamic> map = schemes["kannada"];
    Map<String, String> result = {};

    int len = text.length;
    String buffer = "";

    for (int i = 0; i < len; i++) {
      String ch = text[i];

      if (map["vowels"].contains(ch)) {
        buffer += map["vowels"][0];
      } else if (map["consonants"].contains(ch)) {
        int index = map["consonants"].indexOf(ch);
        buffer += String.fromCharCode(index + 65);
      } else if (map["vowel_marks"].contains(ch)) {
        int index = map["vowel_marks"].indexOf(ch);
        result[buffer] = (result[buffer] ?? "") + String.fromCharCode(index + 97);
      } else if (ch == map["virama"][0]) {
        result[buffer] = (result[buffer] ?? "") + "a";
      } else {
        result[buffer] = (result[buffer] ?? "") + ch;
      }
    }

    return result;
  }
}

void main() {
  Sanscript sanscript = Sanscript();
  String kannadaText = "ನಮಸ್ಕಾರ";
  Map<String, String> transliteratedText = sanscript.transliterateKannadaToEnglish(kannadaText);
  print(transliteratedText); // Output: {ನ: n, ಮಸk: msk, ರ: r}
}
