part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  HomeInitial();
  @override
  List<Object?> get props => [];
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
