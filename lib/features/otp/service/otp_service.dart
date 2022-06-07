import 'package:firebase_auth/firebase_auth.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/network/base_network.dart';
import 'package:hivet/core/network/network_utils.dart';

class OTPService extends BaseNetworks {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic> checkVerify() async {
    return await service.baseNetworks(
      HttpmethodEnum.get,
      CommonConstants.checkVerify,
      isToken: true,
    );
  }

  Future<dynamic> verifyPhone(Map<String, dynamic> body) async {
    return await service.baseNetworks(
        HttpmethodEnum.post, CommonConstants.verifyPhone,
        isToken: true, body: body);
  }

  Future<void> sendOTPFirebase(
      {required String phoneNumber,
      required Duration timeOut,
      required PhoneVerificationFailed phoneVerificationFailed,
      required PhoneVerificationCompleted phoneVerificationCompleted,
      required PhoneCodeSent phoneCodeSent,
      required PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout}) async {
    return await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: timeOut,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        codeAutoRetrievalTimeout: autoRetrievalTimeout);
  }
}
