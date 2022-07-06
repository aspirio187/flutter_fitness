import 'package:flutter/widgets.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key, required this.barcode})
      : super(key: key);

  final String barcode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            '',
            height: 400,
            fit: BoxFit.fitHeight,
          )
        ],
      ),
    );
  }
}
