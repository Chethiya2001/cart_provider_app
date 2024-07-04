import 'package:cart_provider_app/data/product_data.dart';
import 'package:cart_provider_app/models/product_model.dart';
import 'package:cart_provider_app/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Page'),
      ),
      body: Consumer<FavoriteProvider>(
        builder: (BuildContext context, FavoriteProvider value, Widget? child) {
          //convert the map to list
          final favoriteItems = value.favorites.entries
              .where((entry) => entry.value)
              .map((entry) => entry.key)
              .toList();
          if (favoriteItems.isEmpty) {
            return const Center(
              child: Text('No favorite items'),
            );
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              final productId = favoriteItems[index];
              final Product product = ProductData().products.firstWhere(
                    (element) => element.id == productId,
                  );
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(product.title),
                    subtitle: Text('Price: \$${product.price}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        value.toggleFavorite(productId);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            '${product.title} Removed From the Favorite',
                          ),
                          duration: const Duration(seconds: 1),
                        ));
                      },
                    ),
                  ),
                ),
              );
            },
            itemCount: favoriteItems.length,
          );
        },
      ),
    );
  }
}
