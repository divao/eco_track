import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getResourceUrlFromStorage(
    FirebaseStorage storage,
    String resourcePath,
    ) async {
  try {
    final a = await storage.ref(resourcePath).getDownloadURL();
    return a;
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
    rethrow;
  }
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load(path);

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.create(recursive: true);
  await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}