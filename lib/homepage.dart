// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/categories/edit.dart';
import 'package:fluttercourse/note/view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<QueryDocumentSnapshot> data = [];

  bool isLoading = true;

  getData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("categories")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    data.addAll(querySnapshot.docs);
    isLoading = false;

    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            Navigator.of(context).pushNamed("addcategory");
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text('Homepage'),
          actions: [
            IconButton(
                onPressed: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  googleSignIn.disconnect();
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                },
                icon: Icon(Icons.exit_to_app))
          ],
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : GridView.builder(
                itemCount: data.length, // 3
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 160),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              NoteView(categoryid: data[i].id)));
                    },
                    onLongPress: () {
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.warning,
                          animType: AnimType.rightSlide,
                          title: 'Error',
                          desc: "اختر ماذا تريد",
                          btnCancelText: "حذف",
                          btnOkText: "تعديل",
                          btnCancelOnPress: () async {
                            await FirebaseFirestore.instance
                                .collection("categories")
                                .doc(data[i].id)
                                .delete();
                            Navigator.of(context)
                                .pushReplacementNamed("homepage");
                          },
                          btnOkOnPress: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditCategory(
                                    docid: data[i].id,
                                    oldname: data[i]['name'])));
                          }).show();
                    },
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          Image.asset(
                            "images/folder.png",
                            height: 100,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${data[i]['name']}"),
                            ],
                          )
                        ]),
                      ),
                    ),
                  );
                },
              ));
  }
}
