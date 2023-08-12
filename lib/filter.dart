import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilterFirestore extends StatefulWidget {
  const FilterFirestore({super.key});

  @override
  State<FilterFirestore> createState() => _FilterFirestoreState();
}

class _FilterFirestoreState extends State<FilterFirestore> {
  final Stream<QuerySnapshot> usersstream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
              stream: usersstream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("Error");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading ....");
                }
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          DocumentReference documentReference =
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(snapshot.data!.docs[index].id);

                          FirebaseFirestore.instance
                              .runTransaction((transaction) async {
                            DocumentSnapshot snapshot =
                                await transaction.get(documentReference);

                            if (snapshot.exists) {
                              var snapshotData = snapshot.data();

                              if (snapshotData is Map<String, dynamic>) {
                                int money = snapshotData['money'] + 100;

                                transaction.update(
                                    documentReference, {"money": money});
                              }
                            }
                          }) ; 
                        },
                        child: Card(
                            child: ListTile(
                                trailing: Text(
                                    "${snapshot.data!.docs[index]['money']}\$"),
                                subtitle: Text(
                                    "${snapshot.data!.docs[index]['age']}"),
                                title: Text(
                                    "${snapshot.data!.docs[index]['username']}"))),
                      );
                    });
              })),
    );
  }
}
