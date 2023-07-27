import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mcp_app/database/data.dart';
import 'package:mcp_app/ml/search_command_detector.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:drift/drift.dart' as drift;

class HomeController extends GetxController {
  var isSearchWidgetShowing = false.obs;
  var isListening = false.obs;
  var speechToText = SpeechToText();
  var searchEditController = TextEditingController();
  var listenInEnglish = true.obs;
  var showBanner = true.obs;

  var hints = [
    'show me user John Doe',
    'show me John',
    'show John Doe',
    'hemoglobin less than 7',
    'hemoglobin greater than 7',
    'age less than 40',
    'age greater than 18',
    'age between 18 and 40',
    'ಓಪನ್ ಪ್ರಮಿಳಾ',
    'ಹಿಮೋಗ್ಲೋಬಿನ್ 7 ಗಿಂತ ಕಡಿಮೆ',
    'ಹಿಮೋಗ್ಲೋಬಿನ್ 7 ಗಿಂತ ಹೆಚ್ಚು'
  ];

  var selectedIndex = 0.obs;

  var appointsBadgeCount = 3.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
    if(index == 3) {
      addDummyData();
    }
    else if(index == 4) {
      addDummyDataInMixOfKannadaAndEnglish();
    }
    else if(index == 2) {
      showBanner.toggle();
    }
    else if(index == 1) {
      searchEditController.text = '';
      HomeCardListController homeCardListController = Get.find();
      homeCardListController.loadList();
    }
  }

  void toggleSearchWidgetVisibility() {
    if (isSearchWidgetShowing.value == true) {
      _stopListening();
    } else {
      _startListening();
    }
    isSearchWidgetShowing.toggle();
  }

  void toggleListening() {
    if (isListening.value == true) {
      _stopListening();
    } else {
      _startListening();
    }
  }

  Future<void> _startListening() async {
    bool available = await speechToText.initialize(debugLogging: false);
    speechToText.errorListener = (_) {
      _onErrorListener(_);
    };
    speechToText.statusListener = (_) {
      _onStatusListener(_);
    };
    if (available) {
      isListening.value = true;
      var locales = await speechToText.locales();
      speechToText.listen(
          onResult: _onSpeechResult,
          localeId: listenInEnglish.value ? 'en_IN' : 'kn_IN');
    } else {
      EasyLoading.showError("Speech Input Not Available");
      isListening.value = false;
    }
  }

  void _onErrorListener(SpeechRecognitionError errorNotification) {
    print("_onErrorListener: " + errorNotification.errorMsg);
  }

  void _onStatusListener(String status) {
    if (status == 'notListening' || status == 'done') {
      print("_onStatusListener calling from home_controller");
      isListening.value = false;
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    searchEditController.text = result.recognizedWords;
    if (result.finalResult) {
      // EasyLoading.showInfo("Ready to Search");
      HomeCardListController cardListController = Get.find();
      cardListController.loadList(query: searchEditController.text);
    }
  }

  void _stopListening() {
    speechToText.stop();
    isListening.value = false;
  }

  void addDummyData() async {
    MyDatabase database = Get.find();
    database.delete(database.persons).go();

    final List<Map<String, dynamic>> additionalMixedNamesData = [
      {"motherName": "Shweta", "motherAge": 29, "hemoglobin": 11.0},
      {"motherName": "ಕಾವ್ಯಾ", "motherAge": 31, "hemoglobin": 6.0},
      {"motherName": "Reena", "motherAge": 32, "hemoglobin": 10.0},
      {"motherName": "ಅಮೃತಾ", "motherAge": 28, "hemoglobin": 12.0},
      {"motherName": "Anita", "motherAge": 27, "hemoglobin": 6.0},
      {"motherName": "ರಮ್ಯಾ", "motherAge": 33, "hemoglobin": 11.0},
      {"motherName": "Sonal", "motherAge": 26, "hemoglobin": 7.0},
      {"motherName": "ತಾರಾ", "motherAge": 30, "hemoglobin": 10.0},
      {"motherName": "Krithika", "motherAge": 34, "hemoglobin": 9.0},
      {"motherName": "ವಿದ್ಯಾ", "motherAge": 35, "hemoglobin": 6.0},
      {"motherName": "Rashmi", "motherAge": 29, "hemoglobin": 12.0},
      {"motherName": "ಕಿರಣ್", "motherAge": 31, "hemoglobin": 11.0},
      {"motherName": "Neha", "motherAge": 27, "hemoglobin": 6.0},
      {"motherName": "ಅಂಜಲಿ", "motherAge": 28, "hemoglobin": 6.0},
      {"motherName": "Asha", "motherAge": 30, "hemoglobin": 13.0},
      {"motherName": "ಮಾಧುರಿ", "motherAge": 26, "hemoglobin": 7.0},
      {"motherName": "Jyoti", "motherAge": 33, "hemoglobin": 12.0},
      {"motherName": "ನಿಧಿ", "motherAge": 29, "hemoglobin": 11.0},
      {"motherName": "Pooja", "motherAge": 31, "hemoglobin": 10.0},
      {"motherName": "ಸಾಹಿತಿ", "motherAge": 28, "hemoglobin": 9.0},
    ];

    for (var personData in additionalMixedNamesData) {
      database.into(database.persons).insert(PersonsCompanion.insert(
        motherName: personData['motherName'],
        motherAge: drift.Value(personData['motherAge']),
        hemoglobin: drift.Value(personData['hemoglobin']),
      ));
    }
    HomeCardListController homeCardListController = Get.find();
    homeCardListController.loadList();
  }

  void addDummyDataInMixOfKannadaAndEnglish() {
    MyDatabase database = Get.find();
    database.delete(database.persons).go();
    final List<Map<String, dynamic>> karnatakaFemalePersonsData = [
      {"motherName": "Pramila", "motherAge": 26, "hemoglobin": 6.0},
      {"motherName": "Sneha", "motherAge": 30, "hemoglobin": 12.0},
      {"motherName": "Naveena", "motherAge": 28, "hemoglobin": 9.0},
      {"motherName": "Aishwarya", "motherAge": 32, "hemoglobin": 11.0},
      {"motherName": "Shruti", "motherAge": 27, "hemoglobin": 6.0},
      {"motherName": "Deepa", "motherAge": 29, "hemoglobin": 8.0},
      {"motherName": "Latha", "motherAge": 31, "hemoglobin": 13.0},
      {"motherName": "Manasa", "motherAge": 25, "hemoglobin": 6.0},
      {"motherName": "Gowri", "motherAge": 34, "hemoglobin": 10.0},
      {"motherName": "Anjali", "motherAge": 33, "hemoglobin": 9.0},
    ];

    for (var personData in karnatakaFemalePersonsData) {
      database.into(database.persons).insert(PersonsCompanion.insert(
        motherName: personData['motherName'],
        motherAge: drift.Value(personData['motherAge']),
        hemoglobin: drift.Value(personData['hemoglobin']),
      ));
    }
    HomeCardListController homeCardListController = Get.find();
    homeCardListController.loadList();
  }

}

class HomeCardListController extends GetxController {
  RxList<Person> items = <Person>[].obs;
  MyDatabase database = Get.find();

  @override
  void onInit() async {
    super.onInit();
    await loadList();
  }

  void addElement(Person person) {
    items.add(person);
  }

  Future<void> loadList({String? query}) async {
    final queryBuilder = database.select(database.persons);

    if (query != null && query.isNotEmpty) {
      query = query.trim();
    }
    else {
      query = '';
    }

    if (query.isEmpty) {
      List<Person> persons = await queryBuilder.get();
      items.clear();
      items.addAll(persons);
      return;
    }

    SearchQueryDetector searchQueryDetector = SearchQueryDetector(query);
    Map<String, List>? parsedCommand = searchQueryDetector.parseQuery();
    if (parsedCommand == null) {
      EasyLoading.showError("Unable to understand your query", dismissOnTap: true, duration: const Duration(seconds: 1));
      return;
    }

    print(parsedCommand.toString());
    late String commandName;
    late List<dynamic> commandValues;
    parsedCommand.forEach((key, value) {
      commandName = key;
      commandValues = value;
    });

    switch (commandName) {
      case 'name':
        queryBuilder
            .where((person) => person.motherName.like("%${commandValues[0]}%"));
        break;
      case 'hemoglobinLessThan':
        final hemoglobinValue = commandValues[0];
        if (hemoglobinValue != null) {
          queryBuilder.where((person) =>
              person.hemoglobin.isSmallerThanValue(hemoglobinValue));
        }
        break;
      case 'hemoglobinGreaterThan':
        final hemoglobinValue = commandValues[0];
        if (hemoglobinValue != null) {
          queryBuilder.where(
              (person) => person.hemoglobin.isBiggerThanValue(hemoglobinValue));
        }
        break;
      case 'ageLessThan':
        final ageValue = commandValues[0];
        if (ageValue != null) {
          queryBuilder
              .where((person) => person.motherAge.isSmallerThanValue(ageValue));
        }
        break;
      case 'ageGreaterThan':
        final ageValue = commandValues[0];
        if (ageValue != null) {
          queryBuilder
              .where((person) => person.motherAge.isBiggerThanValue(ageValue));
        }
        break;
      case 'ageBetween':
        final minAge = commandValues[0];
        final maxAge = commandValues[1];
        queryBuilder.where(
            (person) => person.motherAge.isBetweenValues(minAge, maxAge));
        break;
      default:
        queryBuilder.where((person) => person.id.equals(0));
    }

    List<Person> persons = await queryBuilder.get();
    items.clear();
    items.addAll(persons);
  }
}
