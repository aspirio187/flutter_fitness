import 'package:flutter_fitness/models/product_model.dart';
import 'package:flutter_fitness/sql_helper.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sql;

class ProductService {
  ProductService();

  Future<ProductModel?> getProductFromSDK(String barcode) async {
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

  Future<int> createProduct(ProductModel product) async {
    final db = await SqlHelper.db();

    final data = {
      'barcode': product.barcode,
      'name': product.name,
      'imgUrl': product.imgUrl,
      'imgSmallUrl': product.imgSmallUrl,
      'carboHydrates': product.carboHydrates,
      'protein': product.protein,
      'fat': product.fat,
      'energyKj': product.energyKj,
      'energyKcal': product.energyKcal,
      'vitaminA': product.vitaminA,
      'vitaminB1': product.vitaminB1,
      'vitaminB2': product.vitaminB2,
      'vitaminB6': product.vitaminB6,
      'vitaminB9': product.vitaminB9,
      'vitaminC': product.vitaminC,
      'vitaminD': product.vitaminD,
      'vitaminE': product.vitaminE,
      'vitaminK': product.vitaminK,
      'vitaminPP': product.vitaminPP
    };

    final id = await db.insert(
      'products',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );

    return id;
  }
}
