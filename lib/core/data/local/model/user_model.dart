import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../../../core.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends Equatable {
  const UserModel({
    required this.id,
    this.name,
    this.email,
    this.photo,
    this.phone,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? photo;
  @HiveField(4)
  final String? phone;

  static const empty = UserModel(id: '');

  bool get isEmpty => this == UserModel.empty;

  bool get isNotEmpty => this != UserModel.empty;

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      photo: entity.photo,
      phone: entity.phone,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      photo: photo,
      phone: phone,
    );
  }

  @override
  List<Object?> get props => [id, name, email, photo, phone];
}
