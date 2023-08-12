import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart';
import 'package:fluttercourse/components/custombuttonauth.dart';
import 'package:fluttercourse/components/customtextfieldadd.dart';

class EditCategory extends StatefulWidget {
  final String docid;
  final String oldname;
  const EditCategory({super.key, required this.docid, required this.oldname});

  @override
  State<EditCategory> createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();

  CollectionReference categories =
      FirebaseFirestore.instance.collection("categories");

  bool isLoading = false;

  editCategory() async {
    if (formState.currentState!.validate()) {
      try {
        isLoading = true;
        setState(() {});
        await categories.doc(widget.docid).update({"name": name.text});

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
  void initState() {
    super.initState();
    name.text = widget.oldname;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Category")),
      body: Form(
        key: formState,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(children: [
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
                  title: "Save",
                  onPressed: () {
                    editCategory();
                  },
                )
              ]),
      ),
    );
  }
}
 

//  Set = Add  ============> Set Docid 
//  Set = Update  {
//  Merge = FALSE => Field Delete 
//  Merge = True  =>  Update Normal
// 
// }