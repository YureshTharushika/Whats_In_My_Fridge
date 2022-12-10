import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whats_in_my_fridge/widgets/food_form.dart';

import 'database/foods_database.dart';
import 'model/food.dart';

class AddEditFood extends StatefulWidget {
  final Food? food;

  const AddEditFood({super.key, this.food});

  @override
  State<AddEditFood> createState() => _AddEditFoodState();
}

class _AddEditFoodState extends State<AddEditFood> {
  late bool isExpired;
  late String title;
  late String? category;
  late DateTime expiryTime;

  @override
  void initState() {
    super.initState();

    isExpired = widget.food?.isExpired ?? false;
    title = widget.food?.title ?? '';
    category = widget.food?.category ?? '';
    expiryTime = widget.food?.expiryTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            Container(
              child: Form(
                // key: _formKey,
                child: FoodForm(
                  isExpired: isExpired,
                  title: title,
                  category: category,
                  expiryTime: expiryTime,
                  onChangedexpiryTime: (expiryTime) =>
                      setState(() => this.expiryTime = expiryTime),
                  onChangedTitle: (title) => setState(() => this.title = title),
                  onChangedCategory: (category) =>
                      setState(() => this.category = category),
                ),
              ),
            ),
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
                      // addOrUpdateFood();
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

  // void addOrUpdateFood() async {
  //   final isValid = _formKey.currentState!.validate();

  //   if (isValid) {
  //     final isUpdating = widget.food != null;

  //     if (isUpdating) {
  //       //await updateFood();
  //     } else {
  //       await addFood();
  //     }

  //     Navigator.of(context).pop();
  //   }
  // }

  // Future updateFood() async {
  //   final note = widget.food!.copy(

  //     title: title,
  //     category: category,
  //     isExpired: isExpired,
  //     expiryTime: expiryTime
  //   );

  //   await FoodsDatabase.instance.update(note);
  // }

  Future addFood() async {
    final food = Food(
      title: title,
      isExpired: false,
      category: category!,
      createdTime: DateTime.now(),
      expiryTime: expiryTime,
    );

    await FoodsDatabase.instance.create(food);
  }
}
