import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vewww/core/components/custom_app_bar.dart';
import 'package:vewww/core/components/prev_req.dart';
import 'package:vewww/core/style/app_Text_Style/app_text_style.dart';

class PreviousReqScreen extends StatefulWidget {
  const PreviousReqScreen({super.key});

  @override
  State<PreviousReqScreen> createState() => _PreviousReqScreenState();
}

class _PreviousReqScreenState extends State<PreviousReqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            haveBackArrow: true,
            title: Text(
              'Previous Requests',
              style: AppTextStyle.mainStyle(size: 25),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => previousRequest(),
                separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                itemCount: 15),
          )
        ],
      ),
    );
  }
}
