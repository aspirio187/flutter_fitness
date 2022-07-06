import 'package:openfoodfacts/openfoodfacts.dart';

class ProductService {
  ProductService();

  getProduct(String barcode) async {
    var configuration = ProductQueryConfiguration(barcode);

    ProductResult result = await OpenFoodAPIClient.getProduct(configuration);

    if (result.status != 1) {
      return;
    }
  }
}
