import 'package:cart_provider_app/data/product_data.dart';
import 'package:cart_provider_app/models/product_model.dart';
import 'package:cart_provider_app/pages/cart_page.dart';
import 'package:cart_provider_app/pages/fav_page.dart';
import 'package:cart_provider_app/providers/card_provider.dart';
import 'package:cart_provider_app/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = ProductData().products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Page'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.deepPurpleAccent,
            heroTag: "favorite_button",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FavoritePage(),
              ));
            },
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10),
          FloatingActionButton(
            heroTag: "cart_button",
            backgroundColor: Colors.deepPurpleAccent,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CartPage(),
              ));
            },
            child: const Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final Product product = products[index];
          return Card(
            child: Consumer2<CartProvider, FavoriteProvider>(
              builder: (BuildContext context, CartProvider cartProvider,
                  FavoriteProvider favoriteProvider, Widget? child) {
                return ListTile(
                  title: Row(
                    children: [
                      Text(product.title),
                      const SizedBox(width: 50),
                      Text(
                        cartProvider.items.containsKey(product.id)
                            ? cartProvider.items[product.id]!.quantity
                                .toString()
                            : '0',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Text("\$${product.price.toString()}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          favoriteProvider.isFavorite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: favoriteProvider.isFavorite(product.id)
                              ? Colors.redAccent
                              : Colors.grey,
                        ),
                        onPressed: () {
                          favoriteProvider.toggleFavorite(product.id);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(favoriteProvider
                                      .isFavorite(product.id)
                                  ? '${product.title} added to Favorite'
                                  : '${product.title} Removed from Favorite'),
                              duration: const Duration(seconds: 1)));
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: cartProvider.items.containsKey(product.id)
                              ? Colors.deepPurpleAccent
                              : Colors.grey,
                        ),
                        onPressed: () {
                          cartProvider.addItem(
                            product.id,
                            product.price,
                            product.title,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              '${product.title} added to cart',
                            ),
                            duration: const Duration(seconds: 1),
                          ));
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
