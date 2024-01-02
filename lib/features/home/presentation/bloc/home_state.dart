part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({this.tab = HomeTab.schedule});

  final HomeTab tab;

  @override
  List<Object?> get props => [tab];
}
