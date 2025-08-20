import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> pickImage() async {
  try {
    final xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 65,
    );

    if (xFile != null) {
      return File(xFile.path);
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

// description: This function uses the image_picker package to allow users to select an image from their device's gallery.

// It returns a File object if an image is selected, or null if the user cancels the selection or an error occurs.
