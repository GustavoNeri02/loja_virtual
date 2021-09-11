import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/product_data.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: type == "Grid"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      product.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "R\$ ${product.price.toStringAsPrecision(2)}",
                          style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ))
                ],
              )
            : Row(),
      ),
    );
  }
}
