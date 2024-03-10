import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<String> pickAndSaveImage(String currentPath) async {
  final ImagePicker picker = ImagePicker();
  final XFile? pickedImage =
      await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    String documentsPath = await saveImageToDocuments(pickedImage.path);
    return documentsPath;
  }

  return currentPath;
}

Future<String> saveImageToDocuments(String imagePath) async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  String documentsPath = '${documentsDirectory.path}/$fileName.jpg';

  await File(imagePath).copy(documentsPath);

  return documentsPath;
}
