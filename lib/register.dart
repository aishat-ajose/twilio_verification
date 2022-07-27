import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:number_verification/twilio.dart';
import 'package:number_verification/verify.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
    TextEditingController controller = TextEditingController();

    String number = '';

    String errorMessage = '';

    bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        children: [
          SvgPicture.asset('assets/register.svg', height: size.height / 1.9,),

          const Text(
            'Register',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.black
            ),
          ),

          const SizedBox(height: 20,),

          const Text(
            'Welcome to our amazing reading community. Please enter your phone number, We will send an OTP for verification.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black
            ),
          ),

          const SizedBox(height: 30,),

          Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(style: BorderStyle.solid, color: Colors.grey, width: 0.5),
              boxShadow:const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                  blurRadius: 1,
                  offset: Offset(2, 2,),
                )
              ]
            ),

            child: TextField(
              controller: controller,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0)
              ),
              keyboardType: TextInputType.number,

              onChanged: (value){
                setState(() {
                  number = value;
                  debugPrint(value);
                });
              },
            ),
          ),

          const SizedBox(height: 5,),

          Center(
            child: Text(
              errorMessage, 
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red
              )
            )
          ),
        

          const SizedBox(height: 30,),

          InkWell(
            onTap: () async{

              setState(() {
                isLoading = true;
              });
              
              String result = await TwilioVerification.instance.sendCode('+' + number);
              
              setState(() {
                isLoading = true;
              });
              
              if (result == 'Successful'){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => VerifyPage(phoneNumber: number,))
                );
              }
              else{
                setState(() {
                  errorMessage = result;
                });
              }
            },
            child: appButton(isLoading ? 'Sending code ...' :'Register')
          ),
        ],
      ),
    );
  }
}




Widget appButton(text){
  return Container(
    height: 50.0,
    width: double.infinity,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: const Color(0xFF6C63FF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(style: BorderStyle.solid, color: Colors.grey, width: 0.5),

    ),

    child: Text(
      text,
      style: const TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.white
      ),
    ),
  );
}