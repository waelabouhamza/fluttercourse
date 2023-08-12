import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/components/custombuttonauth.dart';
import 'package:fluttercourse/components/customtextfieldadd.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");

  bool isLoading = false;

  addCategory() async {
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        DocumentReference response = await categories.add(
            {"name": name.text, "id": FirebaseAuth.instance.currentUser!.uid});

        Navigator.of(context)
            .pushNamedAndRemoveUntil("homepage", (route) => false);
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
    name.dispose() ; 
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Category")),
      body: Form(
        key: formState,
        child:isLoading ? Center(child: CircularProgressIndicator())  : Column(children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: CustomTextFormAdd(
                hinttext: "Enter Name",
                mycontroller: name,
                validator: (val) {
                  if (val == "") {
                    return "Can't To be Empty";
                  }
                }),
          ),
          CustomButtonAuth(
            title: "Add",
            onPressed: () {
              addCategory();
            },
          )
        ]),
      ),
    );
  }
}
