import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fitness/models/product_model.dart';
import 'package:flutter_fitness/services/product_service.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.barcode})
      : super(key: key);

  final String barcode;

  @override
  State<StatefulWidget> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductService _productService = ProductService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<ProductModel?>(
        future: _productService.getProductFromSDK(widget.barcode),
        builder: (BuildContext context, AsyncSnapshot<ProductModel?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return Center(
                child: Text(
                  'Aucun produit avec le code bar ${widget.barcode} n\'a été '
                  'trouvé!',
                ),
              );
            }

            ProductModel product = snapshot.data!;

            return Column(
              children: [
                Image.network(product.imgUrl),
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                ),
                const Text(
                  'Les informations suivantes représente le nombre de gramme (g)'
                  'par portion de 100 grammes',
                ),
                const Divider(),
                Table(
                  columnWidths: <int, TableColumnWidth>{
                    0: FixedColumnWidth((window.physicalSize.width / 100 * 70)),
                    1: const IntrinsicColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    const TableRow(
                      children: [
                        TableCell(
                          child: Text(
                            'Nutriment',
                          ),
                        ),
                        TableCell(
                          child: Text(
                            'Quantité (en g)',
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                          child: Text(
                            'Glucides',
                          ),
                        ),
                        TableCell(
                          verticalAlignment: TableCellVerticalAlignment.middle,
                          child: Text(
                            product.carboHydrates.toString(),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                          child: Text('Protides'),
                        ),
                        TableCell(
                          child: Text(
                            product.protein.toString(),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                          child: Text(
                            'Lipides',
                          ),
                        ),
                        TableCell(
                          child: Text(
                            product.fat.toString(),
                          ),
                        ),
                      ],
                    ),
                    // TableRow(
                    //   children: [
                    //     const Text('Vitamine A'),
                    //     Text(product.vitaminA.toString()),
                    //   ],
                    // ),
                    // TableRow(
                    //   children: [
                    //     const Text('Vitamine B1'),
                    //     Text(product.vitaminB1.toString()),
                    //   ],
                    // ),
                    // TableRow(
                    //   children: [
                    //     const Text('Vitamine B2'),
                    //     Text(product.vitaminB2.toString()),
                    //   ],
                    // ),
                    // TableRow(
                    //   children: [
                    //     const Text('Vitamine B6'),
                    //     Text(product.vitaminB6.toString()),
                    //   ],
                    // ),
                    // TableRow(
                    //   children: [
                    //     const Text('Vitamine B9'),
                    //     Text(product.vitaminB9.toString()),
                    //   ],
                    // ),
                    // TableRow(
                    //   children: [
                    //     const Text('Vitamine C'),
                    //     Text(product.vitaminC.toString()),
                    //   ],
                    // ),
                    // TableRow(
                    //   children: [
                    //     const Text('Vitamine D'),
                    //     Text(product.vitaminD.toString()),
                    //   ],
                    // ),
                    // TableRow(
                    //   children: [
                    //     const Text('Vitamine E'),
                    //     Text(product.vitaminE.toString()),
                    //   ],
                    // ),
                    // TableRow(
                    //   children: [
                    //     const Text('Vitamine K'),
                    //     Text(product.vitaminK.toString()),
                    //   ],
                    // ),
                    // TableRow(
                    //   children: [
                    //     const Text('Vitamine PP'),
                    //     Text(product.vitaminPP.toString()),
                    //   ],
                    // ),
                  ],
                )
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Une erreur est survenu lors du chargement des données',
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
