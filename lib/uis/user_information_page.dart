import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserInformationPage extends StatefulWidget {
  const UserInformationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserInformationPageState();
}

class _UserInformationPageState extends State<UserInformationPage> {
  double v = 0;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          const Text(
            'Poid',
            style: TextStyle(fontSize: 22),
          ),
          const Divider(),
          Text(v.toInt().toString() + ' kg'),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Poid'),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (String value) {
              setState(() {
                v = double.parse(value);
              });
            },
          ),
          Slider(
            min: 0,
            max: 200,
            value: v,
            onChanged: (value) {
              setState(() {
                v = value;
              });

              print(v);
            },
          ),
        ],
      ),
    );
  }
}
