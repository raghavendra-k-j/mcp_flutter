// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:drift/drift.dart' as drift;
import 'package:faker/faker.dart' as f;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:mcp_app/database/data.dart';
import 'package:mcp_app/widgets/loading.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AddPersonController extends GetxController {
  var motherNameEditingController = TextEditingController();
  var motherAgeEditingController = TextEditingController();
  var motherMobileNumberEditingController = TextEditingController();
  var fatherNameEditingController = TextEditingController();
  var fatherMobileNumberEditingController = TextEditingController();
  var addressEditingController = TextEditingController();
  var mctsOrRchIdEditingController = TextEditingController();

  var bankNameEditingController = TextEditingController();
  var branchNameEditingController = TextEditingController();
  var accountNumberEditingController = TextEditingController();
  var ifscCodeEditingController = TextEditingController();

  var lmpEditingController = TextEditingController();
  var eddEditingController = TextEditingController();
  var hemoglobinEditingController = TextEditingController();

  var mchIdEditingController = TextEditingController();

  var isListening = false.obs;
  var speechToText = SpeechToText();
  var listenInEnglish = false.obs;


  late TextEditingController activeSpeechRecognitionController;

  var isDiabetesChecked = false.obs;

  var isBPChecked = false.obs;

  var isAnemiaChecked = false.obs;

  var isThyroidChecked = false.obs;

  AddPersonController();

  late MyDatabase _db;
  late f.Faker _faker;

  @override
  void onInit() {
    super.onInit();
    _db = Get.find();
    _faker = Get.find();
    motherNameEditingController.text = _faker.person.name();
    fatherNameEditingController.text = _faker.person.name();
    motherAgeEditingController.text =
        _faker.randomGenerator.integer(35, min: 22).toString();
  }

  void toggleListening(TextEditingController textEditingController) {
    if (isListening.value == true) {
      stopListening();
    } else {
      startListening(textEditingController);
    }
  }

  Future<void> startListening(
      TextEditingController textEditingController) async {
    activeSpeechRecognitionController = textEditingController;
    bool available = await speechToText.initialize(debugLogging: false);
    speechToText.statusListener = (_) {
      _onStatusListener(_);
    };
    speechToText.errorListener = (_) {
      _onErrorListener(_);
    };
    if (available) {
      isListening.value = true;
      var locales = await speechToText.locales();
      speechToText.listen(onResult: _onSpeechResult, localeId: listenInEnglish.value ? 'en_IN' : 'kn_IN');
    } else {
      EasyLoading.showError("Speech Input Not Available");
      isListening.value = false;
    }
  }

  void _onErrorListener(SpeechRecognitionError errorNotification) {
    print("_onErrorListener: ${errorNotification.errorMsg}");
  }

  void _onStatusListener(String status) {
    print("_onStatusListener: $status");
    if (status == 'notListening' || status == 'done') {
      print("_onStatusListener calling from AddPersonController");
      isListening.value = false;
      EasyLoading.showInfo(isListening.value as String);
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    activeSpeechRecognitionController.text = result.recognizedWords;
  }

  void stopListening() {
    speechToText.stop();
    isListening.value = false;
  }

  Future<Person?> addPerson(BuildContext context) async {
    LoadingDialog.show(context, text: "Just a Second");

    String motherName = motherNameEditingController.text.trim();
    dynamic mothersAge = motherAgeEditingController.text.trim();
    String mothersMobile = motherMobileNumberEditingController.text.trim();
    String fatherName = fatherNameEditingController.text.trim();
    String fatherMobile = fatherMobileNumberEditingController.text.trim();
    String address = addressEditingController.text.trim();
    String mctsOrRchId = mctsOrRchIdEditingController.text.trim();
    String mchId = mctsOrRchIdEditingController.text.trim();

    List<String> heathIssues = [];
    var isDiabetesChecked = false.obs;
    if (isDiabetesChecked.value) {
      heathIssues.add("Diabetes");
    }
    if (isBPChecked.value) {
      heathIssues.add("BP");
    }
    if (isAnemiaChecked.value) {
      heathIssues.add("Anemia");
    }
    if (isThyroidChecked.value) {
      heathIssues.add("Thyroid");
    }

    String bankName = bankNameEditingController.text.trim();
    String branchName = branchNameEditingController.text.trim();
    String accountNumber = accountNumberEditingController.text.trim();
    String ifscCode = ifscCodeEditingController.text.trim();

    String lmp = lmpEditingController.text.trim();
    String edd = eddEditingController.text.trim();
    dynamic hemoglobin = hemoglobinEditingController.text.trim();

    if (motherName.isEmpty) {
      EasyLoading.showInfo("Mother's Name is Required");
      hideDialog(context);
      return null;
    }

    if (fatherName.isEmpty) {
      EasyLoading.showInfo("Father's Name is Required");
      hideDialog(context);
      return null;
    }

    if (mothersAge.isNotEmpty) {
      try {
        mothersAge = int.parse(mothersAge);
      } catch (e) {
        EasyLoading.showInfo("Please Enter Valid Age");
        hideDialog(context);
        return null;
      }
    } else {
      EasyLoading.showInfo("Please Enter Mothers Age");
      hideDialog(context);
      return null;
    }

    if (hemoglobin.isNotEmpty) {
      try {
        hemoglobin = double.parse(hemoglobin);
      } catch (e) {
        EasyLoading.showInfo("Please Enter Valid Hemoglobin level");
        hideDialog(context);
        return null;
      }
    }

    PersonsCompanion validPerson = PersonsCompanion.insert(
      motherName: motherName,
      motherAge: drift.Value(mothersAge as int),
      mothersMobile: drift.Value(mothersMobile),
      fatherName: drift.Value(fatherName),
      fatherMobile: drift.Value(fatherMobile),
      address: drift.Value(address),
      mctsOrRchId: drift.Value(mctsOrRchId),
      mchId: drift.Value(mchId),
      lmp: drift.Value(lmp),
      edd: drift.Value(edd),
      hemoglobin: drift.Value((hemoglobin is String) ? null : hemoglobin),
      healthIssues: drift.Value(heathIssues),
      bankName: drift.Value(bankName),
      branchName: drift.Value(branchName),
      accountNumber: drift.Value(accountNumber),
      ifscCode: drift.Value(ifscCode),
    );

    try {
      Person person = await _db.into(_db.persons).insertReturning(validPerson);
      print(person);
      FlutterTts flutterTts = Get.find();
      flutterTts.setLanguage('kn-IN');
      await flutterTts.speak("ನಿಮ್ಮ ಕಾರ್ಡ್ ಅನ್ನು ಯಶಸ್ವಿಯಾಗಿ ನೋಂದಾಯಿಸಲಾಗಿದೆ");
      await flutterTts.awaitSpeakCompletion(true);
      EasyLoading.showSuccess("Person added successfully!");
      // Get.back(result: "some_result_from_add_screen");

      return person;

    } catch (e) {
      print("Error while adding person: $e");
      EasyLoading.showError("Failed to add person!");
    } finally {
      hideDialog(context);
    }
  }

  void hideDialog(BuildContext context) {
    if (context.mounted) {
      LoadingDialog.hide(context);
    }
  }
}
