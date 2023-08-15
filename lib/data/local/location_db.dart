import 'package:dio_example/data/models/user_address.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("user_addresses.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const doubleType = "REAL DEFAULT 0.0";

    await db.execute('''
    CREATE TABLE ${UserAddressFields.locationTable}(
    ${UserAddressFields.id} $idType,
    ${UserAddressFields.lat} $doubleType,
    ${UserAddressFields.long} $doubleType,
    ${UserAddressFields.address} $textType,
    ${UserAddressFields.createdAt} $textType
    );
    ''');
  }

  static Future<UserAddress> insertAddress(
      UserAddress locationUserModel) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        UserAddressFields.locationTable, locationUserModel.toJson());

    return locationUserModel.copyWith(id: id);
  }

  static Future<List<UserAddress>> getAllAddresses() async {
    List<UserAddress> allLocationUser = [];
    final db = await getInstance.database;
    allLocationUser = (await db.query(UserAddressFields.locationTable))
        .map((e) => UserAddress.fromJson(e))
        .toList();

    return allLocationUser;
  }

  static deleteAddressByID(int id) async {
    final db = await getInstance.database;
    db.delete(
      UserAddressFields.locationTable,
      where: "${UserAddressFields.id} = ?",
      whereArgs: [id],
    );
  }

  static deleteAllAddresses() async {
    final db = await getInstance.database;
    db.delete(
      UserAddressFields.locationTable,
    );
  }
}
