import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/controller/authController.dart';
import 'package:emart_seller/view/home_screen/home.dart';
import 'package:emart_seller/widget/loading_indicator.dart';
import 'package:emart_seller/widget/our_button.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.heightBox,
            noramlText(text: welcome, size: 18.0),
            20.heightBox,
            Row(
              children: [
                Image.asset(
                  icLogo,
                  width: 70,
                  height: 70,
                )
                    .box
                    .border(color: white)
                    .rounded
                    .padding(EdgeInsets.all(8))
                    .make(),
                10.widthBox,
                boldText(text: appname, size: 18.0),
              ],
            ),
            40.heightBox,
            noramlText(text: loginTo, size: 18.0, color: lightGrey),
            10.heightBox,
            Obx(
              () => Column(
                children: [
                  TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      fillColor: textfieldGrey,
                      filled: true,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.email,
                        color: purpleColor,
                      ),
                      hintText: emailHint,
                    ),
                  ),
                  10.heightBox,
                  TextFormField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: textfieldGrey,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: purpleColor,
                      ),
                      hintText: passHint,
                    ),
                  ),
                  10.heightBox,
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: noramlText(
                              text: forgotPassword, color: purpleColor))),
                  20.heightBox,
                  SizedBox(
                      width: context.screenWidth - 100,
                      child: controller.isloading.value
                          ? LoadingIndicator()
                          : ourButton(
                              title: login,
                              onPress: () async {
                                controller.isloading(true);
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: loggedIn);
                                    controller.isloading(false);
                                    Get.offAll(() =>
                                        Home()); //if error nahi ata h to hamlog home page per chale jayenge

                                  } else {
                                    controller.isloading(
                                        false); //if any error ata h to again ham loginPage a jayenge
                                  }
                                });
                              }))
                ],
              )
                  .box
                  .rounded
                  .white
                  .outerShadowMd
                  .padding(const EdgeInsets.all(8))
                  .make(),
            ),
            10.heightBox,
            Center(
                child: noramlText(
              text: anyProblem,
              color: lightGrey,
            )),
            const Spacer(),
            Center(child: boldText(text: credit)),
            20.heightBox,
          ],
        ),
      )),
    );
  }
}
