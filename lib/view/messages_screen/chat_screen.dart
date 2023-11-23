import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/view/messages_screen/component/chat_bubble.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../widget/text_style.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkGrey,
            )),
        title: boldText(text: chats, size: 16.0, color: fontGrey),
        actions: [
          TextButton(
              onPressed: () {}, child: noramlText(text: save, color: fontGrey))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return ChatBubble();
                    })),
            10.heightBox,
            SizedBox(
              height: 60,
              child: Row(children: [
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Enter message",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: purpleColor,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: purpleColor))),
                )),
                IconButton(onPressed: () {}, icon: const Icon(Icons.send))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
