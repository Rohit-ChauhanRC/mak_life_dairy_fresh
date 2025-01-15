import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mak_life_delivery/app/constants/colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0, bottom: 18.0),
        child: Form(
          key: controller.otpFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("assets/otp.png", width: 300, height: 260),
              const Text(
                "OTP Verification",
                style: TextStyle(
                    // color: textBarColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 30),
              ),
              const SizedBox(
                height: 10,
              ),
              RichText(
                textAlign: TextAlign.center,
                maxLines: 2,
                text: TextSpan(children: [
                  TextSpan(
                      text:
                          "We have sent a verification code to +91- ${controller.mobileNumber}",
                      style: const TextStyle(
                          color: blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  const TextSpan(
                      text: " Wrong Number?",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.w400))
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 26,
                ),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: const TextStyle(
                    color: textBarColor,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: false,
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "Enter 4-digit Code";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 60,
                    fieldWidth: 60,
                    activeColor: Colors.green,
                    inactiveColor: Colors.black,
                    selectedColor: Colors.green,
                  ),
                  cursorColor: textBarColor,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: false,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: textBarColor,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) async {
                    debugPrint("Completed $v");
                    if (v.length == 4) {
                      await controller.login();
                    }
                  },
                  onChanged: (val) async {
                    debugPrint(val);
                    controller.otp = val;
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    return true;
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(
                () => TextButton(
                    onPressed: controller.isResendEnabled.value
                        ? controller.resendOtp
                        : null,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.message,
                                  color: controller.isResendEnabled.value
                                      ? Colors.green
                                      : greyColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Resend SMS",
                                  style: TextStyle(
                                      color: controller.isResendEnabled.value
                                          ? Colors.green
                                          : Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            Text(
                              controller.timerValue.value > 0
                                  ? "00:${controller.timerValue.value.toString().padLeft(2, '0')}"
                                  : "",
                              style: TextStyle(
                                  color: controller.isResendEnabled.value
                                      ? Colors.green
                                      : greyColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                        Divider(
                          height: 1,
                          color: controller.isResendEnabled.value
                              ? Colors.green
                              : greyColor,
                          thickness: 1.8,
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
