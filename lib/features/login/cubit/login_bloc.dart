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
           

      final dummyResponse = {
        "success": true,
        "message": "Login berhasil",
        "data": {
          "access_token": "dummy_token",
          "token_type": "Bearer",
          "user": {
            "id": 1,
            "name": email,
            "pasword": password,
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
