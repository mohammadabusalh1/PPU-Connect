import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

mixin FilePickerMixin<T extends StatefulWidget> on State<T> {
  final _picker = ImagePicker();

  Future<File?> pickImageFromGallery() => _pickImage(ImageSource.gallery);
  Future<File?> pickImageFromCamera() => _pickImage(ImageSource.camera);

  Future<File?> showImageSourceSheet() async {
    File? result;
    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from gallery'),
              onTap: () async {
                Navigator.of(ctx).pop();
                result = await pickImageFromGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take a photo'),
              onTap: () async {
                Navigator.of(ctx).pop();
                result = await pickImageFromCamera();
              },
            ),
          ],
        ),
      ),
    );
    return result;
  }

  Future<File?> _pickImage(ImageSource source) async {
    final xFile = await _picker.pickImage(
      source: source,
      imageQuality: 85,
      maxWidth: 1024,
      maxHeight: 1024,
    );
    return xFile == null ? null : File(xFile.path);
  }
}
