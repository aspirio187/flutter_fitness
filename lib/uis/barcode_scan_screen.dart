import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BarcodeScanScreen extends StatelessWidget {
  const BarcodeScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un produit'),
      ),
      body: Center(
        child: OutlinedButton(
          child: const Text('Scanner un produit'),
          onPressed: () {
            print('Scanneur appelé');
          },
        ),
      ),
    );
  }
}
