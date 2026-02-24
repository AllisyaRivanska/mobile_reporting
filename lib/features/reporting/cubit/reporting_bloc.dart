// import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_reporting/features/reporting/cubit/reporting_state.dart';
import 'package:mobile_reporting/features/reporting/model/reporting_model.dart';
// import 'package:mobile_reporting/helper/dio_service.dart';
// import 'package:mobile_reporting/helper/storage.dart';

class ReportingBloc extends Cubit<ReportingState> {
  ReportingBloc() : super(ReportingInitial());
  final List<Data> _localHistory = []; //untuk menampung data

  void submitReporting(Data formData) async {
    // final secureStorage = SecureStorageService();
    // final dio = await DioService.getInstance();

    emit(ReportingLoading());

    try {
      await Future.delayed(const Duration(seconds: 3));

      _localHistory.insert(0, formData);

      // final token = await secureStorage.read('token');

      // final Map<String, dynamic> dataMap = {
      //   'title': formData.title,
      //   'kategori': formData.kategori,
      //   'deskripsi': formData.deskripsi,
      //   'lokasi_kampus_id': 1,
      // };

      

      // if (formData.imagePath != null) {
      //   dataMap['foto'] = await MultipartFile.fromFile(formData.imagePath!);
      // }

      // final formDataPost = FormData.fromMap(dataMap);

      // final response = await dio.post('/report/create', 
      // data: formDataPost, 
      // options: Options(
      //   headers: {
      //   'Authorization': 'Bearer $token',
      //   'Accept': 'application/json',
      // },
      // ),
      // );

      // if (response.statusCode == 200 || response.statusCode == 201) {
      // emit(ReportingSubmitSuccess());
      // } else {
      //   emit(ReportingError('Gagal Mengirim Laporan: ${response.statusCode}'));
      // }
      
        emit(ReportingSubmitSuccess());
        emit(ReportingFetchSuccess(List.from(_localHistory))); //otomatis menambah ke historyPage
      } catch (e) {
        emit(ReportingError('Terjadi Kesalahan: $e'));
      }
     }
    }
