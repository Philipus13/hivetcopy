import 'package:firebase_auth/firebase_auth.dart';
import 'package:hivet/core/config/common_constant.dart';
import 'package:hivet/core/network/base_network.dart';
import 'package:hivet/core/network/network_utils.dart';

class ForgotService extends BaseNetworks {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<dynamic> forgotbyEmail(Map<String, dynamic> body) async {
    return await service.baseNetworks(
        HttpmethodEnum.post, CommonConstants.passwordRecoveryEmail,
        isToken: false, body: body);
  }

  Future<dynamic> forgotbyPhone(Map<String, dynamic> body) async {
    return await service.baseNetworks(
        HttpmethodEnum.post, CommonConstants.passwordRecoveryByPhone,
        isToken: false, body: body);
  }

  Future<dynamic> submitChangePass(Map<String, dynamic> body) async {
    return await service.baseNetworks(
        HttpmethodEnum.post, CommonConstants.resetPassword,
        isToken: false, body: body);
  }

  Future<void> sendForgotFirebase(
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
