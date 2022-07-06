import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScanScreen extends StatefulWidget {
  const BarcodeScanScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  final TextEditingController _barcodeController = TextEditingController();
  String _validationMessage = '';
  late bool _isSearchDisabled;

  @override
  void initState() {
    _isSearchDisabled = true;
    super.initState();
  }

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
            onSubmitted: (text) {
              if (text.isEmpty) {
                setState(() {
                  _validationMessage = 'Veuillez encoder un codebar';
                });
              } else {
                int? barcode = int.tryParse(text);

                if (barcode == null) {
                  setState(() {
                    _validationMessage =
                        'Veuillez encoder le code bar comme un nombre entier '
                        'strictement positif!';
                  });
                } else {
                  if (barcode < 0) {
                    setState(() {
                      _validationMessage =
                          'Le codebar ne peut pas être un nombre négatif!';
                    });
                  } else {
                    setState(() {
                      _validationMessage = '';
                      _isSearchDisabled = false;
                    });
                  }
                }
              }
            },
          ),
          Text(
            _validationMessage,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
          const Divider(),
          ElevatedButton(
            child: const Text('Recherche'),
            onPressed: () {
              if (_isSearchDisabled == false) {
                _navigateToProductDetailScreen(_barcodeController.text);
              }
            },
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

  _navigateToProductDetailScreen(String barcode) {}
}
