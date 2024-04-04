import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class MediaService {
  static Future<Uint8List?> pickImage() async {
    try {
      final imagePicker = ImagePicker();
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        var result = await FlutterImageCompress.compressWithFile(
          file.path,
          minWidth: 600,
          minHeight: 600,
          quality: 88,
        );
        if (result != null) {
          return Uint8List.fromList(result);
        }
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
    return null;
  }

  static Future<Uint8List?> pickImageFromCamera() async {
    try {
      final imagePicker = ImagePicker();
      final file = await imagePicker.pickImage(source: ImageSource.camera);
      if (file != null) {
        var result = await FlutterImageCompress.compressWithFile(
          file.path,
          minWidth: 600,
          minHeight: 600,
          quality: 88,
        );
        if (result != null) {
          return Uint8List.fromList(result);
        }
      }
    } on PlatformException catch (e) {
      debugPrint('Failed to pick image: $e');
    }
    return null;
  }
}
