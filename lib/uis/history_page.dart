import 'package:flutter/widgets.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Image.network(
              "https://images.openfoodfacts.org/images/products/073/762/806/4502/front_en.6.200.jpg",
              height: 50,
              width: 50,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text('title'),
                Text('description'),
              ],
            )
          ],
        ),
      ],
    );
  }
}
