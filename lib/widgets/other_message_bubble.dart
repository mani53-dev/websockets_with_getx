import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websockets_with_getx/models/message.dart';

class OtherMessageBubble extends StatelessWidget {
  const OtherMessageBubble(
      {super.key,
      required this.message,
      this.isShowUserName = true,
      this.userNameColor = Colors.white});
  final Message message;
  final bool isShowUserName;
  final Color userNameColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          child: Image.asset(
            "assets/images/freelancer-image.png",
          ),
        ).marginOnly(right: 5),
        Container(
          width: Get.width / 1.5,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 10),

          // padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isShowUserName)
                Text(
                  message.userName?.capitalizeFirst! ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      fontFamily: 'SF-Pro-Text',
                      color: Colors.white),
                ).marginOnly(bottom: 5),
              Text(
                message.message!,
                style: const TextStyle(
                    // fontWeight: FontWeight.w400,
                    fontSize: 14,
                    // fontFamily: 'SF-Pro-Text',
                    color: Colors.white),
              ).marginOnly(bottom: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat('HH:mm').format(message.timeStamp!),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      fontFamily: 'SF-Pro-Text',
                      color: Colors.white),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
