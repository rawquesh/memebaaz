import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meme_baaz/constant/style.dart';
import 'package:meme_baaz/models/content.dart';

import 'controller.dart';

class ContentButtonsAdmin extends StatelessWidget {
  final ContentModel content;
  const ContentButtonsAdmin({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ContentPageAdminController>();
    Expanded _makeItVerified() {
      return Expanded(
        child: OutlinedButton(
          onPressed: () => c.changeStatus(content.id!, ContentStatus.verified),
          child: Text('Make it verified', style: ptSansFont().copyWith(color: Colors.green.shade600, fontWeight: FontWeight.w500)),
        ),
      );
    }

    Expanded _putOnHold() {
      return Expanded(
        child: OutlinedButton(
          onPressed: () => c.changeStatus(content.id!, ContentStatus.hold),
          child: Text('Put on hold', style: ptSansFont().copyWith(color: Colors.red.shade600, fontWeight: FontWeight.w500)),
        ),
      );
    }

    return Row(
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (content.status == ContentStatus.verified)
          _putOnHold()
        else if (content.status == ContentStatus.pending) ...[
          _makeItVerified(),
          sizedBoxW(10),
          _putOnHold(),
        ] else if (content.status == ContentStatus.hold) ...[
          _makeItVerified(),
          sizedBoxW(10),
          Expanded(
            child: OutlinedButton(
              onPressed: () => c.deleteDocForver(content.id!),
              child: Text('Delete forver', style: ptSansFont().copyWith(color: Colors.red.shade800, fontWeight: FontWeight.w500)),
            ),
          )
        ],
      ],
    );
  }
}
