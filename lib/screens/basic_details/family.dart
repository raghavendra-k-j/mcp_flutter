import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../values/styles.dart';


class FamilyApp extends StatelessWidget {
  const FamilyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: FamilyAppContent(),
    );
  }
}

class FamilyAppContent extends StatelessWidget {
  const FamilyAppContent({super.key});

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
          "Family Identification",
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
      body: const FamilyAppBody(),
    );
  }
}

class FamilyAppBody extends StatelessWidget {
  const FamilyAppBody({super.key});

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
                BasicInformation(),
                BankDetails(),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

class BankDetails extends StatelessWidget {
  const BankDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFE1E1E1),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8)),
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
                "Bank Details",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              decoration: Styles.borderBottom,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Bank Name", style: Styles.textStyleFormLabel,),
                  const SizedBox(width: 2,),
                  Expanded(child: TextFormField(initialValue: "", textAlign: TextAlign.end, decoration: const InputDecoration(hintStyle: Styles.textStyleHint, hintText: "Enter Bank Name", border: InputBorder.none),))
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Branch Name", style: Styles.textStyleFormLabel,),
                  const SizedBox(width: 2,),
                  Expanded(child: TextFormField(initialValue: "", textAlign: TextAlign.end, decoration: const InputDecoration(hintStyle: Styles.textStyleHint, hintText: "Enter Branch Name", border: InputBorder.none),))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Account Number", style: Styles.textStyleFormLabel,),
                  const SizedBox(width: 2,),
                  Expanded(child: TextFormField(initialValue: "", textAlign: TextAlign.end, decoration: const InputDecoration(hintStyle: Styles.textStyleHint, hintText: "Enter Account Number", border: InputBorder.none),))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("IFSC Code", style: Styles.textStyleFormLabel,),
                  const SizedBox(width: 2,),
                  Expanded(child: TextFormField(initialValue: "", textAlign: TextAlign.end, decoration: const InputDecoration(hintStyle: Styles.textStyleHint, hintText: "Enter IFSC Code", border: InputBorder.none),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class BasicInformation extends StatelessWidget {
  const BasicInformation({super.key});

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
            borderRadius: BorderRadius.circular(8)),
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
                "Basic Information",
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
                  const Text("Mother's Name", style: Styles.textStyleFormLabel,),
                  const SizedBox(width: 2,),
                  Expanded(child: TextFormField(initialValue: "", textAlign: TextAlign.end, decoration: const InputDecoration(hintStyle: Styles.textStyleHint, hintText: "Enter Mother Name", border: InputBorder.none),))
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Mother's Age", style: Styles.textStyleFormLabel,),
                  const SizedBox(width: 2,),
                  Expanded(child: TextFormField(initialValue: "", textAlign: TextAlign.end, decoration: const InputDecoration(hintStyle: Styles.textStyleHint, hintText: "Enter Age", border: InputBorder.none),))
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Mother's Mobile", style: Styles.textStyleFormLabel,),
                  const SizedBox(width: 2,),
                  Expanded(child: TextFormField(initialValue: "", textAlign: TextAlign.end, decoration: const InputDecoration(hintStyle: Styles.textStyleHint, hintText: "Enter Mother's Mobile Number", border: InputBorder.none),))
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Father's Name", style: Styles.textStyleFormLabel,),
                  const SizedBox(width: 2,),
                  Expanded(child: TextFormField(initialValue: "", textAlign: TextAlign.end, decoration: const InputDecoration(hintStyle: Styles.textStyleHint, hintText: "Enter Father Name", border: InputBorder.none),))
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Father's Mobile", style: Styles.textStyleFormLabel,),
                  const SizedBox(width: 2,),
                  Expanded(child: TextFormField(initialValue: "", textAlign: TextAlign.end, decoration: const InputDecoration(hintStyle: Styles.textStyleHint, hintText: "Enter Father's Mobile Number", border: InputBorder.none),))
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Address", style: Styles.textStyleFormLabel),
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
                          hintText: "Enter Your Contact Address",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {

                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(300),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("MCTS/RCH ID", style: Styles.textStyleFormLabel,),
                  const SizedBox(width: 2,),
                  Expanded(child: TextFormField(initialValue: "", textAlign: TextAlign.end, decoration: const InputDecoration(hintStyle: Styles.textStyleHint, hintText: "Enter MCTS/RCH ID", border: InputBorder.none),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
