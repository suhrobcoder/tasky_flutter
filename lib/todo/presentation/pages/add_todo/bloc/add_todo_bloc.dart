import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/domain/entity/todo_entity.dart';
import 'package:tasky/todo/domain/usecase/add_todo.dart';
import 'package:tasky/todo/domain/usecase/get_categories.dart';

part 'add_todo_event.dart';
part 'add_todo_state.dart';

@injectable
class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  final GetCategories getCategories;
  final AddTodo addTodo;

  AddTodoBloc(this.getCategories, this.addTodo)
      : super(InitialState(
          todo: TodoEntity(
              id: 0,
              title: "",
              description: "",
              category: "",
              date: DateTime.now(),
              notification: false,
              priorityHigh: false,
              done: false),
          categories: const [],
        )) {
    on<CategoryChanged>((event, emit) {
      emit(state.copyWith(todo: state.todo.copyWith(category: event.category)));
    });
    on<DateChangeEvent>((event, emit) {
      emit(state.copyWith(todo: state.todo.copyWith(date: event.date)));
    });
    on<NotificationChanged>((event, emit) {
      emit(state.copyWith(
          todo: state.todo.copyWith(notification: event.notification)));
    });
    on<DateTimeClickEvent>((event, emit) {
      emit(state.getDateTimeDialogState());
      emit(state.copyWith());
    });
    on<AddTodoClickEvent>((event, emit) async {
      if (event.title.isEmpty) {
        emit(state.getErrorState("Title cannot be empty"));
      } else {
        var todo = state.todo
            .copyWith(title: event.title, description: event.description);
        try {
          await addTodo.execute(todo);
          emit(state.getNavigateBackState());
        } catch (error) {
          emit(state.getErrorState("$error"));
        }
      }
    });
    on<_CategoriesEvent>((event, emit) {
      emit(state.copyWith(
          todo: state.todo.copyWith(category: event.categories[0].name),
          categories: event.categories));
    });
    getCategories.execute().listen((categories) {
      add(_CategoriesEvent(categories));
    });
  }
}

class _CategoriesEvent extends AddTodoEvent {
  final List<CategoryEntity> categories;

  const _CategoriesEvent(this.categories);
}
