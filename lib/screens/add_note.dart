import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do/Function.dart';

TextEditingController controller = TextEditingController();
bool complete = false;

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Note",
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  cursorColor: Colors.greenAccent,
                  decoration: InputDecoration(
                    hintText: "Add your task",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.greenAccent,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: w / 2.3,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.greenAccent,
                          ),
                          child: Center(
                              child: Text(
                            "Cancle",
                            style: TextStyle(fontSize: 20),
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          FirebaseDatabaseClass.addData();
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Task Added",
                              fontSize: 18,
                              backgroundColor: Colors.green);
                        },
                        child: Container(
                          width: w / 2.3,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.greenAccent,
                          ),
                          child: Center(
                              child: Text(
                            "Save",
                            style: TextStyle(fontSize: 20),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
