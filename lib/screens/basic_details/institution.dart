import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../values/styles.dart';


class InstitutionApp extends StatelessWidget {
  const InstitutionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: InstitutionAppContent(),
    );
  }
}

class InstitutionAppContent extends StatelessWidget {
  const InstitutionAppContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.surface,
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColors.onSurface),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.onSurface,
          ),
        ),
        title: const Text(
          "Institution Details",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
              fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.check, color: AppColors.onSurface,),
            ),
          ),
        ],
      ),
      body: const InstitutionAppBody(),
    );
  }
}

class InstitutionAppBody extends StatelessWidget {
  const InstitutionAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.maxFinite,
      child:  const Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    GeneralDetails(),
                    AWCDetails(),
                    SubCenterDetails(),
                    ReferredToDetails(),
                    AdditionalDetails(),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class GeneralDetails extends StatelessWidget {
  const GeneralDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE1E1E1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("AWW No", style: Styles.textStyleFormLabel),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter AWW No",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Block/Village/Ward", style: Styles.textStyleFormLabel),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Block/Village/Ward",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("ASHA", style: Styles.textStyleFormLabel),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter ASHA",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("ANM", style: Styles.textStyleFormLabel),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter ANM",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("SHC/Clinic", style: Styles.textStyleFormLabel),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter SHC/Clinic",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("PHC/Town", style: Styles.textStyleFormLabel),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter PHC/Town",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Hospital/FRU", style: Styles.textStyleFormLabel),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Hospital/FRU",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("ANM Contact Number", style: Styles.textStyleFormLabel),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter ANM Contact Number",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Hospital Contact Number", style: Styles.textStyleFormLabel),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Hospital Phone No",
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

class AWCDetails extends StatelessWidget {
  const AWCDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE1E1E1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFf1f1f1),
                    width: .9,
                  ),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: const Text(
                "AWC",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Reg. No", style: Styles.textStyleFormLabel),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Registration Number",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Reg. Date", style: Styles.textStyleFormLabel),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Registration Date",
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

class SubCenterDetails extends StatelessWidget {
  const SubCenterDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE1E1E1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFf1f1f1),
                    width: .9,
                  ),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: const Text(
                "Subcenter",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Reg. No",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Registration Number",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Reg. Date",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Registration Date",
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

class ReferredToDetails extends StatelessWidget {
  const ReferredToDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE1E1E1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: Styles.borderBottom,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Referred To", style: Styles.textStyleFormLabel),
              const SizedBox(width: 2),
              Builder(
                builder: (context) {
                  final controller = TextEditingController();
                  return TextField(
                    controller: controller,
                    maxLines: 3,
                    minLines: 3,
                    maxLength: 300,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      hintStyle: Styles.textStyleHint,
                      hintText: "Enter Referred To",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {},
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(300),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdditionalDetails extends StatelessWidget {
  const AdditionalDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE1E1E1),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Child Adhar Number",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Child Adhar Number",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Mother Aadhaar Number",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Mother Aadhaar Number",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Ambulance Toll Free Number",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: TextFormField(
                      initialValue: "",
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Toll Free Number",
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
