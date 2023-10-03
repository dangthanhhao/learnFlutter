import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/firebaseurl.dart';

import '../models/category.dart';
import '../models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;

  final newItem = GroceryItem(
      id: DateTime.now().toString(),
      name: '',
      quantity: 1,
      category: categories[Categories.vegetables]!);

  void saveItem() async {
    _formKey.currentState!.validate();
    _formKey.currentState!.save();
    setState(() {
      _isSending = true;
    });
    final url = Uri.https(baseUrl, 'shopping-list.json');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'name': newItem.name,
          'quantity': newItem.quantity,
          'category': newItem.category.title
        },
      ),
    );
    print(res.body);
    print(res.statusCode);

    if (!context.mounted) {
      return;
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length <= 1) {
                      return 'Must be more than 1 char';
                    }
                    return null;
                  },
                  onSaved: (newValue) => newItem.name = newValue!,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Quantity'),
                        ),
                        initialValue: '1',
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null) {
                            return 'Must be interger';
                          }
                          return null;
                        },
                        onSaved: (newValue) =>
                            newItem.quantity = int.parse(newValue!),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        items: [
                          for (final i in categories.entries)
                            DropdownMenuItem(
                              value: i.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    color: i.value.color,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(i.value.title)
                                ],
                              ),
                            )
                        ],
                        onChanged: (value) {},
                        onSaved: (newValue) => newItem.category = newValue!,
                        value: newItem.category,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: _isSending ? null : saveItem,
                        child: _isSending
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('OK')),
                    TextButton(
                        onPressed: _isSending
                            ? null
                            : () {
                                _formKey.currentState!.reset();
                              },
                        child: const Text('Reset'))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
