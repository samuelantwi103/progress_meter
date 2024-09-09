// pages/login.dart
import 'package:flutter/material.dart';
import 'package:progress_meter/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
            child: Container(
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Code",
                    hintText: "Enter your code",
                    filled: true,
                    
                    fillColor: Theme.of(context).colorScheme.primaryContainer,
                    prefixIcon: Icon(Icons.numbers),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
              ),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    labelText: "PIN",
                    hintText: "Enter your PIN",
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.primaryContainer,
                    prefixIcon: Icon(Icons.fiber_pin_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
              ),
              FilledButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
                child: Text("Login"),
              ),
                        ],
                      ),
            )),
      ),
    );
  }
}
