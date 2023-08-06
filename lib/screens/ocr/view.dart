// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mcp_app/values/colors.dart';

class AadhaarScanningController extends GetxController {
  Rx<CroppedFile?> croppedFrontImage = Rx<CroppedFile?>(null);
  Rx<CroppedFile?> croppedBackImage = Rx<CroppedFile?>(null);

  Map<String, String> frontMap = {};
  Map<String, String> backMap = {};

  var frontImageState = ''.obs;
  var backImageState = ''.obs;

  Future<void> processImage(BuildContext buildContext, String side) async {
    InputImage inputImage;
    if (side == 'front') {
      frontImageState.value = 'Processing...';
      inputImage = InputImage.fromFile(File(croppedFrontImage.value!.path));
    } else {
      backImageState.value = 'Processing...';
      inputImage = InputImage.fromFile(File(croppedBackImage.value!.path));
    }
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    textRecognizer.close();
  }
}

class AadhaarScanningScreen extends StatelessWidget {
  const AadhaarScanningScreen({super.key});

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
          "Scan Aadhaar Card",
          style: TextStyle(
            color: onSurfaceColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: AadhaarScreenContentBody(),
    );
  }
}

class AadhaarScreenContentBody extends StatelessWidget {
  final AadhaarScanningController controller =
      Get.put(AadhaarScanningController());

  AadhaarScreenContentBody({super.key});

  Future<void> _chooseImage(
      BuildContext buildContext, String side, ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio3x2,
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio3x2,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Crop Image',
          ),
        ],
      );
      if (croppedFile != null) {
        if (side == 'front') {
          controller.croppedFrontImage.value = croppedFile;
        } else {
          controller.croppedBackImage.value = croppedFile;
        }
        if (buildContext.mounted) {
          await controller.processImage(buildContext, side);
        }
      }
    }
  }

  Widget _renderImageView(BuildContext buildContext, String side) {
    String? imageFilePath;
    File? imageFileToRender;
    if (side == 'front') {
      imageFilePath = controller.croppedFrontImage.value != null
          ? controller.croppedFrontImage.value!.path
          : null;
    } else {
      imageFilePath = controller.croppedBackImage.value != null
          ? controller.croppedBackImage.value!.path
          : null;
    }
    if (imageFilePath != null) imageFileToRender = File(imageFilePath);

    return Container(
      child: Ink(
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: (side == 'front')
                    ? const Text('Front Side')
                    : const Text('Back Side')),
          ),
          Expanded(
            child: Obx(() {
              if ((controller.croppedFrontImage.value != null &&
                      side == 'front') ||
                  (controller.croppedBackImage.value != null &&
                      side == 'back')) {
                if (side == 'front') {
                  return croppedImageView(controller.croppedFrontImage.value!);
                } else {
                  return croppedImageView(controller.croppedBackImage.value!);
                }
              } else {
                return Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          _chooseImage(buildContext, side, ImageSource.camera);
                        },
                        child: const SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt_outlined),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Camera"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          _chooseImage(buildContext, side, ImageSource.gallery);
                        },
                        child: const SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_outlined),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Gallery"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
          if (side == 'front')
            Obx(() => processingState(
                buildContext, controller.frontImageState.value)),
          if (side == 'back')
            Obx(() =>
                processingState(buildContext, controller.backImageState.value)),
        ]),
      ),
    );
  }

  Widget processingState(BuildContext buildContext, String state) {
    if (state == 'Processing...') {
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: Text(state)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.close),
              constraints: const BoxConstraints(minWidth: 10, minHeight: 10),
            ),
          ],
        ),
      );
    } else if (state == 'Completed') {
      return Text(state);
    } else {
      return Container();
    }
  }

  Widget croppedImageView(CroppedFile file) {
    return Image.file(
      File(file.path),
      fit: BoxFit.cover,
      width: double.maxFinite,
      height: double.maxFinite,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Obx(() => _renderImageView(context, 'front')),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => _renderImageView(context, 'back')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createCardItem(BuildContext buildContext, String title) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: borderBetweenSurfaceAndBackground, width: 0.5),
      ),
      child: Column(
        children: [
          createCardHeader(buildContext, title),
        ],
      ),
    );
  }

  Widget createImageContainer(File file, Function onTapFunction) {
    return Stack(
      children: [
        SizedBox(
          width: 300,
          height: 200,
          child: Image.file(
            file,
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Row(
            children: [
              const SizedBox(child: CircularProgressIndicator(strokeWidth: 0.5)),
              const SizedBox(child: Text("Processing")),
              InkWell(
                onTap: onTapFunction,
                child: const Icon(Icons.close),
              )
            ],
          ),
        )
      ],
    );
  }


  Widget createCardHeader(BuildContext buildContext, String title) {
    return Container(padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),child: Text(title, style: const TextStyle(color: onSurfaceColor),),);
  }
}
