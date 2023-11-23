import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/view/messages_screen/chat_screen.dart';
import 'package:emart_seller/widget/custom_textfiled.dart';
import 'package:emart_seller/widget/loading_indicator.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart' as intl;
import '../../widget/text_style.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: darkGrey,
              )),
          title: boldText(text: shopSetting, size: 16.0),
          actions: [
            // TextButton(onPressed: () {}, child: noramlText(text: save))
          ],
        ),
        body: StreamBuilder(
            stream: StoreServices.getMassage(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return LoadingIndicator();
              } else {
                var data = snapshot.data!.docs;
                print(data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                      child: Column(
                          children: List.generate(data.length, (index) {
                    var t = data[index]['created_on'] == null
                        ? DateTime.now()
                        : data[index]['created_on'].toDate();
                    var time = intl.DateFormat("h:mma").format(t);
                    return ListTile(
                      onTap: () {
                        Get.to(() => const ChatScreen());
                      },
                      leading: const CircleAvatar(
                        backgroundColor: purpleColor,
                        child: Icon(
                          Icons.person,
                          color: white,
                        ),
                      ),
                      title: boldText(
                          text: "${data[index]['sender_name']}",
                          color: fontGrey),
                      subtitle: noramlText(
                          text: "${data[index]['last_msg']}", color: fontGrey),
                      trailing: noramlText(text: time, color: darkGrey),
                    );
                  }))),
                );
              }
            }));
  }
}
