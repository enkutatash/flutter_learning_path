import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/failure/failure.dart';
import 'package:ecommerce/features/auth/domain/entity/user_entity.dart';
import 'package:ecommerce/features/auth/domain/repository/auth_repository.dart';

class Register {
  final AuthRepository repository;

  Register({required this.repository});

  Future<Either<Failure,UserEntity>> call(UserEntity user) async {
    return await repository.register(user);
  }
}