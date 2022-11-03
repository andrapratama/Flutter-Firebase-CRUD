// ignore_for_file: sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/models/user.dart';
import 'package:firebase_crud/views/user_page_add.dart';
import 'package:firebase_crud/views/user_page_edit.dart';
import 'package:flutter/material.dart';

class UserPageList extends StatefulWidget {
  const UserPageList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserPageListState();
}

class _UserPageListState extends State<UserPageList> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('All Users'),
        ),
        body: StreamBuilder<List<User>>(
          stream: readUsers(),
          builder: (context, snapsot) {
            if (snapsot.hasError) {
              return Text('Something went wrong! ${snapsot.error}');
            } else if (snapsot.hasData) {
              final users = snapsot.data!;
              return ListView(
                children: users.map(buildUser).toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const UserPage(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      );

  Widget buildUser(User user) => ListTile(
        leading: CircleAvatar(
          child: Text('${user.age}'),
        ),
        title: Text(user.name),
        subtitle: Text(user.birthday.toIso8601String()),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => UserPageEdit(
                            id: user.id,
                            name: user.name,
                            age: user.age,
                            birthday: user.birthday.toIso8601String()),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    AlertDialog delete = AlertDialog(
                      title: const Text("Information"),
                      content: Container(
                        height: 100,
                        child: Column(
                          children: [
                            Text("Are you sure for deleting ${user.name}")
                          ],
                        ),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              final docUser = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.id);
                              docUser.delete();
                              Navigator.pop(context);
                            },
                            child: const Text("Yes")),
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                    showDialog(context: context, builder: (context) => delete);
                  },
                  icon: const Icon(Icons.delete)),
            ],
          ),
        ),
      );

  Stream<List<User>> readUsers() => FirebaseFirestore.instance
      .collection('users')
      .snapshots()
      .map((snapsot) =>
          snapsot.docs.map((doc) => User.fromJson(doc.data())).toList());
}
