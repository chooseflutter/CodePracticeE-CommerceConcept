import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListScreen(),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String description;

  Product({required this.name, required this.price, required this.description});
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(name: 'Product 1', price: 20.0, description: 'Description of Product 1'),
    Product(name: 'Product 2', price: 30.0, description: 'Description of Product 2'),
    Product(name: 'Product 3', price: 25.0, description: 'Description of Product 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce App'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(products[index].name),
                subtitle: Text('\$${products[index].price.toStringAsFixed(2)}'),
                trailing: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Show product details when the button is pressed
                        _showProductDetails(context, products[index]);
                      },
                      child: Text('Details'),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Show product details when the button is pressed
                  _addToCart(context, products[index]);
                },
                child: Text('Add Product'),
              ),

            ],
          );
        },
      ),
    );
  }

  void _addToCart(BuildContext context, Product product) {
    // For simplicity, let's assume there is a CartScreen widget for the cart.
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cartItems: [CartItem(product: product, quantity: 1)]),
      ),
    );
  }
}

  void _showProductDetails(BuildContext context, Product product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailsScreen(product: product),
      ),
    );
  }


class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems;

  CartScreen({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartItems[index].product.name),
            subtitle: Text('\$${(cartItems[index].product.price * cartItems[index].quantity).toStringAsFixed(2)}'),
            trailing: Text('Quantity: ${cartItems[index].quantity}'),
          );
        },
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Price: \$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}


void _addToCart(BuildContext context, Product product) {
  // For simplicity, let's assume there is a CartScreen widget for the cart.
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CartScreen(cartItems: [CartItem(product: product, quantity: 1)]),
    ),
  );
}

