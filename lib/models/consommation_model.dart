class ConsommationModel {
  const ConsommationModel(
      {required this.id,
      required this.quantity,
      required this.productBarcode,
      required this.consummedAt});

  final int id;
  final double quantity;
  final String productBarcode;
  final DateTime consummedAt;
}
