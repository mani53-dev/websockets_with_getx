import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageInputField extends StatelessWidget {
  MessageInputField({
    super.key,
    required this.sendMessageCallback,
    required this.messageController,
  });

  GestureTapCallback sendMessageCallback;
  TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25),
            topLeft: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
                color: Get.theme.primaryColor.withOpacity(0.15),
                offset: const Offset(0, -5),
                blurRadius: 30)
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInputField(),
              _buildSendButton(),
            ],
          ).marginOnly(right: 24, left: 24),
        ],
      ),
    );
  }

  Expanded _buildInputField() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(),
        ],
      ),
    );
  }

  GestureDetector _buildSendButton() {
    return GestureDetector(
      onTap: sendMessageCallback,
      child: Container(
        height: 33,
        width: 33,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: const Center(child: Icon(Icons.send, size: 18,)),
      ).marginOnly(top: 25),
    );
  }

  Expanded _buildTextField() {
    return Expanded(
      flex: 5,
      child: TextFormField(
        key: key,
        controller: messageController,
        style: Get.textTheme.labelMedium!.copyWith(
          color: Colors.black.withOpacity(0.8),
          // color: const Color(0xff626261),
        ),
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        autocorrect: false,
        cursorColor: Get.theme.primaryColor,
        decoration: _buildInputDecoration(),
        onTapOutside: (_) {
          FocusScope.of(Get.context!).unfocus();
        },
        textInputAction: TextInputAction.send,
        onFieldSubmitted: (_) => sendMessageCallback,
        minLines: 1,
        maxLines: 10,
        expands: false,
      ).marginOnly(top: 15),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      hintText: "Type message".tr,
      hintStyle: Get.textTheme.labelMedium!.copyWith(
        color: const Color(0xff626261),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      contentPadding: const EdgeInsets.all(0),
      border: const OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      errorText: "",
      errorStyle: Get.textTheme.bodySmall!.copyWith(
        color: const Color(0XFFEC1A1A),
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
    );
  }

}
