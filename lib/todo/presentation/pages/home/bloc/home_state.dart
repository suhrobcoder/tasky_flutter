part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final int pageIndex;
  final CategoryEntity? category;

  const HomeState(this.pageIndex, {this.category});

  @override
  List<Object> get props => [pageIndex];
}

class HomeInitial extends HomeState {
  const HomeInitial(int pageIndex, {CategoryEntity? category})
      : super(pageIndex, category: category);
}
