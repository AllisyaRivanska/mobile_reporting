import 'package:equatable/equatable.dart';
import 'package:mobile_reporting/features/reporting/model/reporting_model.dart';

abstract class ReportingState extends Equatable {
  @override
  List<Object> get props => [];
}

class ReportingInitial extends ReportingState {}

class ReportingLoading extends ReportingState {}

class ReportingSubmitSuccess extends ReportingState {}

class ReportingFetchSuccess extends ReportingState {
  final List<Data> reporting;

  ReportingFetchSuccess(this.reporting);

  @override
  List<Object> get props => [reporting];
  }
   
  class ReportingError extends ReportingState {
    final String message;

    ReportingError(this.message);

    @override
    List<Object> get props => [message];
}
