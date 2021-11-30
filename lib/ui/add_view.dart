import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/material.dart';

class AddView extends StatefulWidget {
  const AddView({Key? key}) : super(key: key);

  @override
  _AddViewState createState() => _AddViewState();
}

class _AddViewState extends State<AddView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  List<String> coins = ['bitcoin', 'tether', 'ethereum'];

  String dropdownvalue = 'bitcoin';
  TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButton(
            value: dropdownvalue,
            onChanged: (value) {
              setState((){
                dropdownvalue = value.toString();
              });
            },
            items: coins.map<DropdownMenuItem<String>>((value){
              return DropdownMenuItem<String>(
                  value: value.toString(),
                  child: Text(value.toString()),
              );
            }).toList(),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: "Coin Amount",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Container(
            width: double.infinity,
            height: 45,
            child: MaterialButton(
              onPressed: () async{
                await addCoin(dropdownvalue, _amountController.text);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          )
        ],
      ),
    );
  }
}
