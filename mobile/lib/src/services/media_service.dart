import 'dart:io';

import 'package:carful/src/domain/repair_attachment_kind.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class PickedMediaFile {
  const PickedMediaFile({
    required this.path,
    required this.originalName,
    required this.kind,
  });

  final String path;
  final String originalName;
  final RepairAttachmentKind kind;
}

class StoredMediaFile {
  const StoredMediaFile({
    required this.storedPath,
    required this.originalName,
    required this.kind,
    this.fileExtension,
    this.mimeType,
  });

  final String storedPath;
  final String originalName;
  final RepairAttachmentKind kind;
  final String? fileExtension;
  final String? mimeType;
}

class PickedDocumentFile {
  const PickedDocumentFile({
    required this.path,
    required this.originalName,
    required this.byteSize,
  });

  final String path;
  final String originalName;
  final int byteSize;
}

class StoredDocumentFile {
  const StoredDocumentFile({
    required this.storedPath,
    required this.originalName,
    required this.byteSize,
  });

  final String storedPath;
  final String originalName;
  final int byteSize;
}

abstract class MediaService {
  Future<String?> pickCarImage();
  Future<List<PickedMediaFile>> pickRepairImages();
  Future<List<PickedMediaFile>> pickRepairFiles();
  Future<List<PickedDocumentFile>> pickWorkshopManuals();
  Future<StoredMediaFile> storeRepairAttachment(
    PickedMediaFile file, {
    required int repairEntryId,
  });
  Future<StoredDocumentFile> storeWorkshopManual(
    PickedDocumentFile file, {
    required int carProfileId,
  });
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
  Future<List<PickedMediaFile>> pickRepairImages() async {
    final pickedFiles = await _picker.pickMultiImage(
      imageQuality: 88,
      maxWidth: 2200,
    );

    return pickedFiles
        .map(
          (file) => PickedMediaFile(
            path: file.path,
            originalName: p.basename(file.path),
            kind: RepairAttachmentKind.image,
          ),
        )
        .toList();
  }

  @override
  Future<List<PickedMediaFile>> pickRepairFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) {
      return const [];
    }

    return result.files
        .where((file) => file.path != null)
        .map(
          (file) => PickedMediaFile(
            path: file.path!,
            originalName: file.name,
            kind: RepairAttachmentKind.file,
          ),
        )
        .toList();
  }

  @override
  Future<List<PickedDocumentFile>> pickWorkshopManuals() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: const ['pdf'],
    );
    if (result == null) {
      return const [];
    }

    return result.files
        .where((file) => file.path != null)
        .map(
          (file) => PickedDocumentFile(
            path: file.path!,
            originalName: file.name,
            byteSize: file.size,
          ),
        )
        .toList();
  }

  @override
  Future<StoredMediaFile> storeRepairAttachment(
    PickedMediaFile file, {
    required int repairEntryId,
  }) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final targetDirectory = Directory(
      p.join(
        documentsDirectory.path,
        'repair_attachments',
        'repair_$repairEntryId',
      ),
    );
    if (!await targetDirectory.exists()) {
      await targetDirectory.create(recursive: true);
    }

    final extension = p.extension(
      file.originalName.isEmpty ? file.path : file.originalName,
    );
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${_sanitizeName(p.basenameWithoutExtension(file.originalName.isEmpty ? file.path : file.originalName))}$extension';
    final targetPath = p.join(targetDirectory.path, fileName);
    final copiedFile = await File(file.path).copy(targetPath);

    return StoredMediaFile(
      storedPath: copiedFile.path,
      originalName: file.originalName.isEmpty
          ? p.basename(file.path)
          : file.originalName,
      kind: file.kind,
      fileExtension: extension.isEmpty ? null : extension.replaceFirst('.', ''),
    );
  }

  @override
  Future<StoredDocumentFile> storeWorkshopManual(
    PickedDocumentFile file, {
    required int carProfileId,
  }) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final targetDirectory = Directory(
      p.join(documentsDirectory.path, 'workshop_manuals', 'car_$carProfileId'),
    );
    if (!await targetDirectory.exists()) {
      await targetDirectory.create(recursive: true);
    }

    final extension = p.extension(
      file.originalName.isEmpty ? file.path : file.originalName,
    );
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${_sanitizeName(p.basenameWithoutExtension(file.originalName.isEmpty ? file.path : file.originalName))}$extension';
    final targetPath = p.join(targetDirectory.path, fileName);
    final copiedFile = await File(file.path).copy(targetPath);

    return StoredDocumentFile(
      storedPath: copiedFile.path,
      originalName: file.originalName.isEmpty
          ? p.basename(file.path)
          : file.originalName,
      byteSize: file.byteSize,
    );
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

  String _sanitizeName(String value) {
    return value.replaceAll(RegExp(r'[^a-zA-Z0-9_-]+'), '_');
  }
}
