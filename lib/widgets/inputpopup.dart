import 'package:flutter/material.dart';
import 'package:whats_in_my_fridge/model/food.dart';

import '../database/foods_database.dart';
import '../main.dart';

class InputPopup extends StatefulWidget {
  const InputPopup({super.key});

  @override
  State<InputPopup> createState() => _InputPopupState();
}

class _InputPopupState extends State<InputPopup> {
  late Food food;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();
  String title = "title";
  String category = "category 1";
  bool isExpired = false;
  DateTime createdTime = DateTime.now();
  DateTime expiryTime = DateTime.now();

  List<String> categories = [
    'category 1',
    'category 2',
    'category 3',
    'category 4',
    'category 5'
  ];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add New Item'),
            const SizedBox(
              height: 10,
            ),
            Text('Name:'),
            const SizedBox(
              height: 10,
            ),
            buildTitle(),
            const SizedBox(
              height: 10,
            ),
            Text('Category:'),
            const SizedBox(
              height: 10,
            ),
            buildCategory(),
            const SizedBox(
              height: 10,
            ),
            Text('Expiry Date:'),
            const SizedBox(
              height: 10,
            ),
            buildexpiryTime(context),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addFood();
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle() => Form(
      key: _formKey,
      child: TextFormField(
        maxLines: 1,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
        validator: (title) =>
            title == null || title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: ((title) => setState(() {
              this.title = title;
            })),
      ));

  Widget buildCategory() => DropdownButton(
        isExpanded: true,
        value: category,
        items: categories
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: ((category) => setState(() {
              this.category = category!;
            })),
      );

  Widget buildexpiryTime(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${expiryTime.year}/${expiryTime.month}/${expiryTime.day}'),
        IconButton(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: expiryTime,
                firstDate: createdTime,
                lastDate: DateTime(2030),
              );
              if (newDate == null) return;
              setState(() {
                expiryTime = newDate;
              });
            },
            icon: Icon(Icons.date_range_outlined))
      ],
    );
  }

  Future addFood() async {
    if (_formKey.currentState!.validate()) {
      print("inside if");
      final food = Food(
        title: title,
        isExpired: isExpired,
        category: category,
        createdTime: createdTime,
        expiryTime: expiryTime,
      );
      await FoodsDatabase.instance.create(food);
      print('food added successfully!');
    }
  }
}
