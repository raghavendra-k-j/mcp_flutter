import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcp_app/database/data.dart';
import 'package:mcp_app/screens/view_card/controller.dart';
import 'package:mcp_app/util/health_issue_checker.dart';

import '../../values/colors.dart';

class ViewCardScreen extends StatelessWidget {
  final MCPCard mcpCard;

  ViewCardScreen({Key? key, required this.mcpCard}) : super(key: key) {
    ViewCardController viewCardController = Get.put(ViewCardController(mcpCard: mcpCard));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: onSurfaceColor,
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "Card Details",
          style:
              TextStyle(color: onSurfaceColor, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: ViewCardScreenBodyContent(),
    );
  }
}

class ViewCardScreenBodyContent extends StatelessWidget {
  final ViewCardController viewCardController = Get.find();

  ViewCardScreenBodyContent({super.key});

  List<Widget> tabItems = <Widget>[
    TabButton('Family'),
    TabButton('Birth'),
    TabButton('Pregnancy'),
    TabButton('Institution'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ViewCardScreenProfileInfo(),
        Obx(() => Container(
              alignment: Alignment.center,
              child: ToggleButtons(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                selectedBorderColor: primary,
                selectedColor: primary,
                fillColor: primary.shade50,
                color: onSurfaceColor,
                constraints: const BoxConstraints(
                  minHeight: 32.0,
                  minWidth: 40.0,
                ),
                isSelected: [
                  viewCardController.currentIndex.value == 0,
                  viewCardController.currentIndex.value == 1,
                  viewCardController.currentIndex.value == 2,
                  viewCardController.currentIndex.value == 3,
                ],
                onPressed: (index) {
                  viewCardController.changeTabIndex(index);
                },
                children: tabItems,
              ),
            )),
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Obx(() {
              return IndexedStack(
                index: viewCardController.currentIndex.value,
                children: [
                  Column(
                    children: [
                      ViewCardScreenWifeDetails(),
                      if(viewCardController.mcpCard.hemoglobin != null || viewCardController.mcpCard.sBp != null) ViewCardScreenHealthDetails(),
                      if(viewCardController.mcpCard.lmp != null || viewCardController.mcpCard.edd != null) ViewCardScreenObstetricDetails(),
                      if(viewCardController.mcpCard.bankName != null || viewCardController.mcpCard.accountNumber != null || viewCardController.mcpCard.ifscCode != null || viewCardController.mcpCard.branchName != null) ViewCardScreenBankDetails(),
                    ],
                  ),
                  const SizedBox(height: 200,child: Center(child: Text("Birth Details")),),
                  const SizedBox(height: 200,child: Center(child: Text("Pregnancy Details")),),
                  const SizedBox(height: 200,child: Center(child: Text("Institution Details")),),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

class TabButton extends StatelessWidget {
  String label;

  TabButton(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Text(label),
    );
  }
}

class ViewCardScreenProfileInfo extends StatelessWidget {
  final ViewCardController viewCardController = Get.find();

  ViewCardScreenProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mcpCard = viewCardController.mcpCard;
    return Container(
      decoration: const BoxDecoration(
        color: surfaceColor,
        border: Border(
          bottom: BorderSide(
            color: onSurfaceDividerLight,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.fromLTRB(12, 12, 16, 12),
              child: Image(
                image: AssetImage('assets/images/profile_placeholder.png'),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MCPC${mcpCard.id.toString().padLeft(4, '0')}",
                style: TextStyle(fontSize: 14, color: primary, fontWeight: FontWeight.bold),
              ),
              Text(
                mcpCard.motherName,
                style: const TextStyle(fontSize: 16, color: onSurfaceMediumColor, fontWeight: FontWeight.bold),
              ),
              Text(
                "${mcpCard.motherAge} Years",
                style:
                    const TextStyle(fontSize: 14, color: onSurfaceMediumColor),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class ViewCardScreenWifeDetails extends StatelessWidget {
  final ViewCardController viewCardController = Get.find();

  ViewCardScreenWifeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mcpCard = viewCardController.mcpCard;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: borderBetweenSurfaceAndBackground, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(label: "Basic Details"),
            DetailRowTextView(
              label: "Wife's Name",
              value: mcpCard.motherName,
            ),
            DetailRowTextView(
              label: "Wife's Age",
              value: "${mcpCard.motherAge} Years",
            ),
            if (mcpCard.mothersMobile != null) DetailRowTextView(
                label: "Wife's Mobile",
                value: mcpCard.mothersMobile!,
              ),
            if (mcpCard.fatherName != null)DetailRowTextView(
                label: "Husband's Name",
                value: mcpCard.fatherName!,
              ),
            if (mcpCard.fatherMobile != null) DetailRowTextView(
                label: "Husband's Mobile",
                value: mcpCard.fatherMobile!,
              ),
            if (mcpCard.address != null) DetailRowTextView(
                label: "Address",
                value: mcpCard.address!,
              ),
          ],
        ),
      ),
    );
  }
}

class ViewCardScreenHealthDetails extends StatelessWidget {
  final ViewCardController viewCardController = Get.find();

  ViewCardScreenHealthDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mcpCard = viewCardController.mcpCard;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: borderBetweenSurfaceAndBackground, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(label: "Health Details"),
            if (mcpCard.sBp != null)
              DetailRowTextView(
                label: "Blood Pressure",
                value: "${mcpCard.sBp}/${mcpCard.dBp} mmHg",
                badge: (HealthIssueChecker.hasBPIssue(mcpCard) ? '◉' : null),
              ),
            if (mcpCard.hemoglobin != null)
              DetailRowTextView(
                label: "Hemoglobin",
                value: "${mcpCard.hemoglobin} g/dL",
                badge: (HealthIssueChecker.hasHbLevelIssue(mcpCard.hemoglobin) ? '◉' : null),
              ),
            if (mcpCard.healthIssues.isNotEmpty)
              DetailRowTextView(
                label: "Health Issues",
                value: mcpCard.healthIssues.join(", "),
                // badge: (HealthIssueChecker.hasHealthIssuesList(mcpCard) ? '◉' : null),
              ),
          ],
        ),
      ),
    );
  }
}

class ViewCardScreenObstetricDetails extends StatelessWidget {
  final ViewCardController viewCardController = Get.find();

  ViewCardScreenObstetricDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mcpCard = viewCardController.mcpCard;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: borderBetweenSurfaceAndBackground, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(label: "Obstetric Details"),
            if (mcpCard.lmp != null)
              DetailRowTextView(
                label: "Last Menstrual Period (LMP)",
                value: "${mcpCard.lmp}",
              ),
            if (mcpCard.edd != null)
              DetailRowTextView(
                label: "Estimated date of delivery (EDD)",
                value: "${mcpCard.edd}",
              ),
          ],
        ),
      ),
    );
  }
}

class ViewCardScreenBankDetails extends StatelessWidget {
  final ViewCardController viewCardController = Get.find();

  ViewCardScreenBankDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mcpCard = viewCardController.mcpCard;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: borderBetweenSurfaceAndBackground, width: 0.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionHeader(label: "Bank Details"),
            if (mcpCard.bankName != null)
              DetailRowTextView(
                label: "Bank Name",
                value: "${mcpCard.bankName}",
              ),
            if (mcpCard.branchName != null)
              DetailRowTextView(
                label: "Branch",
                value: "${mcpCard.branchName}",
              ),
            if (mcpCard.accountNumber != null)
              DetailRowTextView(
                label: "Account Number",
                value: "${mcpCard.accountNumber}",
              ),
            if (mcpCard.ifscCode != null)
              DetailRowTextView(
                label: "IFSC Code",
                value: "${mcpCard.ifscCode}",
              ),
          ],
        ),
      ),
    );
  }
}

class DetailRowTextView extends StatelessWidget {
  final String label;
  final String value;
  final String? badge;

  const DetailRowTextView(
      {super.key, required this.label, required this.value, this.badge});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: onSurfaceDividerLight,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: onSurfaceColor, fontSize: 14),)),
          const Text(' : ', style: TextStyle(fontSize: 14),),
          Expanded(flex: 3, child: Text(value, style: const TextStyle(fontSize: 14),)),
          if(badge != null) Text(badge!, style: const TextStyle(fontSize: 14, color: Colors.red),),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String label;

  const SectionHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: onSurfaceDividerLight,
            width: 1.0,
          ),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: primary,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}