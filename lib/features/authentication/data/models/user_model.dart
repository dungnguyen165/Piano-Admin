import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../domain/entity/user_entity.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? photo;

  const UserModel({required this.id, this.name, this.email, this.photo});

  static const empty = UserModel(id: '');

  bool get isEmpty => this == UserModel.empty;

  bool get isNotEmpty => this != UserModel.empty;

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      photo: entity.photo,
    );
  }

  UserEntity toEntity() {
    return UserEntity(id: id, name: name, email: email, photo: photo);
  }

  @override
  List<Object?> get props => [id, name, email, photo];
}
