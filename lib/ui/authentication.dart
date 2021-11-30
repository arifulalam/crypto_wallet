import 'package:crypto_wallet/net/flutterfire.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Home.dart';

class Authentication extends StatefulWidget{
  const Authentication({Key? key}): super(key:key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication>{
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.green,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Crypto Wallet',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(
                  hintText: 'you@mail.com',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              TextFormField(
                controller: _pwd,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'secret key',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                margin: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate = await signUp(_email.text, _pwd.text);

                    shouldNavigate
                        ? Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        )
                    )
                        : null;
                  },
                  child: const Text("Register"),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(7),
                width: MediaQuery.of(context).size.width / 1.4,
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: MaterialButton(
                    onPressed: () async {
                      bool shouldNavigate = await signIn(_email.text, _pwd.text);

                      shouldNavigate
                          ? Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          )
                      )
                          : null;
                    },
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}