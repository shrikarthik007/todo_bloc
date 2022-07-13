part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  final String? error;
  HomeInitial({this.error});
  @override
  List<Object?> get props => [error];
}

class SuccessfullLoginState extends HomeState {
  final String userName;

  SuccessfullLoginState(this.userName);
  @override
  // TODO: implement props
  List<Object?> get props => [userName];
}

class RegisteringServicesState extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
