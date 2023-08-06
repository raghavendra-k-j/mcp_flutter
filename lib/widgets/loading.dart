import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mcp_app/util/logger.dart';
import 'package:mcp_app/values/colors.dart';

class LoadingDialog {
  static BuildContext? _dialogContext;
  static bool _isDialogVisible = false;

  static void loading(BuildContext context, {String text = 'Loading...'}) {
    if(_isDialogVisible) hide();
    if (!_isDialogVisible) {
      _dialogContext = context;
      _isDialogVisible = true;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.fromLTRB(32, 40, 32, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 24.0),
                    Text(
                      text,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static void hide() {
    if (_isDialogVisible && _dialogContext != null && _dialogContext!.mounted) {
      Navigator.of(_dialogContext!,).pop(1);
      _isDialogVisible = false;
      _dialogContext = null;
    }
  }

  static void hideAndComplete(int value, Completer<int> completer) {
    if (_isDialogVisible && _dialogContext != null && _dialogContext!.mounted) {
      logd("closing dialog");
      Navigator.of(_dialogContext!,).pop(value);
      _isDialogVisible = false;
      _dialogContext = null;
    }
    completer.complete(value);
  }

  static Future<int?> show(BuildContext context, {
    String? title,
    String? message,
    DialogType dialogType = DialogType.info,
    int? duration,
    bool? canDismiss,
    bool? showCloseButton = false,
  }) async {

    if (_isDialogVisible) hide();

    _dialogContext = context;
    _isDialogVisible = true;

    Completer<int> completer = Completer<int>();

    Timer? timer;

    showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        if (duration != null && duration > 0) {
          timer = Timer(Duration(milliseconds: duration), () {
            logd("closed by timer");
            hideAndComplete(1, completer);
          });
        }

        return WillPopScope(
          onWillPop: () async {
            if(canDismiss!= null && canDismiss == true) {
              timer?.cancel();
              hideAndComplete(1, completer);
            }
            return false;
          },
          child: Center(
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getBackgroundColor(dialogType),
                    ),
                    child: Icon(
                      _getIconData(dialogType),
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                  if (title != null && title.isNotEmpty) const SizedBox(height: 16.0),
                  if (title != null && title.isNotEmpty) Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (message != null && message.isNotEmpty) const SizedBox(height: 16.0),
                  if (message != null && message.isNotEmpty) Text(
                    message,
                    style: const TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
                  if(showCloseButton != null && showCloseButton == true) TextButton(
                    onPressed: () {
                      timer?.cancel();
                      hideAndComplete(1, completer);
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(
                          width: 0.5,
                          color: primary,
                        ),
                      ),
                    ),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return completer.future;
  }

  static IconData _getIconData(DialogType type) {
    switch (type) {
      case DialogType.success:
        return Icons.check_circle;
      case DialogType.error:
        return Icons.error;
      case DialogType.warning:
        return Icons.warning;
      case DialogType.info:
      default:
        return Icons.info;
    }
  }

  static Color _getBackgroundColor(DialogType type) {
    switch (type) {
      case DialogType.success:
        return Colors.green;
      case DialogType.error:
        return Colors.red;
      case DialogType.warning:
        return Colors.orange;
      case DialogType.info:
      default:
        return Colors.blue;
    }
  }
}

enum DialogType {
  success,
  error,
  warning,
  info,
}
