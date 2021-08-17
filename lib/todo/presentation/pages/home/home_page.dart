import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/routes/routes.dart';
import 'package:tasky/core/theme/app_theme.dart';
import 'package:tasky/todo/presentation/pages/calendar/calendar_page.dart';
import 'package:tasky/todo/presentation/pages/home_todo_list/home_todo_list_page.dart';

import '../../../../service_locator.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: IndexedStack(
                        index: state.pageIndex,
                        children: const [
                          HomeTodoListPage(),
                          CalendarPage(),
                          Center(child: Text("Notifications")),
                          Center(child: Text("Profile")),
                        ],
                      ),
                    ),
                    const SizedBox(height: 56),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: HomeBottomNavBar(
                    onSelect: (index) =>
                        BlocProvider.of<HomeBloc>(context).add(PageSelectEvent(index)),
                    onAddClick: () => Navigator.pushNamed(context, newTaskPage),
                    selectedIndex: state.pageIndex,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HomeBottomNavBar extends StatelessWidget {
  final Function(int) onSelect;
  final Function onAddClick;
  final int selectedIndex;
  const HomeBottomNavBar(
      {required this.onSelect, required this.onAddClick, required this.selectedIndex, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 56,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              HomeBottomNavBarItem("home", selectedIndex == 0, () => onSelect(0)),
              HomeBottomNavBarItem("calendar", selectedIndex == 1, () => onSelect(1)),
              AddButton(() => onAddClick()),
              HomeBottomNavBarItem("notification", selectedIndex == 2, () => onSelect(2)),
              HomeBottomNavBarItem("profile", selectedIndex == 3, () => onSelect(3)),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeBottomNavBarItem extends StatelessWidget {
  final String icon;
  final bool selected;
  final Function onClick;
  const HomeBottomNavBarItem(this.icon, this.selected, this.onClick, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onClick(),
      icon: SvgPicture.asset(
        "assets/icons/$icon.svg",
        width: 36,
        height: 36,
        color: selected ? Theme.of(context).primaryColor : lightGrey,
      ),
      iconSize: 36,
      color: selected ? Theme.of(context).primaryColor : lightGrey,
      splashRadius: 48,
    );
  }
}

class AddButton extends StatelessWidget {
  final Function onClick;
  const AddButton(this.onClick, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, -4),
            color: Color(0x5500E1B5),
            blurRadius: 5,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onClick(),
          borderRadius: BorderRadius.circular(36.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              "assets/icons/plus.svg",
              height: 48,
              width: 48,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
