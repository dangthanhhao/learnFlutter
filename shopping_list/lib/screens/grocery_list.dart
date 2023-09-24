import 'package:flutter/material.dart';
import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/new_item.dart';
import 'package:shopping_list/widgets/grocery_list_item.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final List<GroceryItem> groceryList = [];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget currentWidget = const Center(
      child: Text('Empty'),
    );
    if (groceryList.isNotEmpty) {
      currentWidget = ListView.builder(
        itemCount: groceryList.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(groceryList[index].id),
          onDismissed: (direction) {
            setState(() {
              groceryList.removeAt(index);
            });
          },
          child: GroceryListItem(
            groceryItem: groceryList[index],
          ),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(onPressed: _onNewItem, icon: const Icon(Icons.add))
          ],
        ),
        body: currentWidget);
  }

  void _onNewItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );
    if (newItem != null) {
      setState(() {
        groceryList.add(newItem);
      });
    }
  }
}
