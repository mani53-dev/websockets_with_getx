// * Created by Affine Sol (PVT LTD) on 09/08/2024
// *
// * Website: https://affinesol.com/
// * Email: affinesol@gmail.com
// * Find our services on: https://www.fiverr.com/rehman_777

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingChat extends StatelessWidget {
  const ShimmerLoadingChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Get.theme.primaryColor.withOpacity(0.05),
      enabled: true,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ...List.generate(
              6,
              (index) => index % 2 == 0 ? ownMessage() : otherMessage(),
            ),
          ],
        ).marginOnly(top: 24),
      ),
    );
  }
}

Widget ownMessage() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: Get.width / 1.5,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.5),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 55.0,
              height: 13.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ).marginOnly(bottom: 10),
            Container(
              width: 135.0,
              height: 8.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ).marginOnly(bottom: 10),
            Container(
              width: 200.0,
              height: 8.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ).marginOnly(bottom: 12),
          ],
        ),
      ).marginOnly(right: 5),
      const CircleAvatar(
        radius: 18,
      )
    ],
  ).marginOnly(bottom: 24, right: 8);
}

Widget otherMessage() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const CircleAvatar(
        radius: 18,
      ).marginOnly(right: 5),
      Container(
        width: Get.width / 1.5,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.5),
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 55.0,
              height: 13.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ).marginOnly(bottom: 10),
            Container(
              width: 135.0,
              height: 8.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ).marginOnly(bottom: 10),
            Container(
              width: 200.0,
              height: 8.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
            ).marginOnly(bottom: 12),
          ],
        ),
      ).marginOnly(top: 8)
    ],
  ).marginOnly(bottom: 24, left: 8);
}
