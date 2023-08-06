// ignore_for_file: avoid_print

import 'package:drift/drift.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mcp_app/database/data.dart';
import 'package:mcp_app/database/repo/mcp_card_repo.dart';
import 'package:mcp_app/ml/search_command_detector.dart';
import 'package:mcp_app/util/health_issue_checker.dart';
import 'package:mcp_app/util/logger.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeController extends GetxController {
  var isSearchWidgetShowing = false.obs;
  var isListening = false.obs;
  var speechToText = SpeechToText();
  var searchEditController = TextEditingController();
  var listenInEnglish = true.obs;
  var showBanner = true.obs;

  var hints = [
    'Display Arpita Profile',
    'View Arpita Profile',
    'Arpita Mahiti',
    // 'ರಮ್ಯಾ ಮಾಹಿತಿಯನ್ನು ತೋರಿಸು',
    // 'ಶ್ವೇತಾ ಪ್ರೊಫೈಲ್ ಅನ್ನು ತೋರಿಸು',
    'Hemoglobin less than 7.0',
    // 'ಹಿಮೋಗ್ಲೋಬಿನ್ 7.0 ಗಿಂತ ಕಡಿಮೆ',
    'Hemoglobin greater than 12.5',
    // 'ಹಿಮೋಗ್ಲೋಬಿನ್ 12.5 ಗಿಂತ ಹೆಚ್ಚು',
    'Age less than 26',
    // 'ವಯಸ್ಸು 26 ಗಿಂತ ಕಡಿಮೆ',
    'Age greater than 28',
    // 'ವಯಸ್ಸು 28 ಗಿಂತ ಹೆಚ್ಚು',
    'BP less than 120/90',
    'BP greater than 120/80',
    'Age between 25 and 30',
    // 'ವಯಸ್ಸು 25 ಮತ್ತು 30 ರ ನಡುವೆ',
  ];

  var selectedIndex = 0.obs;

  var appointsBadgeCount = 3.obs;

  var showClearSearchButton = false.obs;

  void onItemTapped(int index) {
    selectedIndex.value = index;
    if (index == 3) {
      MyDatabase database = Get.find();
      database.delete(database.mCPCards).go();
      EasyLoading.showSuccess("All Cards Deleted Successfully");
      HomeCardListController homeCardListController = Get.find();
      homeCardListController.loadList();
    } else if (index == 4) {
      addDummyData();
    } else if (index == 2) {
      showBanner.toggle();
    } else if (index == 1) {
      EasyLoading.showSuccess("Search Cleared");
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
      speechToText.listen(
          onResult: _onSpeechResult,
          localeId: listenInEnglish.value ? 'en_IN' : 'kn_IN');
    } else {
      EasyLoading.showError("Speech Input Not Available");
      isListening.value = false;
    }
  }

  void _onErrorListener(SpeechRecognitionError errorNotification) {
    print("_onErrorListener: ${errorNotification.errorMsg}");
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
      showClearSearchButton.value = true;
    }
  }

  void _stopListening() {
    speechToText.stop();
    isListening.value = false;
  }

  void addDummyData() async {
    MyDatabase database = Get.find();
    database.delete(database.mCPCards).go();
    MCPCardRepo mcpCardRepo = MCPCardRepo(database);

    mcpCardRepo.addMCPCard(
        motherName: "Nandini Gowda",
        motherAge: 30,
        mothersMobile: "9876543210",
        fatherName: "Avinash Gowda",
        fatherMobile: "8976543210",
        address: "456, 5th Cross, Jayanagar, Mysuru, Karnataka - 570002",
        sBp: 110,
        dBp: 70,
        healthIssues: [],
        hemoglobin: 12.5,
        bankName: "Axis Bank",
        branchName: "Kuvempunagar",
        accountNumber: "1234567890987",
        ifscCode: "UTIB0000123"
    );


    mcpCardRepo.addMCPCard(
        motherName: "Divya Hegde",
        motherAge: 25,
        mothersMobile: "9876543210",
        fatherName: "Rajesh Hegde",
        fatherMobile: "8976543210",
        address: "789, Main Road, Udupi, Karnataka - 576101",
        sBp: 145,
        dBp: 95,
        healthIssues: ["Thyroid", "Diabetes", "BP"],
        hemoglobin: 6.5,
        bankName: "ICICI Bank",
        branchName: "Manipal",
        accountNumber: "9876543210123",
        ifscCode: "ICIC0000123"
    );

    mcpCardRepo.addMCPCard(
        motherName: "Kavitha",
        motherAge: 32,
        mothersMobile: "9876543210",
        fatherName: "Suresh",
        fatherMobile: "8976543210",
        address: "100, 3rd Main, Koramangala, Bengaluru, Karnataka - 560034",
        sBp: 115,
        dBp: 75,
        healthIssues: [],
        hemoglobin: 14.8,
        bankName: "State Bank Of India",
        branchName: "Koramangala",
        accountNumber: "1234567890123",
        ifscCode: "SBIN0001234"
    );

    mcpCardRepo.addMCPCard(
        motherName: "Meera Deshpande",
        motherAge: 27,
        mothersMobile: "9876543210",
        fatherName: "Vikram Deshpande",
        fatherMobile: "8976543210",
        address: "321, Gandhi Nagar, Belagavi, Karnataka - 590001",
        sBp: 85,
        dBp: 55,
        healthIssues: ["BP"],
        hemoglobin: 13.2,
        bankName: "Canara Bank",
        branchName: "Gandhi Nagar",
        accountNumber: "9876543210345",
        ifscCode: "CNRB0000123"
    );

    mcpCardRepo.addMCPCard(
        motherName: "Swathi Patel",
        motherAge: 29,
        mothersMobile: "9876543210",
        fatherName: "Amit Patel",
        fatherMobile: "8976543210",
        address: "234, MG Road, Hubballi, Karnataka - 580001",
        sBp: 120,
        dBp: 80,
        healthIssues: ["Thyroid", "Anemia"],
        hemoglobin: 12.9,
        bankName: "Bank of Baroda",
        branchName: "MG Road",
        accountNumber: "1234567890123",
        ifscCode: "BARB0000123"
    );

    mcpCardRepo.addMCPCard(
        motherName: "Anusha Gowda",
        motherAge: 31,
        mothersMobile: "9876543210",
        fatherName: "Vikas Gowda",
        fatherMobile: "8976543210",
        address: "55, Kaveri Nagar, Davanagere, Karnataka - 577001",
        sBp: 118,
        dBp: 75,
        healthIssues: [],
        hemoglobin: 13.5,
        bankName: "Punjab National Bank",
        branchName: "Kaveri Nagar",
        accountNumber: "9876543210123",
        ifscCode: "PNB00001234"
    );

    mcpCardRepo.addMCPCard(
        motherName: "Deepika Rao",
        motherAge: 26,
        mothersMobile: "9876543210",
        fatherName: "Prashant Rao",
        fatherMobile: "8976543210",
        address: "456, Rajajinagar, Shivamogga, Karnataka - 577201",
        sBp: 90,
        dBp: 60,
        healthIssues: ["BP"],
        hemoglobin: 12.0,
        bankName: "Bank of India",
        branchName: "Rajajinagar",
        accountNumber: "1234567890123",
        ifscCode: "BKID0000123"
    );

    mcpCardRepo.addMCPCard(
        motherName: "Arpita",
        motherAge: 29,
        mothersMobile: "9876543210",
        fatherName: "Siddharth Rao",
        fatherMobile: "8976543210",
        address: "789, Vidyanagar, Tumakuru, Karnataka - 572101",
        sBp: 120,
        dBp: 78,
        healthIssues: [],
        hemoglobin: 14.8,
        bankName: "Union Bank of India",
        branchName: "Vidyanagar",
        accountNumber: "9876543210123",
        ifscCode: "UBIN0000123"
    );

    mcpCardRepo.addMCPCard(
        motherName: "Divya Kumar",
        motherAge: 27,
        mothersMobile: "9876543210",
        fatherName: "Rajesh Kumar",
        fatherMobile: "8976543210",
        address: "100, Gandhi Road, Dharwad, Karnataka - 580001",
        sBp: 120,
        dBp: 80,
        healthIssues: [],
        hemoglobin: 13.8,
        bankName: "Central Bank of India",
        branchName: "Gandhi Road",
        accountNumber: "1234567890123",
        ifscCode: "CBIN0000123"
    );

    mcpCardRepo.addMCPCard(
        motherName: "Anjali Gupta",
        motherAge: 33,
        mothersMobile: "9876543210",
        fatherName: "Rahul Gupta",
        fatherMobile: "8976543210",
        address: "321, Hanumanthnagar, Ballari, Karnataka - 583101",
        sBp: 118,
        dBp: 75,
        healthIssues: ["Diabetes"],
        hemoglobin: 14.5,
        bankName: "IDBI Bank",
        branchName: "Hanumanthnagar",
        accountNumber: "9876543210123",
        ifscCode: "IBKL0000123"
    );


    EasyLoading.showSuccess("Added Sample Cards");

    HomeCardListController homeCardListController = Get.find();
    homeCardListController.loadList();
  }
}

class HomeCardListController extends GetxController {
  RxList<MCPCard> items = <MCPCard>[].obs;
  MyDatabase database = Get.find();
  HomeController homeController = Get.find();
  var totalItemsInDb = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await loadList();
  }


  void addElement(MCPCard mcpCard) async {
    // homeController.showClearSearchButton.value = false;
    // homeController.searchEditController.text = '';
    // loadList();
    items.insert(0, mcpCard);
    var countExp = database.mCPCards.id.count();
    final countQuery = database.selectOnly(database.mCPCards)
      ..addColumns([countExp]);
    totalItemsInDb.value = (await countQuery.map((row) => row.read(countExp)).getSingle())!;
  }


  Future<void> loadList({String? query, String? sortBy}) async {

    print("Sort By: $sortBy");
    // update total items count
    var countExp = database.mCPCards.id.count();
    final countQuery = database.selectOnly(database.mCPCards)
      ..addColumns([countExp]);
    totalItemsInDb.value = (await countQuery.map((row) => row.read(countExp)).getSingle())!;

    if (query != null && query.isNotEmpty) {
      query = query.trim();
      query = query.toLowerCase();
    } else {
      query = '';
    }

    final queryBuilder = database.select(database.mCPCards);

    if (query.isEmpty) {
      // load all persons normally
      queryBuilder.orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)]);
      if(sortBy != null) {
        if (sortBy == 'Newest Registrations First') {
          queryBuilder.orderBy([
                (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
          ]);
        }
        else if (sortBy == 'Oldest Registrations First') {
          queryBuilder.orderBy([
                (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc)
          ]);
        }
      }
      items.value = await queryBuilder.get();
      return;
    }

    SearchQueryDetector searchQueryDetector = SearchQueryDetector(query);
    print("Search For: $query");
    Map<String, List>? parsedCommand = searchQueryDetector.parseQuery();
    if (parsedCommand == null) {
      print("Failed to parse the command: Processing Normal Search");
      // search commands are not valid - do normal search

      int? mcpcId = int.tryParse(query);
      if (mcpcId == null) {
        // Check if the string is prefixed with "MCPC"
        if (query.startsWith("mcpc", 0)) {
          String numericPart = query.substring(4);
          mcpcId = int.tryParse(numericPart);
          queryBuilder.where((mcpCard) => mcpCard.id.equals(mcpcId!));
        }
      }
      else {
        queryBuilder.where((mcpCard) => mcpCard.id.equals(mcpcId!));
      }

      if(mcpcId != null) {
        if(sortBy != null) {
          if(sortBy == 'Newest Registrations First') {
            queryBuilder.orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)]);
          }
          else if(sortBy == 'Oldest Registrations First') {
            queryBuilder.orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc)]);
          }
        }
        items.value = await queryBuilder.get();
        return;
      }

      // user is not searching for id try name search
      String name = query;
      String? phoneticName = PhoneticHelper.generatePhonetic(name);
      queryBuilder.where((mCPCards) {
        if(phoneticName != null) {
          return mCPCards.motherName.like("%$name%") | mCPCards.motherNamePhonetic.equals(phoneticName);
        } else {
          return mCPCards.motherName.like("%$name%");
        }
      });

      if(sortBy != null) {
        if (sortBy == 'Newest Registrations First') {
          queryBuilder.orderBy([
                (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
          ]);
        }
        else if (sortBy == 'Oldest Registrations First') {
          queryBuilder.orderBy([
                (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc)
          ]);
        }
      }

      items.value = await queryBuilder.get();
      return;
    }

    logd("$query: $parsedCommand");
    late String commandName;
    late List<dynamic> commandValues;
    parsedCommand.forEach((key, value) {
      commandName = key;
      commandValues = value;
    });

    switch (commandName) {
      case 'name':
        String? phoneticString = PhoneticHelper.generatePhonetic(commandValues[0]);
        queryBuilder.where((mcpCard) {
          if(phoneticString != null) {
            return mcpCard.motherName.like("%${commandValues[0]}%") | mcpCard.motherNamePhonetic.equals(phoneticString);
          } else {
            return mcpCard.motherName.like("%${commandValues[0]}%");
          }
        });
        homeController.searchEditController.text = commandValues[0] + " ಮಾಹಿತಿ";
        break;
      case 'hemoglobinLessThan':
        final hemoglobinValue = double.tryParse(commandValues[0]);
        if (hemoglobinValue != null) {
          queryBuilder.where((mcpCard) =>
              mcpCard.hemoglobin.isSmallerThanValue(hemoglobinValue));
        }
        break;
      case 'hemoglobinGreaterThan':
        final hemoglobinValue = double.tryParse(commandValues[0]);
        if (hemoglobinValue != null) {
          queryBuilder.where(
              (mcpCard) => mcpCard.hemoglobin.isBiggerThanValue(hemoglobinValue));
        }
        break;
      case 'ageLessThan':
        final ageValue = int.tryParse(commandValues[0]);
        if (ageValue != null) {
          queryBuilder
              .where((mcpCard) => mcpCard.motherAge.isSmallerThanValue(ageValue));
        }
        break;
      case 'ageGreaterThan':
        final ageValue = int.tryParse(commandValues[0]);
        if (ageValue != null) {
          queryBuilder
              .where((mcpCard) => mcpCard.motherAge.isBiggerThanValue(ageValue));
        }
        break;
      case 'ageBetween':
        final minAge = int.tryParse(commandValues[0]);
        final maxAge = int.tryParse(commandValues[1]);
        queryBuilder.where((mcpCard) => mcpCard.motherAge.isBetweenValues(minAge!, maxAge!));
        break;

      case 'bpGreaterThan':
        final sBp = int.tryParse((commandValues[0]));
        final dBp = int.tryParse(commandValues[1]);
        if (sBp != null && dBp != null) {
          queryBuilder.where((mcpCard) => mcpCard.sBp.isBiggerThanValue(sBp) & mcpCard.dBp.isBiggerThanValue(dBp));
        }
        break;

      case 'bpLessThan':
        final sBp = int.tryParse(commandValues[0]);
        final dBp = int.tryParse(commandValues[1]);
        if (sBp != null && dBp != null) {
          queryBuilder.where((mcpCard) => mcpCard.sBp.isSmallerThanValue(sBp) & mcpCard.dBp.isSmallerThanValue(dBp));
        }
        break;
      case 'lowBp':
        queryBuilder.where((mcpCard) => mcpCard.sBp.isSmallerThanValue(HealthIssueChecker.lowSystolicBpThreshold) & mcpCard.dBp.isSmallerThanValue(HealthIssueChecker.lowDiastolicBpThreshold));
        break;
      case 'highBp':
        queryBuilder.where((mcpCard) => mcpCard.sBp.isBiggerThanValue(HealthIssueChecker.highSystolicBpThreshold) & mcpCard.dBp.isBiggerThanValue(HealthIssueChecker.highDiastolicBpThreshold));
        break;

      default:
        queryBuilder.where((mcpCard) => mcpCard.id.equals(0));
    }

    if(sortBy != null) {
      if (sortBy == 'Newest Registrations First') {
        queryBuilder.orderBy([
              (t) =>
              OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc)
        ]);
      }
      else if (sortBy == 'Oldest Registrations First') {
        queryBuilder.orderBy([
              (t) =>
              OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc)
        ]);
      }
    }
    items.value = await queryBuilder.get();
  }
}
