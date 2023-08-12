import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/components/custombuttonauth.dart';
import 'package:fluttercourse/components/customtextfieldadd.dart';
import 'package:fluttercourse/note/view.dart';

class AddNote extends StatefulWidget {
  final String docid;
  const AddNote({super.key, required this.docid});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController note = TextEditingController();

  bool isLoading = false;

  addNote() async {
    CollectionReference collectionnote = FirebaseFirestore.instance
        .collection("categories")
        .doc(widget.docid)
        .collection("note");
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        DocumentReference response =
            await collectionnote.add({"note": note.text});

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NoteView(categoryid: widget.docid)));
      } catch (e) {
        isLoading = false;
        setState(() {});
        print("Error $e ");
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    note.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
      body: Form(
        key: formState,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: CustomTextFormAdd(
                      hinttext: "Enter Your Note",
                      mycontroller: note,
                      validator: (val) {
                        if (val == "") {
                          return "Can't To be Empty";
                        }
                      }),
                ),
                CustomButtonAuth(
                  title: "Add",
                  onPressed: () {
                    addNote();
                  },
                )
              ]),
      ),
    );
  }
}
