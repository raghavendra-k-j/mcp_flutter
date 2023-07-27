import 'package:another_xlider/another_xlider.dart';
import 'package:another_xlider/models/slider_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mcp_app/values/colors.dart';

import '../../util/datetime_util.dart';
import '../../values/styles.dart';

class BirthApp extends StatelessWidget {
  const BirthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: BirthAppContent(),);
  }
}

class BirthAppContent extends StatelessWidget {
  const BirthAppContent({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      elevation: 1,
      backgroundColor: surfaceColor,
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: onSurfaceColor),
      leading: IconButton(onPressed: () {
        Navigator.of(context).pop(context);
      }, icon: const Icon(Icons.arrow_back, color: onSurfaceColor,),),
      title: const Text("Birth Record", style: TextStyle(
          fontWeight: FontWeight.bold,
          color: onSurfaceColor,
          fontSize: 18),),
      centerTitle: true,
      actions: [
        Container(padding: const EdgeInsets.all(8),
          child: IconButton(onPressed: () {},
            icon: const Icon(Icons.check, color: onSurfaceColor,),),),
      ],), body: const BirthAppBody(),);
  }
}

class BirthAppBody extends StatelessWidget {
  const BirthAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(width: double.maxFinite,
      child: const Column(children: [
        Expanded(child: SingleChildScrollView(
            child: Column(children: [BirthAppForm(),
            ],)),),
      ],),);
  }
}

class BirthAppForm extends StatefulWidget {
  const BirthAppForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BirthAppForm();
  }
}

class _BirthAppForm extends State<BirthAppForm> {

  final TextEditingController _textEditingControllerChildDateOfBirth = TextEditingController();

  String? _selectedGender;

  _showDatePicker(TextEditingController controller) {
    showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now().add(const Duration(days: 5))).then((value) =>
    {setState(() {
      controller.text = DateTimeUtil.formatDate(value);
    })});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Container(decoration: BoxDecoration(color: Colors.white,
        border: Border.all(color: const Color(0xFFE1E1E1), width: 1,),
        borderRadius: BorderRadius.circular(8),),
        child: Form(child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(mainAxisSize: MainAxisSize.max,
                children: [
                  const Column(children: [
                    Text("Child Name", style: Styles.textStyleFormLabel,),
                  ],),
                  const SizedBox(width: 2,),
                  Expanded(flex: 1,
                    child: TextFormField(textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Child Name",
                        border: InputBorder.none,),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(40),
                        FilteringTextInputFormatter(RegExp(r'[a-zA-Z ]'),
                            allow: true),
                      ],),),
                ],),),
            Container(decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(mainAxisSize: MainAxisSize.max,
                children: [
                  const Column(children: [
                    Text("Date of Birth", style: Styles.textStyleFormLabel,),
                  ],),
                  const SizedBox(width: 2,),
                  Expanded(flex: 1,
                    child: TextFormField(
                      controller: _textEditingControllerChildDateOfBirth,
                      onTap: () {
                        _showDatePicker(_textEditingControllerChildDateOfBirth);
                      },
                      readOnly: true,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "dd-mm-yyyy",
                        border: InputBorder.none,),),),
                ],),),
            Container(decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(mainAxisSize: MainAxisSize.max,
                children: [
                  const Column(children: [
                    Text("Birth Weight(g)", style: Styles.textStyleFormLabel,),
                  ],),
                  const SizedBox(width: 10,),
                  Expanded(flex: 1,
                    child: FlutterSlider(
                      handlerHeight: 24,
                      handlerWidth: 24,
                      min: 1000,
                      max: 6000,
                      step: const FlutterSliderStep(step: 1),
                      values: const [3000],
                      onDragging: (handlerIndex, lowerValue, upperValue) {

                      },),),
                ],),),
            Container(decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Gender", style: Styles.textStyleFormLabel,),
                  const SizedBox(width: 16,),
                  Expanded(flex: 1,
                    child: Row(mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Radio(value: "male",
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },),
                        const Text("Male"),
                        Radio(value: "female",
                          groupValue: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },),
                        const Text("Female"),
                      ],),),
                ],),),
            Container(decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Row(mainAxisSize: MainAxisSize.max,
                children: [
                  Container(constraints: const BoxConstraints(maxWidth: 120),
                    child: const Text("Birth Registration Number",
                      style: Styles.textStyleFormLabel,),),
                  const SizedBox(width: 2,),
                  Expanded(flex: 1,
                    child: TextFormField(textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter Registration Number",
                        border: InputBorder.none,),
                      inputFormatters: [LengthLimitingTextInputFormatter(40),
                      ],),),
                ],),),
            Container(decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
              child: Row(mainAxisSize: MainAxisSize.max,
                children: [
                  Container(constraints: const BoxConstraints(maxWidth: 120),
                    child: const Text(
                      "MCTS/RCH ID", style: Styles.textStyleFormLabel,),),
                  const SizedBox(width: 2,),
                  Expanded(flex: 1,
                    child: TextFormField(textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                        hintStyle: Styles.textStyleHint,
                        hintText: "Enter MCTS/RCH ID",
                        border: InputBorder.none,),
                      inputFormatters: [LengthLimitingTextInputFormatter(40),
                      ],),),
                ],),),
          ],),),),);
  }
}

