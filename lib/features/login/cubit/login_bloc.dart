import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:mobile_reporting/features/login/model/login_model.dart';
import 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc() : super(LoginInitial());

  final Dio dio = Dio();

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    try {
      
      //=========NANTI KALO API HIDUP=============
      
      // final response = await dio.post(
      //   'https://api-example.com/login',
      //   data: {
      //     'email': email,
      //     'password': password,
      //   },
      // );

      // final result = LoginModel.fromJson(response.data);
      //

      // Dummy duls
      final dummyResponse = {
        "success": true,
        "message": "Login berhasil",
        "data": {
          "access_token": "dummy_token",
          "token_type": "Bearer",
          "user": {
            "id": 1,
            "name": "Mahasiswa gothic",
            "pasword": "melankolis123",
            "email": email,
            "role": "mahasiswa"
          }
        }
      };

      final result = LoginModel.fromJson(dummyResponse);

      emit(LoginSuccess(result));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
