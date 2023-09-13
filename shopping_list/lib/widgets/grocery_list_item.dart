import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryListItem extends StatelessWidget {
  const GroceryListItem({super.key, required this.groceryItem});
  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        color: groceryItem.category.color,
        width: 24,
        height: 24,
      ),
      title: Text(
        groceryItem.name,
        style: const TextStyle(fontWeight: FontWeight.normal),
      ),
      trailing: Text(
        groceryItem.quantity.toString(),
        style: const TextStyle(fontSize: 12),
      ),
      onTap: () {},
    );
  }
}
