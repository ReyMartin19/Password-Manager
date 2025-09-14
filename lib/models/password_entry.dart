import 'package:hive/hive.dart';

part 'password_entry.g.dart';

@HiveType(typeId: 0)
class PasswordEntry extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String username;

  @HiveField(3)
  String password;

  @HiveField(4)
  String? notes;

  @HiveField(5)
  String category; // NEW FIELD

  PasswordEntry({
    required this.id,
    required this.title,
    required this.username,
    required this.password,
    this.notes,
    required this.category,
  });
}
