import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/net/api_methods.dart';
import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'add_view.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  void ininState() {
    getValues();
  }

  _HomeState(){
    getValues();
  }

  getValues() async {
    bitcoin = await getPrice('bitcoin');
    ethereum = await getPrice('ethereum');
    tether = await getPrice('tether');
    setState(() async{});
  }

  @override
  Widget build(BuildContext context) {
    getValues(String id, double amount) {
      if (id == "bitcoin") return (bitcoin * amount).toStringAsFixed(2);
      if (id == "ethereum") return (ethereum * amount).toStringAsFixed(2);
      if (id == "tether") return (tether * amount).toStringAsFixed(2);
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection("Coins")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Table(
                children: snapshot.data!.docs.map((document) {
                  return TableRow(
                    children: [
                      TableCell(
                        child: Text("${document.id.toUpperCase()}",
                          style: TextStyle(
                            color: Colors.lightBlue,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        verticalAlignment: TableCellVerticalAlignment.middle,
                      ),
                      TableCell(
                        child: Text("\$${getValues(document.id, document.get('Amount'))}",
                          textAlign: TextAlign.end,
                        ),
                        verticalAlignment: TableCellVerticalAlignment.middle,
                      ),
                      TableCell(
                        child: IconButton(
                          icon: Icon(Icons.close),
                          iconSize: 20,
                          onPressed: () async {
                            await removeCoin(document.id);
                          },
                        ),
                      )
                    ]
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddView()));
        },
        child: Icon(
          Icons.local_hospital,
          color: Colors.white,
          size: 50,
        ),
        backgroundColor: Colors.lightBlue,
      ),
    );
  }
}
