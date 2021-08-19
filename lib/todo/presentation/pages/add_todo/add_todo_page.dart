import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/constants/size.dart';
import 'package:tasky/core/theme/app_theme.dart';
import 'package:tasky/global_widgets/buttons.dart';
import 'package:tasky/core/extensions/datetime_ext.dart';
import 'package:tasky/service_locator.dart';
import 'package:tasky/todo/presentation/pages/add_todo/bloc/add_todo_bloc.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController? titleController = TextEditingController();
  TextEditingController? descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController = null;
    descriptionController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AddTodoBloc>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 40,
            ),
          ),
          title: Text("ADD TASK"),
          centerTitle: true,
        ),
        body: BlocConsumer<AddTodoBloc, AddTodoState>(listener: (context, state) async {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is NavigateBackState) {
            Navigator.pop(context);
          } else if (state is DateTimeDialogState) {
            var date = await showDatePicker(
              context: context,
              initialDate: state.todo.date,
              firstDate: (DateTime.now()),
              lastDate: DateTime.utc(2030),
            );
            if (date == null) {
              return;
            }
            // print(date.toString());
            var time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.fromDateTime(date),
            );
            if (time == null) {
              return;
            }
            BlocProvider.of<AddTodoBloc>(context).add(
              DateChangeEvent(
                  date.getStartOfDay().add(Duration(hours: time.hour, minutes: time.minute))),
            );
          }
        }, builder: (context, state) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: "Title",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        fillColor: Colors.amber,
                        hintText: "Description",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Category",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              Container(
                height: 100,
                child: ListView.builder(
                  itemCount: state.categories.length,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                  itemBuilder: (context, index) {
                    var category = state.categories[index];
                    print(category.toString());
                    return CategoryCard(
                      category.name,
                      category.getColor(),
                      state.todo.category == category.name,
                      () =>
                          BlocProvider.of<AddTodoBloc>(context).add(CategoryChanged(category.name)),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  children: [
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/calendar.svg",
                        color: primaryColor,
                        width: 36,
                        height: 36,
                      ),
                      title: Text(
                        state.todo.date.toPrettyString(withTime: true),
                        style: const TextStyle(fontSize: 20),
                      ),
                      onTap: () => BlocProvider.of<AddTodoBloc>(context).add(DateTimeClickEvent()),
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/icons/notification.svg",
                        color: primaryColor,
                        width: 36,
                        height: 36,
                      ),
                      title: Text(
                        "Notification",
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: Switch(
                        onChanged: (value) =>
                            BlocProvider.of<AddTodoBloc>(context).add(NotificationChanged(value)),
                        value: state.todo.notification,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 104),
              Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.fromLTRB(48, 16, 48, 24),
                child: PrimaryButton(
                  "ADD TASK",
                  primaryColor,
                  () => BlocProvider.of<AddTodoBloc>(context).add(AddTodoClickEvent(
                      titleController?.text ?? "", descriptionController?.text ?? "")),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String category;
  final Color color;
  final bool selected;
  final Function onClick;

  const CategoryCard(
    this.category,
    this.color,
    this.selected,
    this.onClick, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        width: 120,
        height: 80,
        margin: const EdgeInsets.only(bottom: 20, right: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black54.withOpacity(0.17), offset: Offset(4, 4), blurRadius: 8),
          ],
        ),
        child: Stack(
          children: [
            if (selected)
              Positioned(
                left: 0,
                right: 0,
                top: 4,
                child: Icon(Icons.done_rounded, color: Colors.white, size: 36),
              ),
            Positioned(
              child: Text(
                category,
                style: const TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              bottom: 16,
              left: 0,
              right: 0,
            ),
          ],
        ),
      ),
    );
  }
}
