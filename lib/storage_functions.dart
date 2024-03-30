import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageFunctions {
  final Function callback;
  StorageFunctions(this.callback);

  Future<String?> uploadImageToFirebaseStorage(List<XFile> imageFiles) async {
    /*  try {
      // Erstellen einer Referenz auf den Speicherort im Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}');

      // Bild hochladen
      for (var i = 0; i < imageFiles.length; i++) {
        // Erstellen einer Referenz auf den Speicherort im Firebase Storage

        // Bild hochladen
        // ignore: unused_local_variable
        UploadTask uploadTask =
            storageReference.putFile(File(imageFiles[i].path));
      }

      callback();

      print("Push succesful");

      return null;
    } catch (e) {
      print("ErrorLar");
      return null;
    }
    */
  }
}
