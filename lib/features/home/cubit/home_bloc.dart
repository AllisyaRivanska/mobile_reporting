import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_reporting/features/home/cubit/home_state.dart';
import 'package:mobile_reporting/repository/home/home_repo.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeInitial());

  void getHome() async {
    emit(HomeLoading());

    final response = await HomeRepository().loadHome();
    response.fold(
      (l) => emit(HomeError(l)),
      (r) => emit(HomeLoaded(r.data!)),
    );
  }
}