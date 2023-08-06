import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mcp_app/screens/home/view.dart';

import '../../values/colors.dart';

class LoginScreenController extends GetxController {}

class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreenBodyContent(),
    );
  }
}

class LoginScreenBodyContent extends StatelessWidget {
  const LoginScreenBodyContent({super.key});

  Widget _buildHeader() {
    return Text("");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            ElevatedButton(onPressed: () {
              Get.to(() => const HomeScreen() );
            }, child: const Text("Go to Home"))
          ],
        ),
      ),
    );
  }
}