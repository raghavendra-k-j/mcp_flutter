import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mcp_app/database/data.dart';
import 'package:mcp_app/screens/basic_details/birth.dart';
import 'package:mcp_app/screens/basic_details/family.dart';
import 'package:mcp_app/screens/basic_details/institution.dart';
import 'package:mcp_app/screens/basic_details/pregnancy.dart';
import 'package:mcp_app/screens/card_details/controller.dart';
import 'package:mcp_app/values/colors.dart';

class CardDetailsScreen extends StatelessWidget {

  final MCPCard person;

  CardDetailsScreen({super.key, required this.person}) {
    Get.put(CardDetailsController(person));
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
          style: TextStyle(color: onSurfaceColor, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
      ),
      body: const CardDetailsContentBody(),
    );
  }
}

class CardDetailsContentBody extends StatelessWidget {
  const CardDetailsContentBody({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.maxFinite,
      child: const SingleChildScrollView(
          child: Column(
        children: [
          CardHeader(),
          BasicInfo(),
          CheckupForMother(),
          CheckupForChild()
        ],
      )),
    );
  }
}

class CardHeader extends StatelessWidget {
  const CardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final CardDetailsController cardDetailsController = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: surfaceColor
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              'assets/images/profile_placeholder.png',
              width: 80,
              height: 80,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              'CardID: MCPC${cardDetailsController.person.id.toString().padLeft(4, '0')}',
                style: TextStyle(
                    color: primary, fontWeight: FontWeight.bold),
              ),
              Text(
              'Name: ${cardDetailsController.person.motherName}',
                style: const TextStyle(
                    color: onSurfaceMediumColor, fontWeight: FontWeight.bold),
              ),
              Text("Created Date: ${DateFormat('MMM dd, yyyy').format(DateTime.now())}"),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  children: [
                    FilledButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all<Size>(const Size(30, 30)),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)))),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.redAccent)),
                        onPressed: () => {},
                        child: const Text("Pregnancy High Risk")),
                    Container(
                      margin: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: FilledButton(
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all<Size>(const Size(30, 30)),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4)))),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blueAccent)),
                          onPressed: () => {},
                          child: const Text("Email")),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(8),
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 234, 234, 234)),
        child: Center(
          child: Text(title,
              style: const TextStyle(
                  color: onSurfaceColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ));
  }
}

class BasicInfo extends StatelessWidget {
  const BasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Basic Details"),
        Container(
          padding: const EdgeInsets.all(2),
          child: Column(
            children: [
              Row(
                children: [
                  BasicInfoItem(
                    title: 'Family',
                    image: 'family',
                    onTap: () => Get.to(() => const FamilyApp()),
                  ),
                  BasicInfoItem(
                    title: 'Pregnancy',
                    image: 'pregnancy',
                    onTap: () => Get.to(() => const PregnancyApp()),
                  ),
                ],
              ),
              Row(
                children: [
                  BasicInfoItem(
                    title: 'Birth',
                    image: 'birth',
                    onTap: () => Get.to(() => const BirthApp()),
                  ),
                  BasicInfoItem(
                    title: 'Institution',
                    image: 'institution',
                    onTap: () => Get.to(() => const InstitutionApp()),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}

class BasicInfoItem extends StatelessWidget {
  const BasicInfoItem(
      {super.key,
      required this.onTap,
      required this.title,
      required this.image});

  final String title, image;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: onSurfaceDividerMedium, width: 0.5),
            color: Colors.white.withOpacity(0.5),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(
                "assets/images/$image.png",
                width: 40,
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Text(
                  title,
                  style: const TextStyle(color: onSurfaceColor, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class CheckupForMother extends StatelessWidget {
  const CheckupForMother({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SectionTitle(title: "Healthcare Check for Mother"),
        CheckForMotherItem(title: "Regular Checkup", image: "hospital"),
        CheckForMotherItem(title: "Antenatal Care", image: "pregnant"),
        CheckForMotherItem(title: "Post Natal Care", image: "post_natal"),
      ],
    );
  }
}

class CheckForMotherItem extends StatelessWidget {
  const CheckForMotherItem({
    super.key,
    required this.title,
    required this.image,
  });

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: onSurfaceDividerMedium, width: 0.5
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/images/$image.png",
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(width: 8),
                  Text(title),
                  const Spacer(),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text("Update"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckupForChild extends StatelessWidget {
  const CheckupForChild({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: "Healthcare Check for Baby"),
        Container(
          width: double.infinity,
          decoration:
              const BoxDecoration(color: Color.fromARGB(255, 218, 241, 255)),
          padding: const EdgeInsets.all(8),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Color.fromARGB(255, 0, 127, 178),
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(text: 'Birth to 6 months: '),
                TextSpan(
                  text: 'early and exclusive breast feeding',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
