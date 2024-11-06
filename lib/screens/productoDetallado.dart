import 'package:flutter/material.dart';
import 'package:estrello_gabriela_examen_segundo_parcial/modules/products/domain/dto/product.dart';

class ProductoDetallado extends StatelessWidget {
  final Product product;

  ProductoDetallado({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalle de producto"),
        backgroundColor: Colors.blue, 
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          
            Image.network(
              product.imageUrl ?? 'https://via.placeholder.com/150',
              width: 200,  
              height: 200,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 24), 
          
            Text(
              product.titulo,
              style: TextStyle(
                fontSize: 26,  
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12),  

          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.descripcion,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 24), 

         
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Precio \$${product.precio.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                ),
                Text(
                  "Stock ${product.stock ?? 0}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), 
                ),
              ],
            ),
            SizedBox(height: 32),  

           
            SizedBox(
              width: double.infinity, 
              child: ElevatedButton.icon(
                onPressed: () {
                 
                },
                icon: Icon(Icons.add),
                label: Text("Agregar"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, 
                  padding: EdgeInsets.symmetric(vertical: 14),  
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),  
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
