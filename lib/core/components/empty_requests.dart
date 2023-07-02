import 'package:flutter/material.dart';

import '../style/app_Text_Style/app_text_style.dart';

class EmptyRequests extends StatelessWidget {
  const EmptyRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Image.asset(
          "assets/images/Empty.png",
          width: 300,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "لا يوجد لديك طلبات نقل الآن\n يمكنك الإنتظار لحين وصول طلب",
          textDirection: TextDirection.rtl,
          style: AppTextStyle.lightGrayTextStyle(25),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
