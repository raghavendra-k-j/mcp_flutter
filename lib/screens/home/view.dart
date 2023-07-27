// ignore_for_file: avoid_print

import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcp_app/screens/add_person/view.dart';
import 'package:mcp_app/screens/home/controller.dart';
import 'package:mcp_app/values/colors.dart';
import 'package:mcp_app/values/styles.dart';

import '../../database/data.dart';
import '../card_details/view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    HomeCardListController homeCardListController = Get.put(HomeCardListController());
    MyDatabase myDatabase = Get.find();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: onSurfaceColor),
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "Welcome Ms.Kumari",
          style: TextStyle(color: onSurfaceColor, fontWeight: FontWeight.normal),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => DriftDbViewer(myDatabase));
            },
            icon: const Icon(Icons.table_view_outlined, color: surfaceColor,),
          ),
        ],
      ),
      // drawer: const AppDrawer(),
      body: const HomeScreenContentBody(),
      backgroundColor: backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Person? result = await Get.to(() => AddCard());
          print(result?.motherName);
          if(result != null) {
            homeCardListController.addElement(result);
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Obx(
            () =>
            BottomNavigationBar(
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
                  label: 'Appointments',
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
          const BannerCard(heading: 'Healthcare', subHeading: 'Anytime, Anywhere',),
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
                onTapOutside: (_) {
                    _focusNode.unfocus();
                },
                onSubmitted: (query) {
                  homeCardListController.loadList(query: query);
                },
                controller: homeController.searchEditController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                  prefixIcon: IconButton(
                    color: onSurfaceLightColor,
                    onPressed: () {
                      homeController.listenInEnglish.toggle();
                    },
                    icon: Obx(() =>
                        Icon((homeController.listenInEnglish.value == true)
                            ? Icons.search
                            : Icons.translate)),
                  ),
                  suffixIcon: IconButton(
                    color: onSurfaceMediumColor,
                    onPressed: () {
                      homeController.toggleListening();
                    },
                    icon: Obx(() =>
                        Icon((homeController.isListening.value == true)
                            ? Icons.mic
                            : Icons.mic_none)),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                homeCardListController.loadList(query: homeController.searchEditController.text);
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

  void _showFullScreenDialog(BuildContext context, List<String> hintsList) {
    showDialog(
      context: context,
      builder: (context) =>
          Dialog(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
              // Set the background color of the dialog
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: hintsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(hintsList[index]),
                  );
                },
              ),
            ),
          ),
    );
  }


  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Row(
        children: [
          Expanded(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: controller.hints.map((hint) {
                  return TyperAnimatedText(
                    hint,
                    textStyle: const TextStyle(
                        fontSize: 16,
                        color: onSurfaceLightColor,
                        fontStyle: FontStyle.italic),
                    speed: const Duration(milliseconds: 150),
                  );
                }).toList(),
              )),
          GestureDetector(
            onTap: () {
              _showFullScreenDialog(context, controller.hints);
            },
            child: Text(
              "More Hints",
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
        child: Obx(() =>
            ListView.builder(
              itemCount: homeCardListController.items.length,
              itemBuilder: (context, index) {
                Person person = homeCardListController.items[index];
                return HomeScreenPersonItem(person: person,);
              },
            ),
        ),
    );
  }

}

class HomeScreenPersonItem extends StatelessWidget {

  final Person person;

  const HomeScreenPersonItem({super.key, required this.person});

  int _getProgress(Person person) {
    final random = Random();
    var progress = (person.hemoglobin != null && person.hemoglobin! < 7) ? 60 : (20 + random.nextDouble() * 30);
    return progress.toInt();
  }

  Widget buildProgressIndicator() {
    double progress = (_getProgress(person) * 0.01);
    if (progress > 0.5) {
      return LinearProgressIndicator(
        minHeight: 8,
        value: progress,
        backgroundColor: Colors.grey[200],
        valueColor: const AlwaysStoppedAnimation<Color>(Color.fromARGB(
            255, 255, 106, 0)),
      );
    } else {
      return LinearProgressIndicator(
        minHeight: 8,
        value: progress,
        backgroundColor: Colors.grey[200],
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    var random = Random();
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: GestureDetector(
        onTap: () {
          Get.to(() => CardDetailsScreen(person: person,));
        },
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('CardID: MCPC${person.id.toString().padLeft(4, '0')}', style: const TextStyle(color: onSurfaceColor),),
                          Text('Name: ${person.motherName}'),
                          Text('Gender: ${random.nextBool() ? 'Female' : 'Female'}'),
                          Text('Age: ${person.motherAge} Years'),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text("Checking", style: TextStyle(color: onSurfaceMediumColor, fontSize: 12),),
                    const SizedBox(width: 14,),
                    Expanded(child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: buildProgressIndicator()
                    )),
                    const SizedBox(width: 14,),
                    Text("${_getProgress(person)}%", style: const TextStyle(color: onSurfaceMediumColor, fontSize: 12),),
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
    return Obx(()  {
      if(homeController.showBanner.value) {
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
                  child: Icon(Icons.healing, color: AppColors.onPrimaryMedium, size: 48,),
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
                  icon: const Icon(Icons.close, color: AppColors.onPrimaryLight,),
                  onPressed: () {
                    homeController.showBanner.toggle();
                  },
                ),
              ],
            ),
          ),
        );
      }
      else {
        return Container();
      }
    });
  }
}
