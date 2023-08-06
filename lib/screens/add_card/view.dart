import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mcp_app/database/data.dart';
import 'package:mcp_app/screens/add_card/controller.dart';
import 'package:mcp_app/screens/ocr/view.dart';
import 'package:mcp_app/widgets/voice_button.dart';

import '../../util/logger.dart';
import '../../values/colors.dart';
import '../../values/styles.dart';

class AddCard extends StatelessWidget {
  AddCard({super.key});

  final AddCardController addPersonController = Get.put(AddCardController());

  _onCardAdded(BuildContext buildContext) async {
    MCPCard? mcpCard = await addPersonController.addMCPCard(buildContext);
    logd("_onCardAdded: $mcpCard");
    if (mcpCard != null) {
      Get.back(
        result: mcpCard,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        iconTheme: const IconThemeData(color: onSurfaceColor),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          Obx(() => IconButton(
                color: !addPersonController.isLocaleEnglish.value
                    ? onSurfaceMediumColor
                    : Theme.of(context).primaryColor,
                onPressed: () {
                  addPersonController.isLocaleEnglish.toggle();
                  var kannadaLocale = const Locale('kn', 'IN');
                  var englishLocale = const Locale('en', 'IN');
                  if(addPersonController.isLocaleEnglish.value) {
                    Get.updateLocale(kannadaLocale);
                  }
                  else {
                    Get.updateLocale(englishLocale);
                  }
                },
                icon: const Icon(Icons.translate),
              )),
          IconButton(
            onPressed: () async {
              Map<String, String>? extractedData =
                  await Get.to(() => const AadhaarScanningScreen());
              if (extractedData != null && extractedData.isNotEmpty) {
                if (extractedData.containsKey("Name")) {
                  addPersonController.motherNameEditingController.text =
                      extractedData['Name']!;
                }
              }
            },
            icon: const Icon(
              Icons.document_scanner_outlined,
              color: onSurfaceMediumColor,
            ),
          ),
          IconButton(
            onPressed: () => _onCardAdded(context),
            icon: Icon(
              Icons.done,
              color: primary,
            ),
          ),
        ],
        title: Text(
          "new_registration".tr,
          style: const TextStyle(
            color: onSurfaceColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: AddScreenBodyContent(),
    );
  }
}

class AddScreenBodyContent extends StatelessWidget {
  AddScreenBodyContent({super.key});

  final AddCardController addPersonController = Get.put(AddCardController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        children: [
          Obx(() {
            if (addPersonController.errorMessage.value.isNotEmpty) {
              return Container(
                width: double.infinity,
                color: const Color.fromARGB(255, 255, 183, 0),
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        addPersonController.errorMessage.value,
                        style: const TextStyle(
                          color: surfaceColor,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: surfaceColor,
                      ),
                      onPressed: () {
                        addPersonController.errorMessage.value = '';
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
          const Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddPersonBasicInformation(),
                    AddPersonHealthDetails(),
                    AddPersonObstetric(),
                    AddPersonBankDetails(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddPersonBasicInformation extends StatelessWidget {
  const AddPersonBasicInformation({super.key});

  @override
  Widget build(BuildContext context) {
    AddCardController addPersonController = Get.find();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Container(
        decoration: FormStyles.formContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header - Basic Information
            Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                border: FormStyles.borderBottom,
              ),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: const Text(
                "Basic Information",
                style: TextStyle(
                  color: onSurfaceFormSectionLabel,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // Wife's Name
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Text(
                        "mother_name".tr,
                        style: Styles.textStyleFormLabel,
                      ),
                      const Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.name,
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      controller:
                          addPersonController.motherNameEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: Obx(() => VoiceInputButton(
                              onPressed: () {
                                addPersonController.toggleListening(
                                    addPersonController
                                        .motherNameEditingController);
                              },
                              isListening: addPersonController
                                  .isSpeechRecognitionActive(addPersonController
                                      .motherNameEditingController),
                            )),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Wife's Name",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Wife's Age
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Text(
                        "mother_age".tr,
                        style: Styles.textStyleFormLabel,
                      ),
                      const Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      controller:
                          addPersonController.motherAgeEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: Obx(() => VoiceInputButton(
                              onPressed: () {
                                addPersonController.toggleListening(
                                    addPersonController
                                        .motherAgeEditingController);
                              },
                              isListening: addPersonController
                                  .isSpeechRecognitionActive(addPersonController
                                      .motherAgeEditingController),
                            )),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Wife's Age",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Wife's Mobile
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "mother_mobile".tr,
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      controller: addPersonController
                          .motherMobileNumberEditingController,
                      textAlign: TextAlign.end,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        suffixIcon: Obx(() => VoiceInputButton(
                              onPressed: () {
                                addPersonController.toggleListening(
                                    addPersonController
                                        .motherMobileNumberEditingController);
                              },
                              isListening: addPersonController
                                  .isSpeechRecognitionActive(addPersonController
                                      .motherMobileNumberEditingController),
                            )),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Wife's Mobile",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Husband Name
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Text(
                        "father_name".tr,
                        style: Styles.textStyleFormLabel,
                      ),
                      Text(
                        "*",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      controller:
                          addPersonController.fatherNameEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: Obx(() => VoiceInputButton(
                              onPressed: () {
                                addPersonController.toggleListening(
                                    addPersonController
                                        .fatherNameEditingController);
                              },
                              isListening: addPersonController
                                  .isSpeechRecognitionActive(addPersonController
                                      .fatherNameEditingController),
                            )),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Husband's Name",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Husband Mobile
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "father_mobile".tr,
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      controller: addPersonController
                          .fatherMobileNumberEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: Obx(() => VoiceInputButton(
                              onPressed: () {
                                addPersonController.toggleListening(
                                    addPersonController
                                        .fatherMobileNumberEditingController);
                              },
                              isListening: addPersonController
                                  .isSpeechRecognitionActive(addPersonController
                                      .fatherMobileNumberEditingController),
                            )),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Husband's Mobile",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Address
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "address".tr,
                          style: Styles.textStyleFormLabel,
                        ),
                        Obx(() => VoiceInputButton(
                              onPressed: () {
                                addPersonController.toggleListening(
                                    addPersonController
                                        .addressEditingController);
                              },
                              isListening: addPersonController
                                  .isSpeechRecognitionActive(addPersonController
                                      .addressEditingController),
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Builder(
                      builder: (context) {
                        return TextFormField(
                          textCapitalization: TextCapitalization.sentences,
                          controller:
                              addPersonController.addressEditingController,
                          maxLines: 3,
                          minLines: 2,
                          maxLength: 300,
                          keyboardType: TextInputType.multiline,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          textAlign: TextAlign.start,
                          decoration: const InputDecoration(
                            hintStyle: Styles.textStyleHint,
                            hintText: "Enter Contact Address",
                            border: InputBorder.none,
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(300),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // MCTS/RCH ID
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 2),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "mctc_or_rch_id".tr,
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller:
                          addPersonController.mctsOrRchIdEditingController,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter MCTS/RCH ID",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPersonBankDetails extends StatelessWidget {
  const AddPersonBankDetails({super.key});

  @override
  Widget build(BuildContext context) {
    AddCardController addPersonController = Get.find();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Container(
        decoration: FormStyles.formContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header - Bank Information
            Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                border: FormStyles.borderBottom,
              ),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: const Text(
                "Bank Details",
                style: TextStyle(
                  color: onSurfaceFormSectionLabel,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // Bank Name
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "bank_name".tr,
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      controller: addPersonController.bankNameEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: Obx(() => VoiceInputButton(
                              onPressed: () {
                                addPersonController.toggleListening(
                                    addPersonController
                                        .bankNameEditingController);
                              },
                              isListening: addPersonController
                                  .isSpeechRecognitionActive(addPersonController
                                      .bankNameEditingController),
                            )),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Bank Name",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Branch Name
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "branch_name".tr,
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: [LengthLimitingTextInputFormatter(30)],
                      controller:
                          addPersonController.branchNameEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: Obx(() => VoiceInputButton(
                              onPressed: () {
                                addPersonController.toggleListening(
                                    addPersonController
                                        .branchNameEditingController);
                              },
                              isListening: addPersonController
                                  .isSpeechRecognitionActive(addPersonController
                                      .branchNameEditingController),
                            )),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Branch Name",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Account Number
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "account_number".tr,
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: const TextInputType.numberWithOptions(),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                      controller:
                          addPersonController.accountNumberEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: Obx(() => VoiceInputButton(
                              onPressed: () {
                                addPersonController.toggleListening(
                                    addPersonController
                                        .accountNumberEditingController);
                              },
                              isListening: addPersonController
                                  .isSpeechRecognitionActive(addPersonController
                                      .accountNumberEditingController),
                            )),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Account Number",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // IFSC Code
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "ifsc_code".tr,
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.characters,
                      controller: addPersonController.ifscCodeEditingController,
                      textAlign: TextAlign.end,
                      inputFormatters: [LengthLimitingTextInputFormatter(15)],
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter IFSC Code",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddPersonHealthDetails extends StatelessWidget {
  const AddPersonHealthDetails({super.key});

  @override
  Widget build(BuildContext context) {
    AddCardController addPersonController = Get.find();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Container(
        decoration: FormStyles.formContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header - Health Information
            Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                border: FormStyles.borderBottom,
              ),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: const Text(
                "Health Details",
                style: TextStyle(
                  color: onSurfaceFormSectionLabel,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // Hemoglobin
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 2),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "hemoglobin".tr,
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller:
                          addPersonController.hemoglobinEditingController,
                      textAlign: TextAlign.end,
                      inputFormatters: [LengthLimitingTextInputFormatter(4)],
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: false, decimal: true),
                      decoration: InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Hemoglobin Level",
                        border: InputBorder.none,
                        suffixIcon: Obx(() => VoiceInputButton(
                              onPressed: () {
                                addPersonController.toggleListening(
                                    addPersonController
                                        .hemoglobinEditingController);
                              },
                              isListening: addPersonController
                                  .isSpeechRecognitionActive(addPersonController
                                      .hemoglobinEditingController),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // BP
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 2),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "blood_pressure".tr,
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(7)],
                      controller: addPersonController.bpEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Blood Pressure",
                        border: InputBorder.none,
                        suffixIcon: Obx(() => VoiceInputButton(
                              onPressed: () {
                                addPersonController.toggleListening(
                                    addPersonController.bpEditingController);
                              },
                              isListening:
                                  addPersonController.isSpeechRecognitionActive(
                                      addPersonController.bpEditingController),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Health Issues
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Diabetes
                      Obx(
                        () => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: addPersonController.isDiabetesChecked.value,
                          onChanged: (newValue) {
                            addPersonController.isDiabetesChecked.value =
                                newValue!;
                          },
                          title: Text("diabetes".tr),
                        ),
                      ),

                      // Blood Pressure (BP)
                      Obx(
                        () => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: addPersonController.isBPChecked.value,
                          onChanged: (newValue) {
                            addPersonController.isBPChecked.value = newValue!;
                          },
                          title: Text("bp".tr),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Anemia
                      Obx(
                        () => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: addPersonController.isAnemiaChecked.value,
                          onChanged: (newValue) {
                            addPersonController.isAnemiaChecked.value =
                                newValue!;
                          },
                          title: Text("anemia".tr),
                        ),
                      ),

                      // Thyroid
                      Obx(
                        () => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: addPersonController.isThyroidChecked.value,
                          onChanged: (newValue) {
                            addPersonController.isThyroidChecked.value =
                                newValue!;
                          },
                          title: Text("thyroid".tr),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AddPersonObstetric extends StatelessWidget {
  const AddPersonObstetric({super.key});

  void openDatePicker(BuildContext context, TextEditingController controller) async {
    DateTime initialDate = DateTime.now();

    final String currentText = controller.text;
    if(currentText.isNotEmpty) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final DateTime currentDate = formatter.parseLoose(currentText);
      initialDate = currentDate;
    }

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formattedDate = formatter.format(pickedDate);
      if (formattedDate != controller.text) {
        controller.text = formattedDate;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AddCardController addPersonController = Get.find();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: Container(
        decoration: FormStyles.formContainerDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header - Obstetric History
            Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                border: FormStyles.borderBottom,
              ),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: const Text(
                "Obstetric History",
                style: TextStyle(
                  color: onSurfaceFormSectionLabel,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // Last Menstrual Period (LMP)
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 2),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "last_menstrual_period".tr,
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        openDatePicker(context, addPersonController.lmpEditingController);
                      },
                      controller: addPersonController.lmpEditingController,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Select LMP",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Estimated Due Date (EDD)
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 2),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "estimated_delivery_date".tr,
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        openDatePicker(context, addPersonController.eddEditingController);
                      },
                      controller: addPersonController.eddEditingController,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Select EDD",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
