import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserPageEdit extends StatefulWidget {
  final String id;
  final String name;
  final int age;
  final String birthday;

  const UserPageEdit(
      {Key? key, required this.id, required this.name, required this.age, required this.birthday})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserPageEditState();
}

class _UserPageEditState extends State<UserPageEdit> {
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  final controllerDate = TextEditingController();

  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Edit User'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
              controller: controllerName..text = widget.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: controllerAge..text = widget.age.toString(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Age',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            DateTimeField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Birthday',
              ),
              format: format,
              controller: controllerDate,
              onShowPicker: (context, currentValue) {
                return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
                onPressed: () {

                },
                child: const Text('Update'))
          ],
        ),
      );
}
