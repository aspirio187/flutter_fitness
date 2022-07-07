import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_fitness/services/consommation_service.dart';
import 'package:flutter_fitness/services/product_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _productService = ProductService();
  final _consommationService = ConsommationService();
  // TODO : Statistique de consommation des 7 derniers jours :
  // - Lipides
  // - Glucide
  // - Proteines
  // TODO : Statistiques sur les vitamines consommés et les carences
  // TODO : Statistiques sur les KCal consommés

  @override
  Widget build(BuildContext context) {
    return _generateNutrimentsChart();
  }

  FutureBuilder<List<Series<NutrimentConsommation, String>>>
      _generateNutrimentsChart() {
    return FutureBuilder<List<Series<NutrimentConsommation, String>>>(
        future: _generateNutrimentsList(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Series<NutrimentConsommation, String>>>
                snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return BarChart(
                snapshot.data!,
              );
            } else {
              return const Center(
                child: Text('Aucune données'),
              );
            }
          }
        });
  }

  Future<List<Series<NutrimentConsommation, String>>>
      _generateNutrimentsList() async {
    final consommations =
        await _consommationService.getConsommationStartingFrom(
      DateTime.now().subtract(
        const Duration(days: 7),
      ),
    );

    double consummedFat = 0;
    double consummedProtein = 0;
    double consummedCarboHydrates = 0;

    if (consommations.isNotEmpty) {
      for (var consommation in consommations) {
        final product = (await _productService
            .getProductFromBarcode(consommation.productBarcode))!;

        consummedFat += product.fat;
        consummedProtein += product.protein;
        consummedCarboHydrates = product.carboHydrates;
      }
    }

    final data = [
      NutrimentConsommation(
        nutriment: 'Glucides',
        consummed: consummedCarboHydrates,
      ),
      NutrimentConsommation(
        nutriment: 'Protides',
        consummed: consummedProtein,
      ),
      NutrimentConsommation(
        nutriment: 'Lipides',
        consummed: consummedFat,
      )
    ];

    return [
      Series<NutrimentConsommation, String>(
          id: 'Nutriments',
          domainFn: (NutrimentConsommation nutrimentConsommation, _) =>
              nutrimentConsommation.nutriment,
          measureFn: (NutrimentConsommation nutrimentConsommation, _) =>
              nutrimentConsommation.consummed,
          data: data),
    ];
  }
}

class NutrimentConsommation {
  const NutrimentConsommation(
      {required this.nutriment, required this.consummed});

  final String nutriment;
  final double consummed;
}
