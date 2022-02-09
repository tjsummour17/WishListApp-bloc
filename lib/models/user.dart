import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String password;

  User({required this.id, required this.name, required this.password});

  Map<String, dynamic> toJson() => {'username': name, 'password': password, 'id': id};
}
