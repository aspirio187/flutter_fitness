import 'package:flutter_fitness/models/product_model.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class ProductService {
  ProductService();

  Future<ProductModel?> getProduct(String barcode) async {
    var configuration = ProductQueryConfiguration(barcode);

    ProductResult result = await OpenFoodAPIClient.getProduct(configuration);

    if (result.status != 1) {
      return null;
    }

    if (result.product == null) {
      return null;
    }

    ProductModel product = ProductModel.fromSDK(result.product!);

    return product;
  }
}
