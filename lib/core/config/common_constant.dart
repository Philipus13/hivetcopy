import 'dart:ui';

class CommonConstants {
  // Base URL

  // static final String baseUrlProd = 'jsonplaceholder.typicode.com';
  // static final String baseUrlDev = 'jsonplaceholder.typicode.com';
  // static final String baseUrlQA = 'jsonplaceholder.typicode.com';

  static final String baseUrlProd = 'hivet.id';
  static final String baseUrlDev = 'hivet.id';
  static final String baseUrlQA = 'hivet.id';

  /**
   * Authentication URL
   */

  static final String registerUser = '/api/v1/oauth2/register';
  static final String loginUser = '/api/v1/oauth2/token';
  static final String checkToken = '/api/v1/oauth2/tokeninfo';

  static final String refreshToken = '/api/v1/auth/refresh-token';
  static final String googleLogin = '/api/v1/auth/google/';
  static final String appleLogin = '/api/v1/auth/apple/';

  static final String passwordRecoveryEmail =
      '/api/v1/oauth2/password-recovery/';
  static final String passwordRecoveryByPhone =
      '/api/v1/oauth2/password-recovery-phone/';
  static final String resetPassword = '/api/v1/oauth2/reset-password';
  static final String verifyPhone = '/api/v1/oauth2/verify';
  static final String checkVerify = '/api/v1/oauth2/check-verify';
  static final String changePassword = '/api/v1/oauth2/change-password';
  // static final String setFCM = '/api/v1/auth/register-fcm';

  /**
   * Profile Url
   */
  static final String getUserProfiles = '/api/v1/user/get/profile';
  static final String postUserProfile = '/api/v1/user/update/profile';

  /**
   * Slot Url
   */
  static final String slotUser = '/api/v1/slot/user';
  static final String slotDoctor = '/api/v1/slot/doctor';
  static final String activatingSlot = '/api/v1/slot/activate';

  /**
   * Admission Url
   */
  static final String admissionCreate = '/api/v1/admission/create';
  static final String slotDoctor = '/api/v1/slot/doctor';
  static final String activatingSlot = '/api/v1/slot/activate';

  /**
   * Address Url
   */
  static final String getAddress = '/api/v1/address';
  static final String patchAdresses = '/api/v1/address';
  static final String postAdresses = '/api/v1/address';
  static final String deleteAddresses = '/api/v1/address';
  static final String activatingAddress = '/api/v1/address/activate';

  /**
   * Master data url
   */
  static final String getMaster = '/api/v1/master';
  static final String getMasterUser = '/api/v1/master/user';
  static final String getMasterPolis = '/api/v1/m/poli';
  static final String getMasterProcedures = '/api/v1/m/procedure';

  /**
   * MethodLogin
   */
  static final String methodGoogle = 'google';
  static final String methodApple = 'apple';
  static final String methodEmail = 'email';
  static final String methodFinger = 'finger';
  static final String methodQr = 'qr';

  /**
   * Routing constant
   */

  static const String routeInit = '/';
  static const String routeHome = '/home';
  static const String routeSignIn = '/sign_in';
  static const String routeRegister = '/register';
  static const String routeUpdateProfil = '/edit_profil';
  static const String routeAdress = '/address';
  static const String routeAddAdress = '/add_address';
  static const String routeComingSoon = '/coming_soon';
  static const String routetnc = '/tnc';
  static const String routeOTP = '/otp';
  static const String routeForgot = '/forgot';
  static const String routeReservation = '/reservation';
  static const String routeReservationDetail = '/reservation_detail';
  static const String routeReservationSuccess = '/reservation_success';
  static const String routeReservationDetailSummary =
      '/reservation_detail_summary';
  static const String routeReservationDetailAgreement =
      '/reservation_detail_agreement';

  // Dictionary of APPS

  // Scopes of user
  static const String doctor = 'dokterHewan';
  static const String toko = 'toko';
  static const String pengguna = 'pengguna';
  static const String guest = 'guest';

  // Type Slot
  static const String weekly = 'weekly';
  static const String flexible = 'flexible';

  static const List<Color> gradientColors = [
    Color.fromARGB(255, 229, 232, 247),
    Color.fromARGB(255, 224, 241, 250)
  ];
}
