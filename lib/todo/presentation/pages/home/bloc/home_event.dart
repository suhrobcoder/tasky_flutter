part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  final List<dynamic> props;

  const HomeEvent([this.props = const <dynamic>[]]);
}

class PageSelectEvent extends HomeEvent {
  final int index;

  PageSelectEvent(this.index) : super([index]);
}

class CategorySelectEvent extends HomeEvent {
  final CategoryEntity category;

  CategorySelectEvent(this.category) : super([category]);
}
