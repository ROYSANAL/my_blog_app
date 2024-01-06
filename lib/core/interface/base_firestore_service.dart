import 'package:my_blog_app/core/class/resource.dart';

typedef Json = Map<String, dynamic>;

abstract class BaseFireStoreService<T> {
  Future insertObject(T data);

  Future deleteObject(T data);

  Future updateObject(Json data, String id);

  Future getObject(String id);

  Resource<Stream> getAllObjects(Object params);
}
