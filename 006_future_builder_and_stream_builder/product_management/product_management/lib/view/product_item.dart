import 'package:flutter/material.dart';
import 'package:product_management/view/base_image.dart';

import '../model/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          BaseCacheImage(url: product.image, height: 100, width: 100,),
          const SizedBox(height: 8),
          Text(product.name),
          const SizedBox(height: 8),
          Text(product.price.toString()),
          const SizedBox(height: 8),
          Text(
            product.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
