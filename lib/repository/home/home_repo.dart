import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mobile_reporting/features/home/model/home_model.dart';

class HomeRepository {
  final dio = Dio();
  
  Future<Either<String, HomeModel>> loadHome() async {
    try {
      final response = await dio.get('/reports');

      if (response.statusCode == 200) {
        final home = HomeModel.fromJson(response.data);
        return Right(home);
      }else {
        return Left('Terjadi Kesalahan: ${response.statusMessage}');
      }

      } catch (e) {
      return Left(e.toString());
      }
  }
}
