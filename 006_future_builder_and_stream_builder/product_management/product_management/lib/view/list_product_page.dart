
import 'package:flutter/material.dart';
import 'package:product_management/controller/product_controller.dart';
import 'package:product_management/view/product_item.dart';

import '../model/product.dart';

class ListProductPage extends StatefulWidget {
  const ListProductPage({super.key});

  @override
  State<ListProductPage> createState() => _ListProductPageState();
}

class _ListProductPageState extends State<ListProductPage> {
  final ProductController prodCtrl = ProductController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent - 50) { // cuon den cuoi cung...
      prodCtrl.loadMoreProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          prodCtrl.addProduct(
            Product(
              name: 'Product New',
              image:
              'https://m.media-amazon.com/images/I/51qFSdheDPL._AC_UF1000,1000_QL80_.jpg',
              price: 999999.0,
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<ListProductState>(
          stream: prodCtrl.stream,
          initialData: prodCtrl.currentState,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: Text('Snapshot has no data'),
              );
            }
            final state = snapshot.data!;
            if (state.status == Status.loading && state.products.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state.status == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.status == Status.error) {
              return const Center(
                child: Text("Error"),
              );
            }
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.products.length +
                  (state.status == Status.loadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < state.products.length) {
                  final product = state.products[index];
                  return ProductItem(product: product);
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}