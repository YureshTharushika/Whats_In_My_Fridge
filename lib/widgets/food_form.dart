import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FoodForm extends StatelessWidget {
  final bool? isExpired;
  final String? title;
  final String? category;
  final DateTime? expiryTime;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String?>? onChangedCategory;
  final ValueChanged<DateTime> onChangedexpiryTime;

  const FoodForm({
    Key? key,
    this.isExpired = false,
    this.title = '',
    this.category = '',
    this.expiryTime,
    required this.onChangedTitle,
    required this.onChangedCategory,
    required this.onChangedexpiryTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Name:'),
          const SizedBox(
            height: 10,
          ),
          buildTitle(),
          const SizedBox(height: 8.0),
          Text('Category:'),
          const SizedBox(
            height: 10,
          ),
          buildCategory(),
          const SizedBox(height: 8.0),
          Text('Expiry Date:'),
          const SizedBox(
            height: 10,
          ),
          buildexpiryTime(context),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildCategory() {
    List<String> categories = [
      'category 1',
      'category 2',
      'category 3',
      'category 4',
      'category 5'
    ];

    return DropdownButton(
      isExpanded: true,
      value: 'category 1',
      items: categories
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: onChangedCategory,
    );
  }

  Widget buildexpiryTime(context) {
    DateTime date = DateTime.now();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${expiryTime!.year}/${expiryTime!.month}/${expiryTime!.day}'),
        IconButton(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: date,
                lastDate: DateTime(2030),
              );
              if (newDate == null) return;
              onChangedexpiryTime;
            },
            icon: Icon(Icons.date_range_outlined))
      ],
    );
  }
}
