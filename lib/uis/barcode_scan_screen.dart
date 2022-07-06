import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  TextEditingController _barcodeController = TextEditingController();
  String _barcodeResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un produit'),
      ),
      body: Column(
        children: [
          OutlinedButton(
            child: const Text('Scanner un produit'),
            onPressed: () {
              FlutterBarcodeScanner.scanBarcode(
                '#ff6666',
                'Fermer',
                true,
                ScanMode.DEFAULT,
              ).then((value) => _getBarcode(value));
            },
          ),
          TextField(
            controller: _barcodeController,
            decoration: const InputDecoration(labelText: 'Codebar'),
            keyboardType: TextInputType.number,
          ),
          const Divider(),
          ElevatedButton(
            child: const Text('Recherche'),
            onPressed: () => _navigateToProductDetailScreen,
          ),
        ],
      ),
    );
  }

  _getBarcode(String value) {
    setState(() {
      _barcodeController.text = value;
    });
  }

  _navigateToProductDetailScreen() {}
}
