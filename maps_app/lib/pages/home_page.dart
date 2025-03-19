import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://userimages.githubusercontent.com/75456232/212501850-7266409a-f0fd-4839-ba9ad328a464c76c.png"
                      ),
                    fit: BoxFit.cover
                  )
                ),
              )
          )
        ],
      ),
    );
  }
}