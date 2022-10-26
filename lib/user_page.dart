import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:firebase_crud/model/user.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerDate = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Add User'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: controllerName,
              // decoration: decoration('Name'),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controllerAge,
              // decoration: decoration('Age'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controllerDate,
            ),
            // DateTimeField(
            //     decoration: const InputDecoration(
            //         hintText: 'Please select your birthday date and time'),
            //     selectedDate: DateTime.now(),
            //     onDateSelected: (DateTime value) {
            //       setState(() {
            //         // selectedDate = value;
            //       });
            //     }),
            // DateTimeField(
            //     controller: controllerDate,
            //   decoration decoration('Birthday'),
            //   format:DateFormat('yyyy-MM-dd'),
            //   onShowPicker: (context, currentValue)=>
            //     context: context,
            //     firstDate: DateTime(1900),
            //     lastDate: DateTime(2100),
            //     initialDate : currentDate?? DateTime.now()
            // ),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: () {
                  final user = User(
                    name: controllerName.text,
                    age: int.parse(controllerAge.text),
                    birthday: DateTime.parse(controllerDate.text),
                  );
                  createUser(user);
                  Navigator.pop(context);
                },
                child: const Text('Create'))
          ],
        ),
      );

  Future createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}
