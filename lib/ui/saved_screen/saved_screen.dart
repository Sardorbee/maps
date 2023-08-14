import 'package:dio_example/data/models/user_address.dart';
import 'package:dio_example/services/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved locations'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          List<UserAddress> user = context.watch<DatabaseProvider>().addresses;
          if (user.isEmpty) {
            return Text("You have no saved locations");
          } else if (user.isNotEmpty) {
            UserAddress x = user[index];
            return ListTile(
              title: Text(x.address),
              subtitle: Text(
                  "lat: ${x.lat.toString()} and long: ${x.long.toString()}"),
            );
          }
        },
        itemCount: context.watch<DatabaseProvider>().addresses.length,
      ),
    );
  }
}
