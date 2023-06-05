import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/constants/size.dart';
import 'package:tasky/di/init_get_it.dart';
import 'package:tasky/todo/presentation/pages/home/bloc/home_bloc.dart';
import 'package:tasky/todo/presentation/pages/home_todo_list/bloc/hometodolist_bloc.dart';
import 'package:tasky/todo/presentation/widgets/category_card.dart';
import 'package:tasky/todo/presentation/widgets/new_category_dialog.dart';
import 'package:tasky/todo/presentation/widgets/todo_dialog.dart';
import 'package:tasky/todo/presentation/widgets/todo_item.dart';

class HomeTodoListPage extends StatelessWidget {
  const HomeTodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => getIt<HomeTodoListBloc>(),
        child: BlocConsumer<HomeTodoListBloc, HomeTodoListState>(
          listener: (context, state) {
            if (state is ShowNewCategoryDialogState) {
              showDialog(
                context: context,
                builder: (_) => NewCategoryDialog(
                  onCancelClick: () {
                    Navigator.pop(context);
                  },
                  onOkClick: (category) {
                    BlocProvider.of<HomeTodoListBloc>(context)
                        .add(AddCategoryEvent(category));
                    Navigator.pop(context);
                  },
                ),
              );
            } else if (state is ShowTodoDialogState) {
              showDialog(
                  context: context,
                  builder: (_) {
                    return TodoDialog(
                      todo: state.todo,
                      onComplete: () =>
                          BlocProvider.of<HomeTodoListBloc>(context)
                              .add(CompleteTodoEvent(state.todo)),
                    );
                  });
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                        onPressed: () =>
                            BlocProvider.of<HomeTodoListBloc>(context)
                                .add(NewCategoryClickEvent()),
                        child: const Text("New Category"),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: ListView(
                    padding: const EdgeInsets.only(left: defaultPadding),
                    scrollDirection: Axis.horizontal,
                    children: state.categories
                        .map(
                          (category) => CategoryCard(
                            name: category.name,
                            color: category.getColor(),
                            allTasks: category.allTasks,
                            doneTasks: category.doneTasks,
                            onClick: () => BlocProvider.of<HomeBloc>(context)
                                .add(CategorySelectEvent(category)),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(
                      defaultPadding, defaultPadding, 0, defaultPadding / 2),
                  child: Text(
                    "Tasks for today",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                if (state.todos.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Column(
                      children: state.todos
                          .map(
                            (todo) => Padding(
                              padding: const EdgeInsets.only(
                                  bottom: defaultPadding / 2),
                              child: TodoItem(
                                title: todo.title,
                                subtitle: todo.description,
                                done: todo.done,
                                date: todo.date,
                                onClick: () =>
                                    BlocProvider.of<HomeTodoListBloc>(context)
                                        .add(TodoClickEvent(todo)),
                                onClickDelete: () =>
                                    BlocProvider.of<HomeTodoListBloc>(context)
                                        .add(DeleteTodoEvent(todo)),
                                onClickComplete: () =>
                                    BlocProvider.of<HomeTodoListBloc>(context)
                                        .add(CompleteTodoEvent(todo)),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  )
                else
                  const Center(child: Text("No tasks for today")),
              ],
            );
          },
        ),
      ),
    );
  }
}
