import 'package:flutter_fitness/models/consommation_model.dart';
import 'package:flutter_fitness/sql_helper.dart';

class ConsommationService {
  Future<int> saveConsommation(ConsommationModel consommationModel) async {
    final db = await SqlHelper.db();

    final data = {
      'id': consommationModel.id,
      'quantity': consommationModel.quantity,
      'barcode': consommationModel.productBarcode
    };

    return await db.insert('consommations', data);
  }
}