import 'package:flutter/material.dart';
import 'package:whats_in_my_fridge/widgets/inputpopup.dart';
import 'package:whats_in_my_fridge/widgets/list_item_widget.dart';

import 'add_or_update_food.dart';
import 'database/foods_database.dart';

import 'model/food.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Food> foods;
  // final List<Food> fooditems = List.from(fooditems);
  // final List<Food> fooditems = [
  //   Food(
  //       title: "food1",
  //       category: "category1",
  //       isExpired: false,
  //       createdTime: DateTime.now(),
  //       expiryTime: DateTime.now()),
  //   Food(
  //       title: "food2",
  //       category: "category2",
  //       isExpired: false,
  //       createdTime: DateTime.now(),
  //       expiryTime: DateTime.now()),
  //   Food(
  //       title: "food3",
  //       category: "category3",
  //       isExpired: false,
  //       createdTime: DateTime.now(),
  //       expiryTime: DateTime.now()),
  //   Food(
  //       title: "food4",
  //       category: "category4",
  //       isExpired: false,
  //       createdTime: DateTime.now(),
  //       expiryTime: DateTime.now()),
  // ];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshFoods();
  }

  @override
  void dispose() {
    FoodsDatabase.instance.close();

    super.dispose();
  }

  Future refreshFoods() async {
    setState(() => isLoading = true);

    foods = await FoodsDatabase.instance.retriveAllFood();
    print(foods.isEmpty);
    print(foods.length);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    //print(foods.length);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.refresh_outlined),
          onPressed: () {
            refreshFoods();
          },
        ),
      ),
      body: isLoading
          ? const CircularProgressIndicator()
          : AnimatedList(
              initialItemCount: foods.length,
              itemBuilder: (context, index, animation) => ListItemWidget(
                item: foods[index],
                animation: animation,
                OnClicked: () {},
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => InputPopup(),
          );
          setState(() {
            refreshFoods();
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
