import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/controller/orders_controller.dart';
import 'package:emart_seller/view/order_screen/component/order_place.dart';
import 'package:emart_seller/widget/our_button.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart' as intl;
import '../../widget/text_style.dart';

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrdersController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.onDelivered.value = widget.data['order_on_delivered'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: darkGrey,
                )),
            title: boldText(text: "Order Details", size: 16.0, color: fontGrey),
          ),
          bottomNavigationBar: Visibility(
              //Visibility ka use hamlog any widget ko show bhi kar sakate h aur show nahi bhi kar skate h
              visible: !controller.confirmed.value,
              child: SizedBox(
                height: 60,
                width: context.screenWidth,
                child: ourButton(
                    color: green,
                    onPress: () {
                      controller.confirmed(true);
                      controller.changeStatus(
                          title: "order_confirmed",
                          status: true,
                          docID: widget.data.id);
                      print("/////////////////////docId");
                      print(widget.data.id);
                    },
                    title: "Confirm Button"),
              )),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Column(
                    children: [
                      //order delivery status section
                      Visibility(
                        // visible: false,
                        visible: controller
                            .confirmed //here controller.confirmed.value ki value false h since jo bahi cheaje likhi hogi vo show mahi hoga
                            .value, //jab seller pahali bar Order details open karega to use button show hoga
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldText(
                                text: "Order Status",
                                color: purpleColor,
                                size: 16.0),
                            SwitchListTile(
                              activeColor: Colors.green,
                              value: true,
                              onChanged: (Value) {},
                              title: boldText(text: "Placed", color: fontGrey),
                            ),
                            SwitchListTile(
                              activeColor: Colors.green,
                              value: controller.confirmed.value,
                              onChanged: (Value) {
                                controller.confirmed.value = Value;
                              },
                              title:
                                  boldText(text: "Confirmed", color: fontGrey),
                            ),
                            SwitchListTile(
                              activeColor: Colors.green,
                              value: controller.onDelivered.value,
                              onChanged: (Value) {
                                controller.onDelivered.value = Value;
                                controller.changeStatus(
                                    title: "order_on_delivered",
                                    status: Value,
                                    docID: widget.data.id);
                              },
                              title: boldText(
                                  text: "on Delivery", color: fontGrey),
                            ),
                            SwitchListTile(
                              activeColor: Colors.green,
                              value: controller.delivered.value,
                              onChanged: (Value) {
                                controller.delivered.value = Value;
                                controller.changeStatus(
                                    title: "order_delivered",
                                    status: Value,
                                    docID: widget.data.id);
                              },
                              title:
                                  boldText(text: "Delivered", color: fontGrey),
                            )
                          ],
                        )
                            .box
                            .padding(const EdgeInsets.all(8))
                            .outerShadowMd
                            .white
                            .border(color: lightGrey)
                            .roundedSM
                            .make(),
                      ),

                      //order details section
                      orderPlaceDetails(
                          title1: "Order_code",
                          title2: "Shipping_method",
                          d1: "${widget.data['order_code']}",
                          d2: "${widget.data['sipping_method']}"),
                      orderPlaceDetails(
                          title1: "Order_date",
                          title2: "Payment_method",
                          d1: intl.DateFormat()
                              .add_yMd()
                              .format((widget.data['order_date'].toDate())),
                          d2: "${widget.data['payment_method']}"),
                      orderPlaceDetails(
                          title1: "Payment_status",
                          title2: "Delivery_status",
                          d1: "Unpaid",
                          d2: "Order Placed"),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Shipping Address".text.color(darkGrey).make(),
                                "${widget.data['order_by_name']}".text.make(),
                                "${widget.data['order_by_email']}".text.make(),
                                "${widget.data['order_by_address']}"
                                    .text
                                    .maxLines(4)
                                    .make(),
                                "${widget.data['order_by_city']}".text.make(),
                                "${widget.data['order_by_state']}".text.make(),
                                "${widget.data['order_by_phone']}".text.make(),
                                "${widget.data['order_by_postalcode']}"
                                    .text
                                    .make(),
                              ],
                            ),
                            SizedBox(
                                width: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "Total Amount".text.color(darkGrey).make(),
                                    "${widget.data['total_amount']}"
                                        .numCurrency
                                        .text
                                        .make(),
                                  ],
                                )),
                          ],
                        ),
                      )
                    ],
                  )
                      .box
                      .outerShadowMd
                      .white
                      .border(color: lightGrey)
                      .roundedSM
                      .make(),
                  Divider(),
                  10.heightBox,
                  "Ordered Product"
                      .text
                      .size(16)
                      .color(darkGrey)
                      .makeCentered(),
                  10.heightBox,
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(controller.orders.length, (index) {
                      //List ham log children ke place per hi generate karate h
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderPlaceDetails(
                              title1:
                                  "${widget.data['orders'][index]['title']}",
                              title2:
                                  "\$${controller.orders[index]['total_price']}",
                              d1: "${controller.orders[index]['quantity']}x",
                              d2: "Refundable"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: 30,
                              height: 20,
                              color: Color(controller.orders[index]['colors']),
                            ),
                          ),
                          Divider()
                        ],
                      );
                    }).toList(), //vapas se list me convert kar sake usi ke liye use karate h
                  )
                      .box
                      .outerShadowMd
                      .margin(EdgeInsets.only(bottom: 4))
                      .white
                      .make(),
                  20.heightBox,
                ],
              ),
            ),
          ),
        ));
  }
}
