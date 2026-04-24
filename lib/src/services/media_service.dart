import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

abstract class MediaService {
  Future<String?> pickCarImage();
  Future<void> deleteStoredFile(String? path);
}

class DeviceMediaService implements MediaService {
  DeviceMediaService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  @override
  Future<String?> pickCarImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 88,
      maxWidth: 2200,
    );
    if (pickedFile == null) {
      return null;
    }

    final documentsDirectory = await getApplicationDocumentsDirectory();
    final targetDirectory = Directory(
      p.join(documentsDirectory.path, 'car_profile_images'),
    );
    if (!await targetDirectory.exists()) {
      await targetDirectory.create(recursive: true);
    }

    final extension = p.extension(pickedFile.path);
    final fileName = 'car_${DateTime.now().millisecondsSinceEpoch}$extension';
    final targetPath = p.join(targetDirectory.path, fileName);
    final copiedFile = await File(pickedFile.path).copy(targetPath);
    return copiedFile.path;
  }

  @override
  Future<void> deleteStoredFile(String? path) async {
    if (path == null || path.isEmpty) {
      return;
    }

    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
