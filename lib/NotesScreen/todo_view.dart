import 'package:flutter/material.dart';
import 'package:notes_app/constants/app_colors.dart';
import 'package:notes_app/constants/app_styles.dart';

class TodoViewScreen extends StatefulWidget {
  const TodoViewScreen({super.key});

  @override
  State<TodoViewScreen> createState() => _TodoViewScreenState();
}

bool deletebuttonshow = false;
TextEditingController? todoitemscontroller;

class _TodoViewScreenState extends State<TodoViewScreen> {
  @override
  void initState() {
    super.initState();
    todoitemscontroller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Appcolors.uibuttons,
          foregroundColor: Appcolors.white,
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              elevation: 6,
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  width: double.infinity,
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextField(
                          controller: todoitemscontroller,
                          decoration: InputDecoration(
                            fillColor: Colors.black.withOpacity(0.04),
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Add a to-do item',
                            hintStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black.withOpacity(0.04),
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () {},
                            icon: const Icon(Icons.alarm, color: Colors.grey),
                            label: const Text(
                              'Set alerts',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.grey),
                              child: const Text('SAVE',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)))
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add, size: 30),
        ),
        appBar: deletebuttonshow == false
            ? AppBar(
                backgroundColor: Colors.white,
              )
            : appbarNotesView(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'To-dos',
                style: AppStyles.h1(),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                // ! search keywods
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(8),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: Colors.black.withOpacity(0.04),
                    filled: true,
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    hintText: 'Search notes',
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  // final noteId = mdata[index][DBhelper.COLUMN_NOTES_ID];
                  return Card(
                    // color: Colors.black.withOpacity(0.04),
                    child: ListTile(
                        leading: const Icon(
                          Icons.circle_outlined,
                          color: Colors.grey,
                          size: 18,
                        ),
                        title: const Text('heelo'),
                        // ! problem in showing the checkboxes
                        trailing: deletebuttonshow == true
                            ? const Icon(
                                Icons.check_box,
                                color: Colors.green,
                              )
                            : null,
                        // : null,
                        onLongPress: () {
                          deletebuttonshow = true;
                          // selectedItems.add(noteId);
                          setState(() {});
                        },
                        onTap: deletebuttonshow ? () {} : null),
                  );
                },
              ),
            ],
          ),
        ));
  }

  AppBar appbarNotesView() {
    return AppBar(
      backgroundColor: Colors.white,
      title:
          // selectedItems.isEmpty
          //     ?
          const Text(
        'Please select items',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      ),
      // : selectedItems.length > 1
      //     ? Text("${selectedItems.length} items selected",
      //         style: AppStyles.h3())
      //     : Text("${selectedItems.length} item selected",
      //         style: AppStyles.h3()),
      leading: IconButton(
        color: Colors.green,
        icon: const Icon(Icons.close_sharp, size: 30),
        onPressed: () {
          deletebuttonshow = false;
          // selectedItems = [];
          setState(() {});
        },
      ),
      actions: [
        IconButton(
            onPressed: () {
              // dBhelper!.deleteNote(id: selectedItems);
              deletebuttonshow = false;
              // selectedItems = [];
              // allnotes();
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
