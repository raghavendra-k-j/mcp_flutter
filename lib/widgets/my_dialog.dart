import 'package:flutter/material.dart';

class SimpleDialog {

  static final SimpleDialog _instance = SimpleDialog._internal();

  factory SimpleDialog() {
    return _instance;
  }

  SimpleDialog._internal();

  void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text('Loading...'),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCustomDialog(BuildContext context, {
    required String title,
    required IconData icon,
    required String content,
    required Function onPrimaryPressed,
    required Function onSecondaryPressed,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 48,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(content),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onSecondaryPressed();
                      },
                      child: const Text('Secondary'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onPrimaryPressed();
                      },
                      child: const Text('Primary'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void close(BuildContext context) {
    Navigator.pop(context);
  }
}
