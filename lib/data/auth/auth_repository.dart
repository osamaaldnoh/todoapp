import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/user_controller.dart';
import 'package:todoapp/model/user_model.dart';
import 'package:todoapp/utils/routes/route_name.dart';
import 'package:todoapp/utils/show_dialog.dart';
import 'package:todoapp/view/otp/otp_view.dart';

class AuthRepository
{
  //  final FirebaseAuth auth;
   final UserController userController = Get.find();
   
    RxString smsId = ''.obs;

  //  AuthRepository({required this.auth});

   Future<void> verifyOtp({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
   })
   async
   {
    final auth = FirebaseAuth.instance;
    try
    {
      final credential = PhoneAuthProvider.credential(
        verificationId: smsCodeId,
        smsCode: smsCode);

       await auth.signInWithCredential(credential);
       if(mounted == false)
       {
        return;
       }
       Get.offNamedUntil(RouteName.homeView, (route) => false,);
    }
    on FirebaseAuth catch(e)
    {
      showAlertDialoge(context: context, message: e.toString());
    }

   }

// Future<void> signInWithPhoneNumber(String phoneNumber) async {
//     await auth.verifyPhoneNumber(
//       phoneNumber: phoneNumber,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // await auth.signInWithCredential(credential);
//         // authentication successful, do something
//         print("authentication successful, do something22222222222");
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         // authentication failed, do something
//         print("authentication failed, do something:   ${e.toString()}");
//       },
//       codeSent: (String verificationId, int? resendToken) async {
//         // code sent to phone number, save verificationId for later use
//         String smsCode = ''; // get sms code from user
//         PhoneAuthCredential credential = PhoneAuthProvider.credential(
//           verificationId: verificationId,
//           smsCode: smsCode,
//         );
//         Get.toNamed(RouteName.otpView, arguments: {
//             'phone': verificationId,
//             'smsCodeId': smsCode
//           }
//    );
//    print("authentication successful, do something");
//         // await auth.signInWithCredential(credential);
//         // authentication successful, do something
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }
  Future<void> sendOtp({
    required BuildContext context,
    required String phone,
  })
  async
  {
    final auth = FirebaseAuth.instance;
   try
   {

    print("Phone:::::::::::::::$phone");
     await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async{
        await auth.signInWithCredential(credential);
        // print("credential             :${credential.accessToken.toString()}");
        
      },
       verificationFailed: (FirebaseAuthException e)
       {
        // print("ERORR             :${e.toString()}");
        showAlertDialoge(context: context, message: e.toString(),);
       },
        codeSent: (String smsCodeId,[int? reSendCodeId])
        async{
          String smsCode = '';
           smsId.value = smsCodeId;
          UserModel userModel = UserModel(id: 1, isVerified: 1);
          userController.addUser(userModel);
          //  PhoneAuthCredential credential = PhoneAuthProvider
          //  .credential(verificationId: smsCodeId, smsCode: smsCode);

          // await auth.signInWithCredential(credential);
          Get.offNamedUntil(RouteName.otpView,
          arguments: {
            'phone': phone,
            'smsCodeId':smsId.value
          },
          (route) => false,
           );
          print("credential:::::::::::::::::::::::${smsCodeId}");
        },
         codeAutoRetrievalTimeout: (String codeTimeout)
         {
            smsId.value = codeTimeout;
         },
        //  timeout: const Duration(seconds: 120)
         );
  
   }
  on FirebaseAuth catch (e)
   {
    showAlertDialoge(context: context, message: e.toString());
   }
   }
}