class UserAddressFields {
  static const String id = "id";
  static const String lat = "lat";
  static const String long = "long";
  static const String address = "address";
  static const String createdAt = "createdAt";

  static const String locationTable = "userLocationTable";
}

class UserAddress {
  int? id;
  double lat;
  double long;
  String address;
  String createdAt;

  UserAddress({
    this.id,
    required this.lat,
    required this.long,
    required this.address,
    required this.createdAt,
  });

  UserAddress copyWith({
    String? createdAt,
    String? address,
    double? long,
    double? lat,
    int? id,
  }) {
    return UserAddress(
      lat: lat ?? this.lat,
      long: long ?? this.long,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  factory UserAddress.fromJson(Map<String, dynamic> jsonData) {
    return UserAddress(
      id: jsonData[UserAddressFields.id] ?? 0,
      lat: jsonData[UserAddressFields.lat] as double? ?? 0.0,
      long: jsonData[UserAddressFields.long] as double? ?? 0.0,
      address: jsonData[UserAddressFields.address] as String? ?? '',
      createdAt: jsonData[UserAddressFields.createdAt] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UserAddressFields.lat: lat,
      UserAddressFields.long: long,
      UserAddressFields.address: address,
      UserAddressFields.createdAt: createdAt,
    };
  }

  @override
  String toString() {
    return ''''
       lat : $lat,
       long : $long,
       address : $address,
       createdAt : $createdAt,
       id: $id, 
      ''';
  }
}
