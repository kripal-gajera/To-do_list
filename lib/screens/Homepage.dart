import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do/screens/add_note.dart';
import 'package:intl/intl.dart';
import 'package:to_do/Function.dart';
import 'package:to_do/screens/update_note.dart';

bool complete = false;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CollectionReference firestore =
      FirebaseFirestore.instance.collection("task");

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var formatter1 = DateFormat("EEEEE,").format(DateTime.now());
    var formatter2 = DateFormat("dd MMM").format(DateTime.now());

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
        child: Column(children: [
          Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatter1,
                  style: GoogleFonts.robotoMono(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                Text(
                  formatter2,
                  style: GoogleFonts.quicksand(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(right: 10.0, left: 10.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Column(
          //         children: [
          //           Text(
          //             "Created Task",
          //             style: TextStyle(fontSize: 15, color: Colors.grey),
          //           ),
          //         ],
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       ),
          //       Column(
          //         children: [
          //           Text(
          //             "Completed Task",
          //             style: TextStyle(fontSize: 15, color: Colors.grey),
          //           ),
          //         ],
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       ),
          //     ],
          //   ),
          // ),
          Expanded(
            child: Container(
              height: h - 165,
              child: StreamBuilder(
                stream: firestore.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Data not available');
                  } else if (snapshot.hasError) {
                    return const Text('Error occurred');
                  } else if (snapshot.hasData) {
                    {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot data =
                              snapshot.data!.docs[index];
                          bool like = data['complete'];
                          return Column(
                            children: [
                              ListTile(
                                leading: InkWell(
                                  onTap: () {
                                    like = !like;
                                    if (like == true) {
                                      FirebaseDatabaseClass.updateStatus(
                                        id: data.id,
                                        status: true,
                                      );
                                      Fluttertoast.showToast(
                                          msg: "task is completed",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.orangeAccent,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      FirebaseDatabaseClass.updateStatus(
                                        id: data.id,
                                        status: false,
                                      );
                                      Fluttertoast.showToast(
                                          msg: "task is Unmark",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.check_circle_outline,
                                    color: like ? Colors.red : Colors.blueGrey,
                                  ),
                                ),
                                title: Text(
                                  data['data'].toString(),
                                  style: GoogleFonts.comfortaa(
                                      decoration: like
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Container(
                                  width: w * 0.20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        child: Icon(
                                          Icons.edit,
                                          color: Colors.black38,
                                        ),
                                        onTap: () async {
                                          controller1.clear();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateNotePage(
                                                          id: data.id)));
                                        },
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          AwesomeDialog(
                                              context: context,
                                              title: "Warning",
                                              body: const Text(
                                                  "Are you sure you want to delete the task?"),
                                              dialogType: DialogType.WARNING,
                                              animType: AnimType.BOTTOMSLIDE,
                                              btnCancelOnPress: () {
                                                //Navigator.of(context).pop();
                                              },
                                              btnOkOnPress: () async {
                                                await FirebaseDatabaseClass
                                                    .deleteData(id: data.id);
                                                Fluttertoast.showToast(
                                                    msg: "Task Is delete",
                                                    fontSize: 18,
                                                    backgroundColor:
                                                        Colors.red);
                                                //Navigator.of(context).pop();
                                              }).show();
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNotePage()),
          );
          setState(() {
            controller.clear();
          });
        },
        elevation: 10.0,
        backgroundColor: Colors.greenAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
