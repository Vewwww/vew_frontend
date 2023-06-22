import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vewww/core/style/app_colors.dart';
import 'package:vewww/core/utils/sp_helper/cache_helper.dart';
import 'package:vewww/views/driver/sign_up_screen.dart';
import '../../bloc/onboarding_cubit/onboarding_cubit.dart';
import '../../core/style/app_Text_Style/app_text_style.dart';
import '../../model/onboarding_content.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _controller;
  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    OnboardingCubit pageCubit = OnboardingCubit.get(context);

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            physics: const ClampingScrollPhysics(),
            controller: _controller,
            onPageChanged: (index) {
              pageCubit.changeIndex(index);
            },
            itemCount: content.length,
            itemBuilder: (context, index) => Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Expanded(
                      flex: 2,
                      child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Image.asset(content[index].imagePath))),
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(40)),
                        gradient: LinearGradient(
                            tileMode: TileMode.repeated,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              mainColor,
                              mainColor.withOpacity(0.8),
                              const Color.fromARGB(255, 6, 190, 178),
                            ]),
                      ),
                      child: Center(
                        child: Text(
                          content[index].description,
                          style: AppTextStyle.whiteTextStyle(28),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            child: BlocConsumer<OnboardingCubit, OnboardingState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          content.length,
                          (index) => Container(
                                margin: const EdgeInsets.all(3),
                                height: 10,
                                width: pageCubit.pageIndex == index ? 20 : 10,
                                decoration: BoxDecoration(
                                    color: pageCubit.pageIndex == index
                                        ? const Color.fromARGB(
                                            186, 255, 255, 255)
                                        : const Color.fromARGB(
                                            255, 140, 202, 180),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                              )),
                    ),
                    (pageCubit.pageIndex == content.length - 1)
                        ? const SizedBox(height: 10)
                        : Container(),
                    (pageCubit.pageIndex == content.length - 1)
                        ? OutlinedButton(
                            onPressed: () {
                              SharedPreferencesHelper.saveData(key: "vewwwIsFirst", value: false);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()),
                                  (route) => true);
                            },
                            child: Text("   Sign Up Now   ",
                                style: AppTextStyle.whiteTextStyle(18)),
                          )
                        : Container(),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
