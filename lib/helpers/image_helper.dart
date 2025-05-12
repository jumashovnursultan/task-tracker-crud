import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<File?> pickImage(
    ImageSource source, {
    ImageCompressFormat? compressFormat,
  }) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
      // await cropImage(
      //   File(pickedFile.path),
      //   compressFormat: compressFormat,
      // );
    }

    return null;
  }

  static Future<File?> cropImage(
    File imageFile, {
    ImageCompressFormat? compressFormat,
  }) async {
    final aspectRatioPresets = [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9,
    ];

    final croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressQuality: 70,
      uiSettings: [
        AndroidUiSettings(
          lockAspectRatio: false,
          aspectRatioPresets: aspectRatioPresets,
        ),
        IOSUiSettings(
          aspectRatioLockEnabled: true,
          aspectRatioPresets: aspectRatioPresets,
        ),
      ],
      compressFormat: compressFormat ?? ImageCompressFormat.jpg,
    );
    return croppedImage != null ? File(croppedImage.path) : null;
  }

  static Future<List<File>?> pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      return pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    }

    return null;
  }
}
