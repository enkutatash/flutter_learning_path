import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/constants/constants.dart';
import 'package:ecommerce/core/failure/failure.dart';
import 'package:ecommerce/features/auth/data_layer/data_source/remote_abstract.dart';
import 'package:ecommerce/features/auth/data_layer/model/user_model.dart';

class RemoteDataSourceUser extends RemoteAbstract {
  Dio dio;
  RemoteDataSourceUser({required this.dio});

  @override
  Future<Either<Failure, UserModel>> register(UserModel user) async {
    try {
      Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
      );
      final usermodel = user.toJson();
      final response = await dio.post(
        '$authKey/auth/register',
        data: usermodel,
        options: options,
      );
      if (response.statusCode == 201) {
        final responseData = response.data;
        final newUser = UserModel.fromJson(responseData);
        return Right(newUser);
      } else {
        return Left(Failure(message: 'Failed to register user'));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getToken(
      String email, String password) async {
    try {
      Options options = Options(
        contentType: Headers.formUrlEncodedContentType,
      );
      final data = {
        'email': email,
        'password': password,
      };
      final response =
          await dio.post('$authKey/auth/login', data: data, options: options);
      if (response.statusCode == 201) {
        final responseData = response.data;
        final userToken = responseData['access_token'];
        return Right(userToken);
      } else {
        return Left(Failure(message: 'Failed to get token'));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUser(String token) async {
    try {
      Options options = Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      final response =
          await dio.get('$authKey/users/me',options: options);
      if (response.statusCode == 200) {
        final responseData = response.data;
        final user = UserModel.fromJson(responseData);
        return Right(user);
      } else {
        return Left(Failure(message: 'Failed to get user'));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
