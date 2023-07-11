import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do/Function.dart';
import 'package:to_do/screens/add_note.dart';

TextEditingController controller1 =
    TextEditingController(text: controller.text);
bool complete = false;

class UpdateNotePage extends StatefulWidget {
  String id;
  UpdateNotePage({Key? key, required this.id}) : super(key: key);
  @override
  _UpdateNotePageState createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update Note",
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
                  controller: controller1,
                  cursorColor: Colors.greenAccent,
                  decoration: InputDecoration(
                    hintText: controller.text,
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
                          FirebaseDatabaseClass.upedetdata(
                            data: controller1.text,
                            id: widget.id,
                          );
                          setState(() {});
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                              msg: "Task Is updated",
                              fontSize: 18,
                              backgroundColor: Colors.blue);
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
                            "Update",
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
