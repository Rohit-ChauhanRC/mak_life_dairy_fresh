import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Utils {
  //
  const Utils._();

  static void closeKeyboard() {
    final currentFocus = Get.focusScope;
    // if (!currentFocus.hasPrimaryFocus) {
    currentFocus!.unfocus();
    // }
  }

  static void showDialog(
    String message, {
    String? title,
    bool success = false,
    Function()? onTap,
  }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async {
          Get.back();
          return true;
        },
        title: title ?? "success",
        content: Text(
          message,
          textAlign: TextAlign.center,
          maxLines: 6,
          style: TextStyle(
            color: Colors.purple[90],
            fontSize: 16,
          ),
        ),
        confirm: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              onTap?.call();

              Get.back();
            },
            child: Text(
              "ok",
              textAlign: TextAlign.center,
              maxLines: 6,
              style: TextStyle(
                color: Colors.purple[90],
                fontSize: 16,
              ),
            ),
          ),
        ),
      );

  static Future<File?> pickImageFromGallery(BuildContext context) async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      showSnackBar(context: Get.context!, content: e.toString());
    }
    return image;
  }

  static Future<File?> pickImageFromCamera(BuildContext context) async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
    } catch (e) {
      showSnackBar(context: Get.context!, content: e.toString());
    }
    return image;
  }

  static Future<void> showImagePicker({
    required Function(File? image) onGetImage,
  }) {
    return showModalBottomSheet<void>(
      context: Get.context!,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () async {
                    onGetImage(await pickImageFromGallery(Get.context!));
                    Get.back();
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.image,
                        size: 60,
                        color: Colors.green,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Gallery",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    onGetImage(await pickImageFromCamera(Get.context!));
                    Get.back();
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera,
                        size: 60,
                        color: Colors.green,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Camera",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static void showSnackBar(
      {required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  static void showDialogYesOrNo(
    String message, {
    String? title,
    bool success = false,
    Function()? onTap,
  }) =>
      Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async {
          Get.back();
          return true;
        },
        title: title ?? "success",
        content: Text(
          message,
          textAlign: TextAlign.center,
          maxLines: 6,
          style: TextStyle(
            color: Colors.purple[90],
            fontSize: 16,
          ),
        ),
        confirm: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                "No",
                textAlign: TextAlign.center,
                maxLines: 6,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                onTap?.call();

                // Get.back();
              },
              child: const Text(
                "Yes",
                textAlign: TextAlign.center,
                maxLines: 6,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );

  static String timeFormated(String time24Hour) {
    String timeWithoutMilliseconds = time24Hour.split(RegExp(r':\d+$'))[0];

    DateTime parsedTime = DateFormat("HH:mm:ss").parse(timeWithoutMilliseconds);
    String formattedTime = DateFormat("hh:mm a").format(parsedTime);
    return formattedTime;
  }

  static dateChg(String date) {
    DateFormat inputFormat = DateFormat("M/d/yyyy h:mm:ss a");
    DateTime dateTime = inputFormat.parse(date);

    // Format the DateTime object into the desired format
    DateFormat outputFormat = DateFormat("MMM d yyyy  h:mm a");
    String formattedDate = outputFormat.format(dateTime);

    // Print the result
    debugPrint(formattedDate); // Output: Jan 9 2025  2:31 PM
    return formattedDate;
  }
}
