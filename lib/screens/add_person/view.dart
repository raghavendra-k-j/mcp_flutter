import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mcp_app/database/data.dart';
import 'package:mcp_app/screens/add_person/controller.dart';

import '../../values/colors.dart';
import '../../values/styles.dart';

class AddCard extends StatelessWidget {
  AddCard({super.key});

  final AddPersonController addPersonController = Get.put(AddPersonController());


  Future<void> _onPersonAdded(BuildContext buildContext) async {
    Person? person = await addPersonController.addPerson(buildContext);
    if(person != null) {
      Get.back(result: person, );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: onSurfaceColor),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          Obx(() => IconButton(
            color: addPersonController.listenInEnglish.value ? Theme.of(context).primaryColor : surfaceColor,
            onPressed: () {
              addPersonController.listenInEnglish.toggle();
            },
            icon: const Icon(Icons.abc),
          )),
          IconButton(
              onPressed: () => _onPersonAdded(context),
              icon: const Icon(Icons.done)),
        ],
        title: const Text(
          "Add Card",
          style: TextStyle(color: onSurfaceColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: const AddScreenBodyContent(),
    );
  }
}

class AddScreenBodyContent extends StatelessWidget {
  const AddScreenBodyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
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
    );
  }
}

class AddPersonBasicInformation extends StatelessWidget {
  const AddPersonBasicInformation({super.key});

  @override
  Widget build(BuildContext context) {
    AddPersonController addPersonController = Get.find();
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
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // Mothers Name
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Mother's Name",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller:
                          addPersonController.motherNameEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          color: onSurfaceLightColor,
                          onPressed: () {
                            addPersonController.toggleListening(
                                addPersonController
                                    .motherNameEditingController);
                          },
                          icon: Obx(
                            () => Icon(
                              (addPersonController.isListening.value == true &&
                                      addPersonController
                                              .activeSpeechRecognitionController ==
                                          addPersonController
                                              .motherNameEditingController)
                                  ? Icons.mic
                                  : Icons.mic_none,
                            ),
                          ),
                        ),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Mother's Name",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Mothers Age
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Mother's Age",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller:
                          addPersonController.motherAgeEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          color: onSurfaceLightColor,
                          onPressed: () {
                            addPersonController.toggleListening(
                                addPersonController.motherAgeEditingController);
                          },
                          icon: Obx(
                            () => Icon(
                              (addPersonController.isListening.value == true &&
                                      addPersonController
                                              .activeSpeechRecognitionController ==
                                          addPersonController
                                              .motherAgeEditingController)
                                  ? Icons.mic
                                  : Icons.mic_none,
                            ),
                          ),
                        ),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Mother's Age",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Mothers Mobile
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Mother's Mobile",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: addPersonController
                          .motherMobileNumberEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          color: onSurfaceLightColor,
                          onPressed: () {
                            addPersonController.toggleListening(
                                addPersonController
                                    .motherMobileNumberEditingController);
                          },
                          icon: Obx(
                            () => Icon(
                              (addPersonController.isListening.value == true &&
                                      addPersonController
                                              .activeSpeechRecognitionController ==
                                          addPersonController
                                              .motherMobileNumberEditingController)
                                  ? Icons.mic
                                  : Icons.mic_none,
                            ),
                          ),
                        ),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Mother's Mobile",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Father Name
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Father's Name",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller:
                          addPersonController.fatherNameEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          color: onSurfaceLightColor,
                          onPressed: () {
                            addPersonController.toggleListening(
                                addPersonController
                                    .fatherNameEditingController);
                          },
                          icon: Obx(
                            () => Icon(
                              (addPersonController.isListening.value == true &&
                                      addPersonController
                                              .activeSpeechRecognitionController ==
                                          addPersonController
                                              .fatherNameEditingController)
                                  ? Icons.mic
                                  : Icons.mic_none,
                            ),
                          ),
                        ),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Father's Name",
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Father Mobile
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 0, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Father's Mobile",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: addPersonController
                          .fatherMobileNumberEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          color: onSurfaceLightColor,
                          onPressed: () {
                            addPersonController.toggleListening(
                                addPersonController
                                    .fatherMobileNumberEditingController);
                          },
                          icon: Obx(
                            () => Icon(
                              (addPersonController.isListening.value == true &&
                                      addPersonController
                                              .activeSpeechRecognitionController ==
                                          addPersonController
                                              .fatherMobileNumberEditingController)
                                  ? Icons.mic
                                  : Icons.mic_none,
                            ),
                          ),
                        ),
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Father's Mobile",
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
                        const Text(
                          "Address",
                          style: Styles.textStyleFormLabel,
                        ),
                        IconButton(
                          color: onSurfaceLightColor,
                          onPressed: () {
                            addPersonController.toggleListening(
                                addPersonController.addressEditingController);
                          },
                          icon: Obx(
                            () => Icon(
                              (addPersonController.isListening.value == true &&
                                      addPersonController
                                              .activeSpeechRecognitionController ==
                                          addPersonController
                                              .addressEditingController)
                                  ? Icons.mic
                                  : Icons.mic_none,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Builder(
                      builder: (context) {
                        return TextFormField(
                          controller:
                              addPersonController.addressEditingController,
                          maxLines: 3,
                          minLines: 3,
                          maxLength: 300,
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
                  const Text(
                    "MCTS/RCH ID",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
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
            // MCH ID
            Container(
              decoration: const BoxDecoration(border: FormStyles.borderBottom),
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 2),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "MCH ID",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller:
                      addPersonController.mchIdEditingController,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter MCH ID",
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
    AddPersonController addPersonController = Get.find();
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
                  color: Colors.black,
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
                  const Text(
                    "Bank Name",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: addPersonController.bankNameEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          color: onSurfaceLightColor,
                          onPressed: () {
                            addPersonController.toggleListening(
                                addPersonController.bankNameEditingController);
                          },
                          icon: Obx(
                            () => Icon(
                              (addPersonController.isListening.value == true &&
                                      addPersonController
                                              .activeSpeechRecognitionController ==
                                          addPersonController
                                              .bankNameEditingController)
                                  ? Icons.mic
                                  : Icons.mic_none,
                            ),
                          ),
                        ),
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
                  const Text(
                    "Branch Name",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller:
                          addPersonController.branchNameEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          color: onSurfaceLightColor,
                          onPressed: () {
                            addPersonController.toggleListening(
                                addPersonController
                                    .branchNameEditingController);
                          },
                          icon: Obx(
                            () => Icon(
                              (addPersonController.isListening.value == true &&
                                      addPersonController
                                              .activeSpeechRecognitionController ==
                                          addPersonController
                                              .branchNameEditingController)
                                  ? Icons.mic
                                  : Icons.mic_none,
                            ),
                          ),
                        ),
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
                  const Text(
                    "Account Number",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller:
                          addPersonController.accountNumberEditingController,
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          color: onSurfaceLightColor,
                          onPressed: () {
                            addPersonController.toggleListening(
                                addPersonController
                                    .accountNumberEditingController);
                          },
                          icon: Obx(
                            () => Icon(
                              (addPersonController.isListening.value == true &&
                                      addPersonController
                                              .activeSpeechRecognitionController ==
                                          addPersonController
                                              .accountNumberEditingController)
                                  ? Icons.mic
                                  : Icons.mic_none,
                            ),
                          ),
                        ),
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
                  const Text(
                    "IFSC Code",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: addPersonController.ifscCodeEditingController,
                      textAlign: TextAlign.end,
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
    AddPersonController addPersonController = Get.find();
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
                  color: Colors.black,
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
                  const Text(
                    "Hemoglobin",
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
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Hemoglobin Level",
                        border: InputBorder.none,
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
                            addPersonController.isDiabetesChecked.value = newValue!;
                          },
                          title: const Text("Diabetes"),
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
                          title: const Text("BP"),
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
                            addPersonController.isAnemiaChecked.value = newValue!;
                          },
                          title: const Text("Anemia"),
                        ),
                      ),

                      // Thyroid
                      Obx(
                            () => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: addPersonController.isThyroidChecked.value,
                          onChanged: (newValue) {
                            addPersonController.isThyroidChecked.value = newValue!;
                          },
                          title: const Text("Thyroid"),
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

  @override
  Widget build(BuildContext context) {
    AddPersonController addPersonController = Get.find();
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
                  color: Colors.black,
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
                  const Text(
                    "Last Menstrual Period (LMP)",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: addPersonController.lmpEditingController,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter LMP",
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
                  const Text(
                    "Estimated Delivery Date (EDD)",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: addPersonController.eddEditingController,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter EDD",
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