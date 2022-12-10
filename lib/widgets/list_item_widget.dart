import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/food.dart';

class ListItemWidget extends StatelessWidget {
  final Food item;
  final Animation<double> animation;
  final VoidCallback? OnClicked;

  const ListItemWidget(
      {required this.item,
      required this.animation,
      required this.OnClicked,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          item.title,
          style: TextStyle(fontSize: 20.0, color: Colors.black),
        ),
      ),
    );
  }
}
