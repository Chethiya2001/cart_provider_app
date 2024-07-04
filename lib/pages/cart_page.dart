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
        title: const Text('Cart Page'),
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
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      '${item.tittle} removed.',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ));
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                onPressed: () {
                                  cartProvider.removeItem(item.id);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      '${item.tittle} Removed From the cart',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ));
                                },
                                icon: const Icon(Icons.remove_shopping_cart),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(08),
                child: Text(
                  'Total: \$${cartProvider.totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    cartProvider.clearly();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Cart Cleared'),
                      duration: Duration(seconds: 1),
                    ));
                  },
                  child: const Text('Clear Cart'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
