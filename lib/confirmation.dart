import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({ Key? key }) : super(key: key);
// 09066465416
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Lottie.asset('assets/confirm1.json'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/confirm.json',),
              const Text(
                'Verification Successful!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 24.0
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}