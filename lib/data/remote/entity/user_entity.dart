class UserEntity {
  final String name;
  final String email;
  final String uid;
  final DateTime dateJoined;
  final int blogsPosted;

  UserEntity(
      {required this.name,
      required this.email,
      required this.uid,
      required this.dateJoined,
      required this.blogsPosted});
}
