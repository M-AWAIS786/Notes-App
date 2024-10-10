import 'package:flutter/material.dart';
import 'package:notes_app/NotesScreen/notes_details.dart';
import 'package:notes_app/constants/app_colors.dart';
import 'package:notes_app/constants/app_styles.dart';

import '../DB helper/local data/dbhelper.dart';

class NotesViewScreen extends StatefulWidget {
  const NotesViewScreen({super.key});

  @override
  State<NotesViewScreen> createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NotesViewScreen> {
  DBhelper? dBhelper;
  List<Map<String, dynamic>> mdata = [];
  late int count;
  List<int> selectedItems = [];
  String? searchkeywords;
  TextEditingController? searchcontroller;

  @override
  void initState() {
    super.initState();
    dBhelper = DBhelper.getInstance;
    searchcontroller = TextEditingController();
    allnotes();
  }

  @override
  void dispose() {
    searchcontroller!.dispose();
    super.dispose();
  }

  void allnotes() async {
    mdata = await dBhelper!.getAllNotes();
    setState(() {});
  }

  bool deletebuttonshow = false;
  // List? deleteID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: deletebuttonshow == false
          ? AppBar(
              backgroundColor: Colors.white,
            )
          : appbarNotesView(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Appcolors.uibuttons,
        foregroundColor: Colors.white,
        onPressed: () async {
          bool? result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotesDetailScreen(
                mdata: [],
                pindex: null,
              ),
            ),
          );
          if (result == true) {
            allnotes();
          }
        },
        child: const Icon(Icons.add, size: 30),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Notes',
                style: AppStyles.h1(),
              ),
              const SizedBox(
                height: 20,
              ),
              mdata.isNotEmpty
                  ? SizedBox(
                      height: 40,
                      // ! search keywods
                      child: TextField(
                        controller: searchcontroller,
                        onChanged: (value) {
                          searchkeywords = value;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          fillColor: Colors.black.withOpacity(0.04),
                          filled: true,
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          hintText: 'Search notes',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 16,
              ),
              searchkeywords != null
                  ? FutureBuilder(
                      future: dBhelper!.searchNotes(searchkeywords!),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          mdata = snapshot.data as List<Map<String, dynamic>>;
                          return listNotesData();
                        } else {
                          return const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.note_sharp,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                Text('No notes'),
                              ],
                            ),
                          );
                        }
                      },
                    )
                  : mdata.isNotEmpty
                      ? listNotesData()
                      : const Center(
                          child: SizedBox(
                            height: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('No Data is here'),
                                Icon(
                                  Icons.note_sharp,
                                  size: 50,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  ListView listNotesData() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: mdata.length,
      itemBuilder: (context, index) {
        final noteId = mdata[index][DBhelper.COLUMN_NOTES_ID];
        return Card(
          // color: Colors.black.withOpacity(0.04),
          child: ListTile(
            title: Text(mdata[index][DBhelper.COLUMN_NOTES_TITLE]),
            subtitle: Text(
              mdata[index][DBhelper.COLUMN_NOTES_DESCRIPTION],
              maxLines: 1,
            ),
            // ! problem in showing the checkboxes
            trailing: deletebuttonshow
                ? selectedItems.contains(noteId)
                    ? const Icon(
                        Icons.check_box,
                        color: Colors.green,
                      )
                    : const Icon(Icons.check_box_outline_blank)
                : null,
            onLongPress: () {
              deletebuttonshow = true;
              selectedItems.add(noteId);
              setState(() {});
            },
            onTap: deletebuttonshow
                ? () {
                    if (selectedItems.contains(noteId)) {
                      selectedItems.remove(noteId);
                      setState(() {});
                    } else {
                      selectedItems.add(noteId);
                      setState(() {});
                      // for (var i in selectedItems) {
                      //   print(i);
                      // }
                    }
                  }
                : () async {
                    bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NotesDetailScreen(
                            pindex: index,
                            mdata: mdata,
                          );
                        },
                      ),
                    );
                    if (result == true) {
                      allnotes();
                    }
                  },
          ),
        );
      },
    );
  }

  AppBar appbarNotesView() {
    return AppBar(
      backgroundColor: Colors.white,
      title: selectedItems.isEmpty
          ? const Text(
              'Please select items',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
            )
          : selectedItems.length > 1
              ? Text("${selectedItems.length} items selected",
                  style: AppStyles.h3())
              : Text("${selectedItems.length} item selected",
                  style: AppStyles.h3()),
      leading: IconButton(
        color: Colors.green,
        icon: const Icon(Icons.close_sharp, size: 30),
        onPressed: () {
          deletebuttonshow = false;
          selectedItems = [];
          setState(() {});
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              dBhelper!.deleteNote(id: selectedItems);
              deletebuttonshow = false;
              selectedItems = [];
              allnotes();
              setState(() {});
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check_box_outline_blank,
              color: Colors.grey,
            )),
      ],
    );
  }
}
