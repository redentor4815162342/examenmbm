import 'dart:convert';

class Provider {
  String id;
  String name;
  String address;
  String phone;

  Provider({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
  });

  // Convertir el objeto a un mapa para guardarlo como JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
    };
  }

  // Crear una instancia de Provider desde un mapa
  factory Provider.fromMap(Map<String, dynamic> map) {
    return Provider(
      id: map['id'],
      name: map['name'],
      address: map['address'],
      phone: map['phone'],
    );
  }

  // Convertir a JSON
  String toJson() => json.encode(toMap());

  // Crear desde JSON
  factory Provider.fromJson(String source) =>
      Provider.fromMap(json.decode(source));
}
