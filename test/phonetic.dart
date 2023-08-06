import 'package:dart_phonetics/dart_phonetics.dart';

import 'table.dart';

void printTables(List<List<String>> table) {
  if (table.isEmpty) {
    print("Table is empty.");
    return;
  }

  // Find the maximum length of each column to format the table properly.
  List<int> columnWidths = List.filled(table[0].length, 0);
  for (List<String> row in table) {
    for (int i = 0; i < row.length; i++) {
      if (row[i].length > columnWidths[i]) {
        columnWidths[i] = row[i].length;
      }
    }
  }

  // Print the table.
  for (List<String> row in table) {
    for (int i = 0; i < row.length; i++) {
      String cell = row[i];
      String paddedCell = cell.padRight(columnWidths[i] + 2);
      print(paddedCell);
    }
    print(""); // Add an empty line between rows.
  }
}

void main() {

  // List<String> stringsToTest = [
  //   "Aarav",
  //   "Arav",
  //   "Aditi",
  //   "Aaditi",
  //   "Aryan",
  //   "Aaryan",
  //   "Aarush",
  //   "Arush",
  //   "Ishaan",
  //   "Ishan",
  //   "Advait",
  //   "Adwait",
  //   "Aanya",
  //   "Anya",
  //   "Advika",
  //   "Advikaa",
  //   "Aayush",
  //   "Ayush",
  //   "Aadhya",
  //   "Adhya",
  //   "Reyansh",
  //   "Rayansh",
  //   "Aahana",
  //   "Ahana",
  //   "Vihaan",
  //   "Vihan",
  // ];

  List<String> stringsToTest = [
    "ಹಿಮೋಗ್ಲೋಬಿನ್",
    "ಹಿಮಗ್ಲೋಬಿನ್",
    "Shwetha",
    "Shwetha Gowda",
    "Sweta gouda",
    "Swati gowda",
    "Spoorti Gowda",
    "Spruti Gouda",
    "Preethi",
    "Preeti",
    "Dilip",
    "Dileep",
    "Sea Level",
    "See Level",
    "Blood Pressure",
    "Blodd Presure",
    "Blood Pressure less than 120/80",
    "Blood Pressure less than 120/90",
  ];

  // List<String> stringsToTest = [
  //   "Blood Presure",
  //   "Blood Pressure",
  //   "Hemoglobin",
  //   "Hemoglobin",
  //   "Mathematics",
  //   "Mathamatics"
  // ];





  List<String> headers = ["original", "soundex ", "customSoundex", "refinedSoundex", "nysiisOriginal", "nysiisModified", "doubleMetaphone"];
  List<List<String>> rows = [];

  rows.add(headers);

  for(String s in stringsToTest) {
    List<String> row = [];
    row.add(s);

    final soundex = Soundex.americanEncoder;
    PhoneticEncoding? soundexPe = soundex.encode(s);
    row.add(soundexPe != null ? soundexPe.primary : 'null');

    final customSoundex = Soundex.fromMapping(Soundex.americanMapping, maxLength: 0, paddingEnabled: false, ignoreHW: false);
    PhoneticEncoding? customSoundexPe = customSoundex.encode(s);
    row.add(customSoundexPe != null ? customSoundexPe.primary : 'null');

    final refinedSoundex = RefinedSoundex.defaultEncoder;
    PhoneticEncoding? refinedSoundexPe = refinedSoundex.encode(s);
    row.add(refinedSoundexPe != null ? refinedSoundexPe.primary : 'null');

    final nysiisOriginal = Nysiis.originalEncoder;
    PhoneticEncoding? nysiisOriginalPe = nysiisOriginal.encode(s);
    row.add(nysiisOriginalPe != null ? nysiisOriginalPe.primary : 'null');

    final nysiisModified = Nysiis.withOptions(maxLength: 0, enableModified: true);
    PhoneticEncoding? nysiisModifiedPe = nysiisOriginal.encode(s);
    row.add(nysiisModifiedPe != null ? nysiisModifiedPe.primary : 'null');

    final doubleMetaphone = DoubleMetaphone.withMaxLength(12);
    PhoneticEncoding? doubleMetaphonePe = doubleMetaphone.encode(s);
    row.add(doubleMetaphonePe != null ? doubleMetaphonePe.primary : 'null');


    rows.add(row);
  }

  TablePrinter tablePrinter = TablePrinter(rows);
  tablePrinter.printTable();
}
