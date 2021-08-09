part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final int pageIndex;

  const HomeState(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}

class HomeInitial extends HomeState {
  const HomeInitial(int pageIndex, {CategoryEntity? category})
      : super(pageIndex);
}
