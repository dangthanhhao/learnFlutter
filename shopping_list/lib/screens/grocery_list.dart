import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';

import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/data/firebaseurl.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/new_item.dart';
import 'package:shopping_list/widgets/grocery_list_item.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  List<GroceryItem> groceryList = [];
  var _isLoading = false;
  String? _error;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget currentWidget = const Center(
      child: Text('Empty'),
    );
    if (_isLoading) {
      currentWidget = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (groceryList.isNotEmpty) {
      currentWidget = ListView.builder(
        itemCount: groceryList.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(groceryList[index].id),
          onDismissed: (direction) {
            _onDeleteItem(index);
          },
          child: GroceryListItem(
            groceryItem: groceryList[index],
          ),
        ),
      );
    }

    if (_error != null) {
      currentWidget = Center(
        child: Text(_error!),
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

  void _onDeleteItem(int index) {
    final url =
        Uri.https(baseUrl, 'shopping-list/${groceryList[index].id}.json');
    http.delete(url);
    setState(() {
      groceryList.removeAt(index);
    });
  }

  void _loadItems() async {
    _isLoading = true;
    final url = Uri.https(baseUrl, 'shopping-list.json');
    final res = await http.get(url);
    if (res.statusCode >= 400) {
      setState(() {
        _error = "Failed to fetch data";
      });
    }
    final Map<String, dynamic> listData = json.decode(res.body);
    final List<GroceryItem> _loadedItems = [];
    for (var item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (element) => element.value.title == item.value['category'])
          .value;
      _loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category));
    }
    setState(() {
      _isLoading = false;
      groceryList = _loadedItems;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _onNewItem() async {
    await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );
    _loadItems();
    // if (newItem != null) {
    //   setState(() {
    //     groceryList.add(newItem);
    //   });
    // }
  }
}
