import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../values/colors.dart';

class SearchHintItem {
  String hintText;
  String? description;

  SearchHintItem({required this.hintText, this.description});
}

class SearchHintSection {
  var isOpen = RxBool(false);
  String headerText;
  List<SearchHintItem> searchHintItems;

  SearchHintSection(
      {required this.headerText, required this.searchHintItems, bool? isOpen})
      : isOpen = RxBool(isOpen ?? false);
}

class SearchHintScreenController extends GetxController {
  List<SearchHintSection> searchHintSections = [
    SearchHintSection(
        headerText: "How to Search by Name",
        searchHintItems: [
          SearchHintItem(
            hintText: "View Arpita Profile",
          ),
          SearchHintItem(
            hintText: "Display Arpita Profile",
          ),
          SearchHintItem(
            hintText: "Arpita Profile",
          ),
          SearchHintItem(
            hintText: "Arpita Mahiti",
          ),
          SearchHintItem(
            hintText: "Arpita ಮಾಹಿತಿ",
          ),
          // SearchHintItem(
          //   hintText: "ಅರ್ಪಿತ ಮಾಹಿತಿ",
          // ),
          // SearchHintItem(
          //   hintText: "ಅರ್ಪಿತ ಮಾಹಿತಿಯನ್ನು ತೋರಿಸು",
          // ),
          // SearchHintItem(
          //   hintText: "ಅರ್ಪಿತ ಪ್ರೊಫೈಲ್ ತೋರಿಸು",
          // ),
        ],
        isOpen: true),
    SearchHintSection(
        headerText: "How to Search by Hemoglobin",
        searchHintItems: [
          SearchHintItem(
            hintText: "Hemoglobin less than 11.0",
          ),
          SearchHintItem(
            hintText: "Hb less than 11.0",
          ),
          SearchHintItem(
            hintText: "Hemoglobin greater than 14.5",
          ),
          SearchHintItem(
            hintText: "Hb greater than 14.5",
          ),
          SearchHintItem(
            hintText: "ಹಿಮೋಗ್ಲೋಬಿನ್ 14.5 ಗಿಂತ ಹೆಚ್ಚು",
          ),
          SearchHintItem(
            hintText: "ಹಿಮೋಗ್ಲೋಬಿನ್ 11.0 ಗಿಂತ ಕಡಿಮೆ",
          ),
          SearchHintItem(
            hintText: "ಹೆಚ್ ಬಿ 14.5 ಗಿಂತ ಹೆಚ್ಚು",
          ),
          SearchHintItem(
            hintText: "ಹೆಚ್ ಬಿ 11.0 ಗಿಂತ ಕಡಿಮೆ",
          ),
        ],
        isOpen: false),
    SearchHintSection(
        headerText: "How to Search by BP",
        searchHintItems: [
          SearchHintItem(
            hintText: "BP less than 120/80",
          ),
          SearchHintItem(
            hintText: "BP greater than 120/80",
          ),
          SearchHintItem(
            hintText: "View Profiles Having Low BP",
          ),
          SearchHintItem(
            hintText: "View Profiles Having High BP",
          ),
          SearchHintItem(
            hintText: "ಬಿಪಿ 120/80 ಗಿಂತ ಕಡಿಮೆ ",
          ),
          SearchHintItem(
            hintText: "ಬಿಪಿ 120/80 ಗಿಂತ ಹೆಚ್ಚು",
          ),
        ],
        isOpen: false),
    SearchHintSection(
        headerText: "How to Search by Age",
        searchHintItems: [
          SearchHintItem(
            hintText: "Age less than 25",
          ),
          SearchHintItem(
            hintText: "Age greater than 30",
          ),
          SearchHintItem(
            hintText: "Age between 25 and 30",
          ),
          SearchHintItem(
            hintText: "ವಯಸ್ಸು 25 ಗಿಂತ ಕಡಿಮೆ",
          ),
          SearchHintItem(
            hintText: "ವಯಸ್ಸು 25 ಗಿಂತ ಹೆಚ್ಚು",
          ),
          SearchHintItem(
              hintText: "ವಯಸ್ಸು 25 ಮತ್ತು 30 ರ ನಡುವೆ"
          ),
        ],
        isOpen: false)
  ].obs;

  void toggleAccordion(SearchHintSection searchHintSection) {
    int index = searchHintSections.indexOf(searchHintSection);
    int length = searchHintSections.length;
    for(int i = 0; i < length; i++) {
      if(i == index) {
        searchHintSections[index].isOpen.value = !searchHintSections[index].isOpen.value;
      }
      else {
        searchHintSections[i].isOpen.value = false;
      }
    }
  }
}

class SearchHintsScreen extends StatelessWidget {
  SearchHintsScreen({super.key});

  final SearchHintScreenController searchHintsScreenController =
      Get.put(SearchHintScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(),
        iconTheme: const IconThemeData(color: onSurfaceColor),
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "How to Search",
          style: TextStyle(
            color: onSurfaceColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: SearchHintsScreenBodyContent(),
    );
  }
}

class SearchHintsScreenBodyContent extends StatelessWidget {
  SearchHintsScreenBodyContent({super.key});

  final SearchHintScreenController searchHintsScreenController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          children: searchHintsScreenController.searchHintSections.map((e) => SearchHintSectionWidget(e)).toList(),
        ),
      ),
    );
  }
}

class SearchHintSectionWidget extends StatelessWidget {
  final SearchHintSection searchHintSection;

  final SearchHintScreenController searchHintScreenController = Get.find();

  SearchHintSectionWidget(this.searchHintSection, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Ink(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: surfaceColor,
              border: Border.all(
                  color: borderBetweenSurfaceAndBackground, width: 0.6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Ink(
                child: InkWell(
                  onTap: () {
                    searchHintScreenController.toggleAccordion(searchHintSection);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: onSurfaceDividerMedium,
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Text(
                              searchHintSection.headerText,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: onSurfaceColor),
                            ),
                          ),
                        ),
                        Obx(() {
                          if (searchHintSection.isOpen.value) {
                            return IconButton(
                              icon: const Icon(Icons.keyboard_arrow_up),
                              onPressed: () {
                                searchHintScreenController.toggleAccordion(searchHintSection);
                              },
                            );
                          } else {
                            return IconButton(
                              icon: const Icon(Icons.keyboard_arrow_down),
                              onPressed: () {
                                searchHintScreenController.toggleAccordion(searchHintSection);
                              },
                            );
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ),
              Obx(() {
                if (searchHintSection.isOpen.value) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var item in searchHintSection.searchHintItems)
                          SearchHintItemWidget(
                            item: item,
                          )
                      ]);
                } else {
                  return Container();
                }
              })
            ],
          )),
    );
  }
}

class SearchHintItemWidget extends StatelessWidget {
  final SearchHintItem item;

  const SearchHintItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () => Get.back(result: item.hintText),
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(color: onSurfaceDividerLight, width: 0.5, )
            ),
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              item.hintText,
              style: const TextStyle(color: onSurfaceMediumColor, fontSize: 16),
            ),
          ),
        ),
        if (item.description != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
            child: Text(item.description!,
                style: const TextStyle(color: onSurfaceLightColor)),
          )
      ],
    );
  }
}
