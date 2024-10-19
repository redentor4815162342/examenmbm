class Category {
  String id;
  String name;
  String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  // Convertir el objeto a un mapa para guardarlo como JSON
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  // Crear una instancia de Category desde un mapa
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }
}
