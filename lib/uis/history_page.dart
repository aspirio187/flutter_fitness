import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fitness/models/product_model.dart';
import 'package:flutter_fitness/services/product_service.dart';
import 'package:flutter_fitness/uis/product_detail_screen.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  final ProductService _productService = ProductService();
  final List<ProductModel> _products = [];
  Stream<ProductModel>? _productStream;

  @override
  void initState() {
    setState(() {
      _productStream = (() {
        late final StreamController<ProductModel> controller;

        controller = StreamController<ProductModel>(
          onListen: () => _productService.getProducts(),
        );

        return controller.stream;
      })();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ProductModel>>(
      stream: _productService.getProducts(),
      builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final ProductModel product = snapshot.data![index];

              return InkWell(
                child: Container(
                  alignment: Alignment.center,
                  child: Image.network(
                    product.imgSmallUrl,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailScreen(
                        barcode: snapshot.data![index].barcode,
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const Center(
            child: Text('Aucune données'),
          );
        }
      },
    );
  }
}
