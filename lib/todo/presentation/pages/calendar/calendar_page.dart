import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tasky/core/constants/size.dart';
import 'package:tasky/core/theme/app_theme.dart';
import 'package:tasky/di/init_get_it.dart';
import 'package:tasky/todo/domain/entity/category_entity.dart';
import 'package:tasky/todo/presentation/pages/calendar/bloc/calendar_bloc.dart';
import 'package:tasky/todo/presentation/pages/home/bloc/home_bloc.dart';
import 'package:tasky/todo/presentation/widgets/progress_widget.dart';
import 'package:tasky/core/extensions/datetime_ext.dart';
import 'package:tasky/todo/presentation/widgets/todo_item.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CalendarBloc>(),
      child: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, homeState) {
            BlocProvider.of<CalendarBloc>(context)
                .add(InitialEvent(homeState.category));
            return BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (homeState.category != null)
                            CategoryHeader(homeState.category!),
                          const SizedBox(height: 32),
                          TaskyCalendar(
                            events: state.todos
                                .where((e) => e.todos.any((el) => !el.done))
                                .map((e) => e.dateTime)
                                .toList(),
                            selectedDate: state.selectedDate,
                            onDateSelected: (date) =>
                                BlocProvider.of<CalendarBloc>(context)
                                    .add(DateSelected(date)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: ScrollController(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding),
                        itemCount: state.todos.length,
                        itemBuilder: (context, index) {
                          var todosByDate = state.todos[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  todosByDate.dateTime.toPrettyString(),
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.black87),
                                ),
                              ),
                              ...todosByDate.todos
                                  .map(
                                    (todo) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: TodoItem(
                                        title: todo.title,
                                        subtitle: todo.description,
                                        done: todo.done,
                                        date: todo.date,
                                        onClick: () =>
                                            BlocProvider.of<CalendarBloc>(
                                                    context)
                                                .add(TodoClickEvent(todo)),
                                        onClickDelete: () =>
                                            BlocProvider.of<CalendarBloc>(
                                                    context)
                                                .add(DeleteTodoEvent(todo)),
                                        onClickComplete: () =>
                                            BlocProvider.of<CalendarBloc>(
                                                    context)
                                                .add(CompleteTodoEvent(todo)),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CategoryHeader extends StatelessWidget {
  final CategoryEntity category;
  const CategoryHeader(this.category, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category.name,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(height: 8),
          Text(
            "${category.doneTasks}/${category.allTasks} tasks completed",
            style: const TextStyle(fontSize: 16, color: subtitleTextColor),
          ),
          const SizedBox(height: 16),
          ProgressWidget(
            color: category.getColor(),
            progress: category.allTasks == 0
                ? 0
                : category.doneTasks / category.allTasks,
            size: const Size(200, 8),
          ),
        ],
      ),
    );
  }
}

class TaskyCalendar extends StatefulWidget {
  final List<DateTime> events;
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  const TaskyCalendar({
    required this.events,
    required this.selectedDate,
    required this.onDateSelected,
    Key? key,
  }) : super(key: key);

  @override
  TaskyCalendarState createState() => TaskyCalendarState();
}

class TaskyCalendarState extends State<TaskyCalendar> {
  var calendarFormat = CalendarFormat.week;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 1, 1),
      selectedDayPredicate: (day) => day.isSameDayWith(widget.selectedDate),
      eventLoader: (day) {
        for (var event in widget.events) {
          if (day.isSameDayWith(event)) {
            return ["Event"];
          }
        }
        return [];
      },
      onDaySelected: (day, __) => widget.onDateSelected(day),
      calendarFormat: calendarFormat,
      onFormatChanged: (format) => setState(() => calendarFormat = format),
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
        CalendarFormat.week: 'Week',
      },
      calendarStyle: const CalendarStyle(
        markersAnchor: 1,
        markerSize: 5,
        markerDecoration:
            BoxDecoration(color: primaryColor, shape: BoxShape.circle),
        selectedDecoration:
            BoxDecoration(color: primaryColor, shape: BoxShape.circle),
      ),
    );
  }
}
