// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mcp_app/screens/add_card/view.dart';
import 'package:mcp_app/screens/home/controller.dart';
import 'package:mcp_app/screens/search_hints/view.dart';
import 'package:mcp_app/screens/view_card/view.dart';
import 'package:mcp_app/util/health_issue_checker.dart';
import 'package:mcp_app/values/colors.dart';
import 'package:mcp_app/values/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../database/data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    HomeCardListController homeCardListController =
        Get.put(HomeCardListController());
    MyDatabase myDatabase = Get.find();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: onSurfaceColor),
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "Welcome Ms.Kumari",
          style:
              TextStyle(color: onSurfaceColor, fontWeight: FontWeight.normal),
        ),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Get.to(() => DriftDbViewer(myDatabase));
          //   },
          //   icon: const Icon(
          //     Icons.table_view_outlined,
          //     color: surfaceColor,
          //   ),
          // ),
        ],
      ),
      // drawer: const AppDrawer(),
      body: const HomeScreenContentBody(),
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          MCPCard? result = await Get.to(() => AddCard());
          print(result?.motherName);
          if (result != null) {
            homeCardListController.addElement(result);
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          showUnselectedLabels: true,
          selectedItemColor: primary,
          unselectedItemColor: onSurfaceMediumColor,
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'MCPC',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Discovery',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Education',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  const Icon(Icons.calendar_month),
                  if (homeController.appointsBadgeCount.value > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 10,
                          minHeight: 10,
                        ),
                        child: Text(
                          homeController.appointsBadgeCount < 100
                              ? homeController.appointsBadgeCount.toString()
                              : '99+',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              label: 'Appointment',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
          currentIndex: homeController.selectedIndex.value,
          onTap: homeController.onItemTapped,
        ),
      ),
    );
  }
}

class HomeScreenContentBody extends StatelessWidget {
  const HomeScreenContentBody({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BannerCard(
            heading: 'Healthcare',
            subHeading: 'Anytime, Anywhere',
          ),
          HomeSearchWidget(),
          const HomeSearchHintsHelperText(),
          const HomeCardsList(),
        ],
      ),
    );
  }
}

class HomeSearchWidget extends StatelessWidget {
  final HomeCardListController homeCardListController = Get.find();
  final FocusNode _focusNode = FocusNode();

  HomeSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: const [
            BoxShadow(
              color: borderBetweenSurfaceAndBackground,
              offset: Offset(0, 1),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    homeController.showClearSearchButton.value = true;
                  } else {
                    homeController.showClearSearchButton.value = false;
                    homeCardListController.loadList();
                  }
                },
                onTapOutside: (_) {
                  _focusNode.unfocus();
                },
                onSubmitted: (query) {
                  homeCardListController.loadList(query: query);
                },
                controller: homeController.searchEditController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: onSurfaceExtraLightColor),
                  hintText: 'Search by Name, MCPC #',
                  prefixIcon: IconButton(
                    color: onSurfaceLightColor,
                    onPressed: () {
                      homeController.listenInEnglish.toggle();
                    },
                    icon: Obx(() => Icon(
                        (homeController.listenInEnglish.value == true)
                            ? Icons.search
                            : Icons.translate_outlined)),
                  ),
                ),
              ),
            ),
            Obx(() {
              if (homeController.showClearSearchButton.value) {
                return InkWell(
                  onTap: () {
                    homeController.searchEditController.text = '';
                    homeController.showClearSearchButton.value = false;
                    homeCardListController.loadList();
                  },
                  child: const Icon(
                    Icons.clear,
                    color: onSurfaceLightColor,
                  ),
                );
              } else {
                return Container();
              }
            }),
            Obx(() => IconButton(
                  color: homeController.isListening.value
                      ? onSurfaceMicListening
                      : onSurfaceMicNotListening,
                  onPressed: () {
                    homeController.toggleListening();
                  },
                  icon: Icon(homeController.isListening.value
                      ? Icons.mic
                      : Icons.mic_none),
                )),
            InkWell(
              onTap: () {
                homeCardListController.loadList(
                    query: homeController.searchEditController.text);
              },
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                  color: primary,
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeSearchHintsHelperText extends StatelessWidget {
  const HomeSearchHintsHelperText({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    HomeCardListController homeCardListController = Get.find();
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        children: [
          Expanded(
              child: Row(
            children: [
              const Text(
                "Ex: ",
                style: TextStyle(
                    fontSize: 14,
                    color: onSurfaceLightColor,
                    fontStyle: FontStyle.italic),
              ),
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: controller.hints.map((hint) {
                  return TyperAnimatedText(
                    hint,
                    textStyle: const TextStyle(
                        fontSize: 14,
                        color: onSurfaceLightColor,
                        fontStyle: FontStyle.italic),
                    speed: const Duration(milliseconds: 150),
                  );
                }).toList(),
              ),
            ],
          )),
          GestureDetector(
            onTap: () async {
              String? selectedHint = await Get.to(() => SearchHintsScreen());
              if (selectedHint != null) {
                controller.showClearSearchButton.value = true;
                controller.searchEditController.text = selectedHint;
                HomeCardListController cardListController = Get.find();
                cardListController.loadList(
                    query: controller.searchEditController.text);
              }
            },
            child: Text(
              "More Hints",
              style: TextStyle(
                color: primary,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () async {
              List<String> options = [
                'Newest Registrations First',
                'Oldest Registrations First'
              ];

              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Sort By'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: options.map((option) {
                          return ListTile(
                            title: Text(option),
                            onTap: () {
                              homeCardListController.loadList(
                                  query: controller.searchEditController.text,
                                  sortBy: option);
                              Navigator.of(context).pop();
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              );
            },
            child: Text(
              "Sort",
              style: TextStyle(
                color: primary,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HomeCardsList extends StatelessWidget {
  const HomeCardsList({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCardListController homeCardListController = Get.find();
    return Expanded(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(homeCardListController.items.isNotEmpty) Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: homeCardListController.items.length,
                itemBuilder: (context, index) {
                  MCPCard mcpCard = homeCardListController.items[index];
                  return HomeScreenPersonItem(
                    mcpCard: mcpCard,
                  );
                },
              ),
            ),
            if(homeCardListController.items.isEmpty) const Expanded(child: Center(child: Text("No Records Found", style: TextStyle(color: onBackgroundMediumColor),))),
              Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: borderBetweenSurfaceAndBackground))),
              padding: const EdgeInsets.all(8.0),
              child: Text(
                ((homeCardListController.totalItemsInDb.value == 0 ||
                        homeCardListController.totalItemsInDb.value ==
                            homeCardListController.items.length)
                    ? ("Total Records: ${homeCardListController.items.length}")
                    : ("Showing ${homeCardListController.items.length} records out of ${homeCardListController.totalItemsInDb.value}")),
                textAlign: TextAlign.start,
                style: const TextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreenPersonItem extends StatelessWidget {
  final MCPCard mcpCard;

  const HomeScreenPersonItem({super.key, required this.mcpCard});

  int _getProgress(MCPCard mcpCard) {
    final random = Random();
    var progress = (mcpCard.hemoglobin != null && mcpCard.hemoglobin! < 7)
        ? 60
        : (20 + random.nextDouble() * 30);
    return progress.toInt();
  }

  Widget buildProgressIndicator() {
    double progress = (_getProgress(mcpCard) * 0.01);
    if (progress > 0.5) {
      return LinearProgressIndicator(
        minHeight: 8,
        value: progress,
        backgroundColor: Colors.grey[200],
        valueColor: const AlwaysStoppedAnimation<Color>(
            Color.fromARGB(255, 255, 166, 166)),
      );
    } else {
      return LinearProgressIndicator(
        minHeight: 8,
        value: progress,
        backgroundColor: Colors.grey[200],
        valueColor: const AlwaysStoppedAnimation<Color>(
            Color.fromARGB(255, 137, 213, 255)),
      );
    }
  }

  _openWhatsapp(String phoneNumber) async {
    var contact = "+91$phoneNumber";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      EasyLoading.showError('WhatsApp is not installed.');
    }
  }

  void _callPhoneNumber(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print('Could not launch phone call for number: $phoneNumber');
    }
  }

  void _showComplicationDialog(BuildContext context, MCPCard mcpCard) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            "Complication",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Table(
            defaultColumnWidth: const IntrinsicColumnWidth(),
            border: TableBorder.all(color: onSurfaceDividerDark, width: 0.5, borderRadius: BorderRadius.circular(8)),
            children: [
              if(HealthIssueChecker.hasHealthIssuesList(mcpCard)) TableRow(
                children: [
                  if (mcpCard.healthIssues.isNotEmpty)
                    const TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0), // Add padding here
                        child: Text(
                          "Health Issues",
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  if (mcpCard.healthIssues.isNotEmpty)
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), // Add padding here
                        child: Text(
                          mcpCard.healthIssues.join(", "),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                ],
              ),
              if (HealthIssueChecker.hasHbLevelIssue(mcpCard.hemoglobin)) TableRow(
                  children: [
                    const TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0), // Add padding here
                        child: Text(
                          "Hemoglobin",
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), // Add padding here
                        child: Text(
                          "${mcpCard.hemoglobin} g/dL",
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
              if (HealthIssueChecker.hasBPIssue(mcpCard)) TableRow(
                  children: [
                    const TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0), // Add padding here
                        child: Text(
                          "BP",
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0), // Add padding here
                        child: Text(
                          "${mcpCard.sBp}/${mcpCard.dBp} mmHg",
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          )
          ,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(4.0),
          border: const Border(
            top: BorderSide(
              color: borderBetweenSurfaceAndBackground,
              width: 0.5,
            ),
            left: BorderSide(
              color: borderBetweenSurfaceAndBackground,
              width: 0.5,
            ),
            right: BorderSide(
              color: borderBetweenSurfaceAndBackground,
              width: 0.5,
            ),
            bottom: BorderSide(
              color: borderBetweenSurfaceAndBackground,
              width: 0.5,
            ),
          ),
        ),
        child: InkWell(
          onTap: () {
            Get.to(() => ViewCardScreen(
                  mcpCard: mcpCard,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[200],
                          ),
                          child: const SizedBox(
                            width: 80,
                            height: 80,
                          ),
                        ),
                        if (HealthIssueChecker.hasComplications(mcpCard)) Positioned(
                            bottom: 5,
                            right: 5,
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: InkWell(
                                onTap: () {
                                  _showComplicationDialog(context, mcpCard);
                                },
                                child: const Icon(
                                  Icons.error,
                                  color: Color.fromARGB(255, 255, 89, 0),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Card ID: MCPC${mcpCard.id.toString().padLeft(4, '0')}',
                            style: TextStyle(
                                color: primary, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Name: ${mcpCard.motherName}',
                            style: const TextStyle(
                                color: onSurfaceMediumColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Age: ${mcpCard.motherAge} Years',
                            style: const TextStyle(color: onSurfaceMediumColor),
                          ),
                          Text(
                            '${mcpCard.hemoglobin != null ? 'Hb: ${mcpCard.hemoglobin}' : ''}${mcpCard.sBp != null && mcpCard.hemoglobin != null ? ', ': ''}${mcpCard.sBp == null ? '' : "BP: ${mcpCard.sBp}/${mcpCard.dBp}"}',
                            style: const TextStyle(color: onSurfaceMediumColor),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        // IconButton(
                        //     constraints: const BoxConstraints(
                        //       minWidth: 20.0,
                        //       minHeight: 20.0,
                        //     ),
                        //     onPressed: () {
                        //       // Get.to(() => CardDetailsScreen(mcpCard: mcpCard));
                        //       Get.to(() => ViewCardScreen(mcpCard: mcpCard));
                        //     },
                        //     icon: SvgPicture.asset(
                        //         "assets/images/edit_outlined.svg",
                        //         width: 20,
                        //         height: 20,
                        //         colorFilter: const ColorFilter.mode(Colors.deepPurple, BlendMode.srcIn))),
                        if (mcpCard.mothersMobile != null)
                          IconButton(
                              constraints: const BoxConstraints(
                                minWidth: 15.0,
                                minHeight: 15.0,
                              ),
                              onPressed: () {
                                _callPhoneNumber(mcpCard.mothersMobile!);
                              },
                              icon: SvgPicture.asset(
                                  "assets/images/call_outlined.svg",
                                  width: 20,
                                  height: 20,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.blue, BlendMode.srcIn))),
                        if (mcpCard.mothersMobile != null)
                          IconButton(
                              constraints: const BoxConstraints(
                                minWidth: 20.0,
                                minHeight: 20.0,
                              ),
                              onPressed: () {
                                _openWhatsapp(mcpCard.mothersMobile!);
                              },
                              icon: SvgPicture.asset(
                                  "assets/images/whatsapp_outlined.svg",
                                  width: 20,
                                  height: 20,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.green, BlendMode.srcIn))),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      "Profile Update",
                      style:
                          TextStyle(color: onSurfaceMediumColor, fontSize: 12),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    Expanded(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: buildProgressIndicator())),
                    const SizedBox(
                      width: 14,
                    ),
                    Text(
                      "${_getProgress(mcpCard)}%",
                      style: const TextStyle(
                          color: onSurfaceMediumColor, fontSize: 12),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BannerCard extends StatelessWidget {
  final String heading;
  final String subHeading;

  const BannerCard({
    Key? key,
    required this.heading,
    required this.subHeading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Obx(() {
      if (homeController.showBanner.value) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 8, 0),
                  child: Icon(
                    Icons.healing,
                    color: AppColors.onPrimaryMedium,
                    size: 48,
                  ),
                ), // Replace "some_icon" with your desired icon
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          heading,
                          style: const TextStyle(
                            color: AppColors.onPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subHeading,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.onPrimaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.onPrimaryLight,
                  ),
                  onPressed: () {
                    homeController.showBanner.toggle();
                  },
                ),
              ],
            ),
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
