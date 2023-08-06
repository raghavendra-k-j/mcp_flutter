// ignore_for_file: avoid_print, use_build_context_synchronously


import 'package:drift/drift.dart' as drift;
import 'package:faker/faker.dart' as f;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:mcp_app/database/data.dart';
import 'package:mcp_app/database/repo/mcp_card_repo.dart';
import 'package:mcp_app/util/exceptions.dart';
import 'package:mcp_app/util/logger.dart';
import 'package:mcp_app/widgets/loading.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AddCardController extends GetxController {

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
  var bpEditingController = TextEditingController();

  var isListening = false.obs;
  var speechToText = SpeechToText();
  var listenInEnglish = true.obs;
  var isLocaleEnglish = true.obs;

  late TextEditingController activeSpeechRecognitionController;

  var isDiabetesChecked = false.obs;
  var isBPChecked = false.obs;
  var isAnemiaChecked = false.obs;
  var isThyroidChecked = false.obs;

  var errorMessage = ''.obs;

  bool isSpeechRecognitionActive(TextEditingController textEditingController) {
    return isListening.value &&
        activeSpeechRecognitionController == textEditingController;
  }

  AddCardController();

  late MyDatabase _db;
  late f.Faker _faker;

  @override
  Future<void> onInit() async {
    super.onInit();
    _db = Get.find();
    _faker = Get.find();

    setMaxIdPlusOne().then((value) => {
          mctsOrRchIdEditingController.text =
              "MCPC${value.toString().padLeft(4, '0')}"
        });

    void nameEditingListener(TextEditingController textEditingController) {
      String text = textEditingController.text;
      String filteredText = text.replaceAll(RegExp(r'[^a-zA-Z ]+'), ' ');

      if (text != filteredText) {
        textEditingController.value = TextEditingValue(
          text: filteredText,
          selection: TextSelection.fromPosition(TextPosition(offset: filteredText.length)),
        );
      }
    }


    void ageEditingController(TextEditingController textEditingController) {
      String text = textEditingController.text;
      String filteredText = text.replaceAll(RegExp(r'[^\d]+'), '');

      if (filteredText.length > 2) {
        filteredText = filteredText.substring(0, 2);
      }

      if (text != filteredText) {
        textEditingController.value = TextEditingValue(
          text: filteredText,
          selection: TextSelection.fromPosition(TextPosition(offset: filteredText.length)),
        );
      }
    }



    void mobileNumberEditingController(TextEditingController textEditingController) {
      String text = textEditingController.text;
      String filteredText = text.replaceAll(RegExp(r'[^\d]+'), '');

      if (text != filteredText) {
        textEditingController.value = TextEditingValue(
          text: filteredText,
          selection: TextSelection.fromPosition(TextPosition(offset: filteredText.length)),
        );
      }
    }

    motherNameEditingController.addListener(() => nameEditingListener(motherNameEditingController));

    motherAgeEditingController.addListener(() => ageEditingController(motherAgeEditingController));

    motherMobileNumberEditingController.addListener(() => mobileNumberEditingController(motherMobileNumberEditingController));

    fatherNameEditingController.addListener(() => nameEditingListener(fatherNameEditingController));

    fatherMobileNumberEditingController.addListener(() => mobileNumberEditingController(fatherMobileNumberEditingController));

    addressEditingController.addListener(() {
      String text = addressEditingController.text;
      String filteredText = text.replaceAll(RegExp(r'[^\x00-\x7Fa-zA-Z0-9,#.\- ]+'), '');

      if (text != filteredText) {
        addressEditingController.value = TextEditingValue(
          text: filteredText,
          selection: TextSelection.fromPosition(TextPosition(offset: filteredText.length)),
        );
      }
    });

    hemoglobinEditingController.addListener(() {
      String newText = hemoglobinEditingController.text.replaceAll(RegExp(r'[^\d.]'), '');

      int dotCount = newText.split('.').length - 1;
      if (dotCount > 1) {
        newText = newText.replaceAll('.', '');
      }

      if (hemoglobinEditingController.text != newText) {
        hemoglobinEditingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.fromPosition(
            TextPosition(offset: newText.length),
          ),
        );
      }
    });

    bpEditingController.addListener(() {
      logd(bpEditingController.text);
      String newText = bpEditingController.text
          .replaceAll('bar', '/')
          .replaceAll('slash', '/')
          .replaceAll(RegExp(r'[^\d/]'), '');

      if (bpEditingController.text != newText) {
        bpEditingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.fromPosition(TextPosition(offset: newText.length)),
        );
      }
    });

    lmpEditingController.addListener(() {
      String newText = lmpEditingController.text.replaceAll(RegExp(r'[^\d/ -]'), '');
      if (lmpEditingController.text != newText) {
        lmpEditingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.fromPosition(
            TextPosition(offset: newText.length),
          ),
        );
      }
    });

    eddEditingController.addListener(() {
      String newText = eddEditingController.text.replaceAll(RegExp(r'[^\d/ -]'), '');
      if (eddEditingController.text != newText) {
        eddEditingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.fromPosition(
            TextPosition(offset: newText.length),
          ),
        );
      }
    });

    bankNameEditingController.addListener(() {
      nameEditingListener(bankNameEditingController);
    });

    branchNameEditingController.addListener(() {
      String newText = branchNameEditingController.text.replaceAll(RegExp(r'[^\w\s,.&()/-]'), '');
      if (branchNameEditingController.text != newText) {
        branchNameEditingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.fromPosition(
            TextPosition(offset: newText.length),
          ),
        );
      }
    });

    accountNumberEditingController.addListener(() {
      String newText = accountNumberEditingController.text.replaceAll(RegExp(r'[^\d-]'), '');
      if (accountNumberEditingController.text != newText) {
        accountNumberEditingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.fromPosition(
            TextPosition(offset: newText.length),
          ),
        );
      }
    });

    ifscCodeEditingController.addListener(() {
      String newText = ifscCodeEditingController.text.replaceAll(RegExp(r'[^\w\d]'), '').toUpperCase();

      if (ifscCodeEditingController.text != newText) {
        ifscCodeEditingController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.fromPosition(
            TextPosition(offset: newText.length),
          ),
        );
      }
    });


    // motherNameEditingController.text = _faker.person.firstName();
    // motherAgeEditingController.text = _faker.randomGenerator.integer(50, min: 20).toString();
    //
    // fatherNameEditingController.text = _faker.person.firstName();

  }

  Future<int> setMaxIdPlusOne() async {
    var maxIdExp = _db.mCPCards.id.max();
    final maxIdQuery = _db.selectOnly(_db.mCPCards)..addColumns([maxIdExp]);
    int? maxId =
        (await maxIdQuery.map((row) => row.read(maxIdExp)).getSingle());
    maxId ??= 0;
    return maxId + 1;
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

  Future<MCPCard?> addMCPCard(BuildContext context) async {
    MCPCardRepo mcpCardRepo = MCPCardRepo(_db);

    LoadingDialog.loading(context, text: "Just a Second");

    String motherName = motherNameEditingController.text.trim();
    if(motherName.isEmpty) {
      return await showError(context, "Please Enter Wife's Name");
    }
    dynamic mothersAge = motherAgeEditingController.text.trim();
    mothersAge = int.tryParse(mothersAge);
    if (mothersAge == null) {
      return await showError(context, "Please Enter Wife's Age");
    }
    String mothersMobile = motherMobileNumberEditingController.text.trim();
    String fatherName = fatherNameEditingController.text.trim();
    String fatherMobile = fatherMobileNumberEditingController.text.trim();
    String address = addressEditingController.text.trim();

    List<String> heathIssues = [];
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

    dynamic lmp = lmpEditingController.text.trim();
    if (lmp.isNotEmpty) {
      lmp = DateTime.tryParse(lmp);
      if (lmp == null) {
        return await showError(context, "Please Enter Valid LMP");
      }
    } else {
      lmp = null;
    }

    dynamic edd = eddEditingController.text.trim();
    if (edd.isNotEmpty) {
      edd = DateTime.tryParse(edd);
      if (edd == null) {
        return await showError(context, "Please Enter Valid EDD");
      }
    } else {
      edd = null;
    }

    dynamic hemoglobin = hemoglobinEditingController.text.trim();
    if (hemoglobin.isNotEmpty) {
      hemoglobin = double.tryParse(hemoglobin);
      if (hemoglobin == null) {
        return await showError(context, "Please Enter Valid Hemoglobin level");
      }
    } else {
      hemoglobin = null;
    }

    String bp = bpEditingController.text.trim();
    List<int>? bpValues;
    if (bp.isNotEmpty) {
      RegExp pattern = RegExp(r'^\d+/\d+$');
      if (pattern.hasMatch(bp)) {
        bpValues = bp.split('/').map(int.parse).toList();
      } else {
        return await showError(context, "Please Enter Valid Blood Pressure");
      }
    } else {
      bpValues = null;
    }

    try {
      MCPCard mcpCard = await mcpCardRepo.addMCPCard(
          motherName: motherName,
          motherAge: mothersAge,
          mothersMobile: mothersMobile,
          fatherName: fatherName,
          fatherMobile: fatherMobile,
          address: address,
          lmp: lmp,
          edd: edd,
          healthIssues: heathIssues,
          hemoglobin: hemoglobin,
          sBp: (bpValues != null ? bpValues[0] : null),
          dBp: (bpValues != null ? bpValues[1] : null),
          bankName: bankName,
          branchName: branchName,
          accountNumber: accountNumber,
          ifscCode: ifscCode);
      FlutterTts flutterTts = Get.find();
      flutterTts.setLanguage('kn-IN');
      await flutterTts.speak("ನಿಮ್ಮ ಕಾರ್ಡ್ ಅನ್ನು ಯಶಸ್ವಿಯಾಗಿ ನೋಂದಾಯಿಸಲಾಗಿದೆ");
      await flutterTts.awaitSpeakCompletion(true);
      await LoadingDialog.show(context, title: "Registered Successfully", duration: 1000, dialogType: DialogType.success);
      return mcpCard;
    } on FormException catch (e) {
      return await showError(context, "$e");
    }
  }

  showError(BuildContext context, String message) async {
    LoadingDialog.hide();
    errorMessage.value = message;
    return null;
  }
}



