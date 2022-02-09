class Wish {
  final String userId;
  final String title;
  final String? description;
  String imageRef;
  late DateTime dateCreated;

  Wish({required this.userId, required this.title, this.description, this.imageRef = ""}) {
    dateCreated = DateTime.now();
  }
}
