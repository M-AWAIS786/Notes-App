import 'package:flutter/material.dart';
import 'package:notes_app/constants/app_colors.dart';
import 'package:notes_app/constants/app_styles.dart';

import '../DB helper/local data/dbhelper.dart';

class NotesDetailScreen extends StatefulWidget {
  const NotesDetailScreen({super.key, this.mdata, this.pindex});

  // NotesDetailScreen({super.key});
  final List<Map<String, dynamic>>? mdata;
  final int? pindex;

  @override
  State<NotesDetailScreen> createState() => _NotesDetailScreenState();
}

class _NotesDetailScreenState extends State<NotesDetailScreen> {
  late TextEditingController textTitle;
  late TextEditingController textDesc;

  DBhelper? dBhelper;
  int? selectedbottomindex;
  @override
  void initState() {
    super.initState();
    dBhelper = DBhelper.getInstance;
    textTitle = TextEditingController();
    textDesc = TextEditingController();
    checkPassData();
  }

  void checkPassData() {
    if (widget.mdata == null || widget.pindex == null) {
      textTitle.text = '';
      textDesc.text = '';
    } else {
      textTitle.text =
          widget.mdata![widget.pindex!][DBhelper.COLUMN_NOTES_TITLE];
      textDesc.text =
          widget.mdata![widget.pindex!][DBhelper.COLUMN_NOTES_DESCRIPTION];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            elevation: 0,
            iconSize: 26,
            currentIndex: 0,
            onTap: (value) {
              setState(() {
                selectedbottomindex = value;
                // print(selectedbottomindex);
              });
            },
            items: const [
              BottomNavigationBarItem(
                  label: 'Albums',
                  icon: Icon(Icons.image_outlined, color: Colors.black)),
              BottomNavigationBarItem(
                  label: 'To-do list',
                  icon: Icon(Icons.check_circle_outline, color: Colors.black)),
              BottomNavigationBarItem(
                  label: 'Reminder',
                  icon: Icon(Icons.notifications_none_rounded,
                      color: Colors.black)),
            ]),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Notes',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            color: Appcolors.uibuttons,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  if (textTitle.text.isEmpty || textDesc.text.isEmpty) {
                    return;
                  }

                  if (widget.pindex == null) {
                    await dBhelper!
                        .addNote(title: textTitle.text, des: textDesc.text);
                  } else {
                    int noteId =
                        widget.mdata![widget.pindex!][DBhelper.COLUMN_NOTES_ID];

                    await dBhelper!.updateNote(
                        id: noteId, title: textTitle.text, des: textDesc.text);
                    // await dBhelper!.getAllNotes();
                  }
                  if (mounted) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, true);
                  }
                },
                icon: const Icon(Icons.check,
                    color: Appcolors.uibuttons, size: 30)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: textTitle,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Title',
                      hintStyle: AppStyles.subtitle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                TextField(
                  controller: textDesc,
                  maxLines: 10,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Note something down',
                      hintStyle: AppStyles.subtitle()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
