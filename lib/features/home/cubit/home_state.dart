import 'package:equatable/equatable.dart';
import 'package:mobile_reporting/features/home/model/home_model.dart';

class HomeState extends Equatable {
  @override 
  List<Object?> get props => [];
}

  class HomeInitial extends HomeState {}

  class HomeLoading extends HomeState {}

  class HomeLoaded extends HomeState {
    final List<Data> home;

    HomeLoaded(this.home);

    @override
    List<Object?> get props => [home];

  }

  class HomeError extends HomeState {
    final String message;

    HomeError(this.message);

    @override
     List<Object?> get props => [message];
  }
