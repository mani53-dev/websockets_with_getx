import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:websockets_with_getx/models/message.dart';

class OwnMessageBubble extends StatelessWidget {
  const OwnMessageBubble(
      {super.key,
      required this.message,
      this.isShowUserName = true,
      this.userNameColor = const Color(0xff614A5E)});
  final Message message;
  final bool isShowUserName;
  final Color userNameColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width / 1.5,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 10),
          decoration: const BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // if(Get.find<AuthService>().user.value.accountType == AccountType.company)
              if (isShowUserName)
                Text(
                  message.userName?.capitalizeFirst! ?? '',
                  style: TextStyle(
                    fontSize: 10,
                    color: Get.theme.primaryColor,
                  ),
                ).marginOnly(bottom: 5),

              Text(
                message.message!,
                style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black),
              ).marginOnly(bottom: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  DateFormat('HH:mm').format(message.timeStamp!),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      fontFamily: 'SF-Pro-Text',
                      color: Get.theme.primaryColor),
                ),
              ),
            ],
          ),
        ).marginOnly(right: 5),
        CircleAvatar(
          radius: 16,
          backgroundColor: Colors.grey,
          child: Image.asset(
            "assets/images/freelancer-image.png",
          ),
        ),
      ],
    );
  }
}
