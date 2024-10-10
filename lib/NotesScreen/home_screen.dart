import 'package:flutter/material.dart';
import 'package:notes_app/NotesScreen/notes_view.dart';
import 'package:notes_app/NotesScreen/todo_view.dart';
import 'package:notes_app/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int currentbottomindex = 0;
List<Widget> pages = [const NotesViewScreen(), const TodoViewScreen()];

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Appcolors.uibuttons,
          unselectedItemColor: Colors.black,
          elevation: 0,
          iconSize: 26,
          currentIndex: currentbottomindex,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            currentbottomindex = value;

            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.notes), label: 'Notes'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle_outline_outlined,
                ),
                label: 'To-dos')
          ]),
      body: pages[currentbottomindex],
    );
  }
}
