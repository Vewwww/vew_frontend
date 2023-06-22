class OnboardingContent {
  String imagePath;
  String description;

  OnboardingContent({
    required this.imagePath,
    required this.description,
  });
}

List<OnboardingContent> content = [
  OnboardingContent(
    imagePath: "assets/images/Logo.png",
    description: "A perfect solution\for your car\nproblem",
  ),
  OnboardingContent(
    imagePath: "assets/images/onBoarding1.png",
    description: "Find the nearest\nand the best place \nto fix your car",
  ),
  OnboardingContent(
    imagePath: "assets/images/onboarding2.png",
    description: "Make your workshop or \nservices discoverable",
  ),
  OnboardingContent(
    imagePath: "assets/images/profit.png",
    description: "Grow your buisness",
  ),
  OnboardingContent(
    imagePath: "assets/images/onboarding3.png",
    description: "Guarantee safe\ncommunication",
  ),
];
