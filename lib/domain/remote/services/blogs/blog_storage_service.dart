import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_blog_app/core/class/resource.dart';

class BlogStorageService {
  final _storage = FirebaseStorage.instance.ref("/blogImages");

  Future<Resource<String>> uploadImage(String id, XFile image) async {
    try {
      final task = await _storage.child(id).putFile(File(image.path));
      final url = await _storage.child(id).getDownloadURL();
      return Success(url);
    } on FirebaseException catch (e) {
      return Failure(e.message.toString());
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
