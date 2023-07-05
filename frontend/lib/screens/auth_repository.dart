import 'package:dio/dio.dart';
import 'package:frontend/models/user_model.dart';

class AuthRepository {
  late final Dio dio;

  Future<UserModel?> login(String email, String password) async {
    final Response response = await dio.post('http://10.0.2.2:3000/auth/login',
        data: {'email': email, 'password': password});
    if (response.data == null) {
      return null;
    } else {
      return UserModel.fromMap(response.data);
    }
  }
}
