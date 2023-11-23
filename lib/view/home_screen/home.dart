import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/home_controller.dart';
import 'package:emart_seller/view/home_screen/home_Screen.dart';
import 'package:emart_seller/view/order_screen/order_screen.dart';
import 'package:emart_seller/view/product_screen/product_screen.dart';
import 'package:emart_seller/view/profile_screen/profile_screen.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreen = [
      const HomeScreen(),
      const ProductScreen(),
      const OrderScreen(),
      const ProfileScreen()
    ];

    var bottomNavbar = [
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 20,
          ),
          label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            width: 24,
            // height: 50,
            color: darkGrey,
          ),
          label: products),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            width: 24,
            color: darkGrey,
            // height: 50,
          ),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSettings,
            width: 24,
            // height: 50,
            color: darkGrey,
          ),
          label: setting),
    ];

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false, //isase arrow remove ho jati h
      //   title: boldText(text: dashboard, color: fontGrey, size: 18.0),
      // ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType
                .fixed, //this property use karane ke bad label show hone lagati h
            selectedItemColor: purpleColor,
            unselectedItemColor: darkGrey,
            items: bottomNavbar,
            iconSize: 10,
          )),
      body: Column(children: [
        Obx(() =>
            Expanded(child: navScreen.elementAt(controller.navIndex.value))),
      ]),
    );
  }
}
