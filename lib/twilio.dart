import 'package:twilio_phone_verify/twilio_phone_verify.dart';

class TwilioVerification {
  static final instance = TwilioVerification();

  final TwilioPhoneVerify _twilioPhoneVerify = TwilioPhoneVerify(
    
    accountSid: '*************************', // replace with Account SID
    authToken: 'xxxxxxxxxxxxxxxxxx',  // replace with Auth Token
    serviceSid: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' // replace with Service SID
  );

  Future<String> sendCode(phoneNumberController) async {
    TwilioResponse twilioResponse =
      await _twilioPhoneVerify.sendSmsCode(phoneNumberController);

    if (twilioResponse.successful!) {
      return 'Successful';
    } else {
      print(twilioResponse.errorMessage.toString());
      return twilioResponse.errorMessage.toString();
    }
  }

  Future<String> verifyCode(phoneNumber, otp) async {

    TwilioResponse twilioResponse = await _twilioPhoneVerify.verifySmsCode(
        phone: phoneNumber, code: otp);
    if (twilioResponse.successful!) {
      if (twilioResponse.verification!.status == VerificationStatus.approved) {
        return "Successful";
      } else {
        return 'Invalid code';
      }
    } else {
      return twilioResponse.errorMessage.toString();
    }

  }
}