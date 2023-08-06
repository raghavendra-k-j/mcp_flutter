import 'package:get/get.dart';
import 'package:mcp_app/database/data.dart';

class ViewCardController extends GetxController {
  MCPCard mcpCard;
  ViewCardController({required this.mcpCard});

  var currentIndex = 0.obs;
  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}