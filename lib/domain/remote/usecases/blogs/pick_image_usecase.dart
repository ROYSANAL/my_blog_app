import 'package:image_picker/image_picker.dart';
import 'package:my_blog_app/core/class/resource.dart';

class PickImageUseCase {
  final _imagePicker = ImagePicker();

  Future<Resource<XFile>> call() async {
    final res = await _imagePicker.pickImage(source: ImageSource.gallery ,imageQuality: 20);
    if (res != null) {
      return Success(res);
    } else {
      return Failure("no image picked");
    }
  }
}
