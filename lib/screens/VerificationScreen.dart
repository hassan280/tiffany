import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../models/User.dart';
import '../providers/IndexProvider.dart';
import '../providers/UserProvider.dart';
import '../services/Services.dart';
import '../services/SqlService.dart';
import '../translations/locale_keys.g.dart';

class VerificationScreen extends StatefulWidget {
  final String? phoneNumber;
  GlobalKey<NavigatorState> screen;

  VerificationScreen({
    required this.screen,
    Key? key,
    this.phoneNumber,
  }) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  // ignore: close_sinks
  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Color(0xffD8AA6B),
                                    behavior: SnackBarBehavior.floating,
                                    content: Text(
                                      message!,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
    
  }

  @override
  Widget build(BuildContext context) {
    var sqlService = SqlService();
    UserProvider userProvider = Provider.of<UserProvider>(context);
    IndexProvider indexProvider = Provider.of<IndexProvider>(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                height: 13.h,
                width: 100.w,
                decoration: BoxDecoration(color: Colors.white),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      // color: Colors.blue,
                      //  height: 15.h,
                      width: 100.w,
                      child: Image.asset(
                        'assets/images/appbarback.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    AppBar(
                      title: InkWell(
                        onTap: () {},
                        child: Text(
                          LocaleKeys.SignIn.tr(),
                          style: TextStyle(
                              color: Color(0xff73BFBD), fontSize: 10.sp),
                        ),
                      ),
                      leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Color(0xff73BFBD),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      elevation: 0,
                      brightness: Brightness.light,
                      backgroundColor: Color.fromARGB(0, 250, 249, 249),
                    )
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 0.sp, bottom: 15.sp),
                  child: Column(
                    children: [
                      // const SizedBox(height: 30),
                      SizedBox(
                        height: 25.h,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset("assets/images/Logo.png"),
                        ),
                      ),
                      const SizedBox(height: 8),
                       Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          LocaleKeys.PhoneNumberVerification.tr(),
                          style: TextStyle(
                            color: Color(0xff73BFBD),
                              fontWeight: FontWeight.bold, fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                        color:Color(0xffA7A7A7),
                                        
                                        fontSize: 15),
                              text: LocaleKeys.Enterthecodesent.tr(),
                              children: [
                                TextSpan(
                                    text: "${widget.phoneNumber}",
                                    style: const TextStyle(
                                        color: Color(0xffD8AA6B),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ],
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: formKey,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 30),
                            child: PinCodeTextField(
                              textStyle: TextStyle(color: Colors.white),
                              errorTextSpace: 25,
                              appContext: context,
                              pastedTextStyle: TextStyle(
                                color: Color(0xff73BFBD),
                                fontWeight: FontWeight.bold,
                              ),
                              length: 4,
                              obscureText: true,
                             
                              blinkWhenObscuring: true,
                              animationType: AnimationType.fade,
                              validator: (v) {
                                if (v!.length < 4) {
                                  return LocaleKeys.Enterfourdigitcode.tr();
                                } else {
                                  return null;
                                }
                              },
                              pinTheme: PinTheme(
                                borderWidth: 0,
                                selectedFillColor: Color(0xff73BFBD),
                                disabledColor: Color(0xffD8AA6B),
                                errorBorderColor: Color(0xffD8AA6B),
                                selectedColor: Color(0xff73BFBD),
                                activeFillColor: Color(0xff73BFBD),
                                activeColor: Color(0xff73BFBD),
                                inactiveFillColor: Color(0xffD8AA6B),
                                shape: PinCodeFieldShape.box,
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                // activeFillColor: Colors.white,
                              ),
                              cursorColor: Colors.black,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              enableActiveFill: true,
                              errorAnimationController: errorController,
                              controller: textEditingController,
                              keyboardType: TextInputType.number,
                              boxShadows: const [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black12,
                                  blurRadius: 10,
                                )
                              ],
                              onCompleted: (v) {
                                
                              },
                             
                              onChanged: (value) {
                               
                                setState(() {
                                  currentText = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                
                               
                                return true;
                              },
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          hasError
                              ? LocaleKeys.Pleasefillcells.tr()
                              : "",
                          style: const TextStyle(
                              // color: Color(0xff73BFBD),
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
    
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 1.h, horizontal: 10.w),
                        decoration: BoxDecoration(
                            color: Color(0xff73BFBD),
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 193, 228, 227),
                                  offset: const Offset(1, -2),
                                  blurRadius: 5),
                              BoxShadow(
                                  color: Color.fromARGB(255, 193, 228, 227),
                                  offset: const Offset(-1, 2),
                                  blurRadius: 5)
                            ]),
                        child: ButtonTheme(
                          height: 50,
                          child: TextButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                showGeneralDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return SafeArea(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height,
                                        padding: EdgeInsets.all(20),
                                        color: Colors.transparent,
                                        child: Center(
                                          child: SpinKitWave(
                                            // duration: const Duration(seconds: 10),
                                            color: Color(0xff73BFBD),
                                            size: 50.0,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                                Response response = await verifyPhone(
                                    widget.phoneNumber!, int.parse(currentText));
                                print(response.statusCode);
    
                                if (response.statusCode == 200) {
                                  // print(response.data['data']);
                                  sqlService.saveUser(
                                      User.fromJson(response.data['data']),
                                      userProvider);
                                  Navigator.of(context, rootNavigator: true)
                                          .canPop()
                                      ? Navigator.of(context, rootNavigator: true)
                                          .pop()
                                      : null;
                                  snackBar(LocaleKeys.Youareconnected.tr(),);
                                 
                                    Navigator.of(context, rootNavigator: true)
                                        .popUntil((route) => route.isFirst);
                                
    
                                  indexProvider.setCurrentIndex(2);
                                } else {
                                  Navigator.of(context, rootNavigator: true)
                                          .canPop()
                                      ? Navigator.of(context, rootNavigator: true)
                                          .pop()
                                      : null;
                                  snackBar(
                                      LocaleKeys.somethingwrongagain.tr(),);
                                }
                               
                              }
                            },
                            child: Center(
                                child: Text(
                              LocaleKeys.VERIFY.tr().toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                          child: TextButton(
                        child:  Text(
                          LocaleKeys.Clear.tr(),
                          style: TextStyle(
                            color: Color(0xffD8AA6B),
                          ),
                        ),
                        onPressed: () {
                          textEditingController.clear();
                        },
                      )),
                      
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
