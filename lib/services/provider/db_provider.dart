import 'package:dio_example/data/local/location_db.dart';
import 'package:dio_example/data/models/user_address.dart';
import 'package:flutter/cupertino.dart';

class DatabaseProvider with ChangeNotifier {
  List<UserAddress> addresses = [];

  DatabaseProvider() {
    getAddresses();
  }

  getAddresses() async {
    addresses = await LocalDatabase.getAllAddresses();
    print("CURRENT LENGTH:${addresses.length}");
    notifyListeners();
  }

  insertAddress(UserAddress userAddress) async {
    await LocalDatabase.insertAddress(userAddress);
    getAddresses();
  }

  deleteAddress(int id) async {
    await LocalDatabase.deleteAddressByID(id);
    getAddresses();
  }

  deleteAllAddress() async {
    await LocalDatabase.deleteAllAddresses();
    getAddresses();
  }
}
