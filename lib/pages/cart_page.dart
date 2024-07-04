import 'package:cart_provider_app/models/cart_model.dart';
import 'package:cart_provider_app/providers/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartProvider.items.length,
                  itemBuilder: (context, index) {
                    final CartItems item =
                        cartProvider.items.values.toList()[index];
                    return Container(
                      padding: const EdgeInsets.all(5),
                      color: const Color.fromARGB(255, 254, 240, 189),
                      child: ListTile(
                        title: Text(item.tittle),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Price: \$${item.price}'),
                            Text('Quantity: ${item.quantity}'),
                            Text("Total: \$${item.price * item.quantity}"),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                cartProvider.removeSingleItem(item.id);
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                cartProvider.removeItem(item.id);
                              },
                              icon: const Icon(Icons.remove_shopping_cart),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
