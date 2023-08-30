import 'package:flutter/material.dart';
import 'package:meals/models/setting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Setting setting = Setting();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(setting);
          return false;
        },
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8)),
          child: Column(children: [
            SwitchListTile(
              value: setting.isGlutenFree,
              onChanged: (value) {
                setState(() {
                  setting.isGlutenFree = !setting.isGlutenFree;
                });
              },
              title: const Text('Gluten'),
            ),
            SwitchListTile(
                value: setting.isLactoseFree,
                onChanged: (value) {
                  setState(() {
                    setting.isLactoseFree = !setting.isLactoseFree;
                  });
                },
                title: const Text('Lactose')),
            SwitchListTile(
                value: setting.isVegan,
                onChanged: (value) {
                  setState(() {
                    setting.isVegan = !setting.isVegan;
                  });
                },
                title: const Text('Vegan')),
            SwitchListTile(
                value: setting.isVegetarian,
                onChanged: (value) {
                  setState(() {
                    setting.isVegetarian = !setting.isVegetarian;
                  });
                },
                title: const Text('Vegetarian')),
          ]),
        ),
      ),
    );
  }
}
