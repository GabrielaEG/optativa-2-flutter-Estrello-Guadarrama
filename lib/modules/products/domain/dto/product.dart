class Product {
  final int id; 
  final String titulo; 
  final String descripcion; 
  final double precio; 
  final int? stock; 
  final String? imageUrl; 

  Product({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.precio,
    this.stock,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      titulo: json['title'],
      descripcion: json['description'],
      precio: json['price'],
      stock: json['stock'],
      imageUrl: json['image'] ?? 'https://via.placeholder.com/150', 
    );
  }
}
