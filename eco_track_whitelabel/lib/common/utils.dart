import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

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