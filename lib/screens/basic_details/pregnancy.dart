import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../values/styles.dart';


class PregnancyApp extends StatelessWidget {
  const PregnancyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PregnancyAppContent(),
    );
  }
}

class PregnancyAppContent extends StatelessWidget {
  const PregnancyAppContent({super.key});

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
          "Pregnancy Record",
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
              icon: const Icon(
                Icons.check,
                color: AppColors.onSurface,
              ),
            ),
          ),
        ],
      ),
      body: const PregnancyAppBody(),
    );
  }
}

class PregnancyAppBody extends StatelessWidget {
  const PregnancyAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: double.maxFinite,
      child: const Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                PregnancyAppForm(),
              ],
            )),
          ),
        ],
      ),
    );
  }
}

class PregnancyAppForm extends StatefulWidget {
  const PregnancyAppForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PregnancyAppForm();
  }
}

class _PregnancyAppForm extends State<PregnancyAppForm> {

  final TextEditingController _dateControllerForLastMenstrualPeriod = TextEditingController();
  final TextEditingController _dateControllerForExpectedDateOfDelivery = TextEditingController();

  @override
  void dispose() {
    _dateControllerForLastMenstrualPeriod.dispose();
    _dateControllerForExpectedDateOfDelivery.dispose();
    super.dispose();
  }

  String _formatDate(DateTime? d) {
    if(d == null) {
      return "";
    }
    else {
      return DateFormat("dd-MM-yyyy").format(d);
    }
  }

  void _showDatePicker(BuildContext buildContext, TextEditingController controller) {
    showDatePicker(
        context: buildContext,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now())
        .then((value) => {
      setState(() {
        controller.text = _formatDate(value);
      })
    });
  }

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
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Date of Last Menstrual Period",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(child: TextFormField(
                    readOnly: true,
                    controller: _dateControllerForLastMenstrualPeriod,
                    textAlign: TextAlign.end,
                    onTap: () {
                      _showDatePicker(context, _dateControllerForLastMenstrualPeriod);
                    },
                    decoration: const InputDecoration(
                      hintStyle: Styles.textStyleHint,
                      hintText: "dd-mm-yyyy",
                      border: InputBorder.none,
                    ),
                  )),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Expected Date of Delivery",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(child: TextFormField(
                    readOnly: true,
                    controller: _dateControllerForExpectedDateOfDelivery,
                    textAlign: TextAlign.end,
                    onTap: () {
                      _showDatePicker(context, _dateControllerForExpectedDateOfDelivery);
                    },
                    decoration: const InputDecoration(
                      hintStyle: Styles.textStyleHint,
                      hintText: "dd-mm-yyyy",
                      border: InputBorder.none,
                    ),
                  )),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          "Number of Pregnancies/Previous Live Births ",
                          style: Styles.textStyleFormLabel,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                      flex: 1,
                      child: TextFormField(
                    textAlign: TextAlign.end,
                    decoration: const InputDecoration(
                      hintStyle: Styles.textStyleHint,
                      hintText: "Select your times",
                      border: InputBorder.none,
                    ),
                  )),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Last delivery conducted at",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(child: TextFormField(
                    textAlign: TextAlign.end,
                    decoration: const InputDecoration(
                      hintStyle: Styles.textStyleHint,
                      hintText: "Enter Place",
                      border: InputBorder.none,
                    ),
                  )),
                ],
              ),
            ),
            Container(
              decoration: Styles.borderBottom,
              padding: const EdgeInsets.fromLTRB(16, 1, 16, 1),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Current Delivery",
                    style: Styles.textStyleFormLabel,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(child: TextFormField(
                    textAlign: TextAlign.end,
                    decoration: const InputDecoration(
                      hintStyle: Styles.textStyleHint,
                      hintText: "Enter Place",
                      border: InputBorder.none,
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
