import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';
import '../../widgets/on_boarding_page.dart';
import 'first_on_boarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboarding/OnBoarding_2.png",
      "title": "Discover Movies",
      "desc":
          "Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease."
    },
    {
      "image": "assets/images/onboarding/OnBoarding_3.png",
      "title": "Explore All Genres",
      "desc":
          "Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day."
    },
    {
      "image": "assets/images/onboarding/OnBoarding_4.png",
      "title": "Create Watchlists",
      "desc":
          "Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres."
    },
    {
      "image": "assets/images/onboarding/OnBoarding_5.png",
      "title": "Rate, Review, and Learn",
      "desc":
          "Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews."
    },
    {
      "image": "assets/images/onboarding/OnBoarding_6.png",
      "title": "Start Watching Now",
    },
  ];

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToPreviousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _finishOnboarding() {
    //todo: navigate to auth screen
    Navigator.pushNamed(context, AppRoutes.registerRoute);
  }

  void _skip() {
    debugPrint("Skip Onboarding");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: [
          FirstOnboardingPage(onNext: _goToNextPage),
          ...onboardingData.asMap().entries.map((entry) {
            int index = entry.key;
            var item = entry.value;
            bool isLast = index == onboardingData.length - 1;
            bool isSecond = index == 0; //  لأن دي أول صفحة بعد الأولى الخاصة

            return OnboardingPage(
              image: item["image"]!,
              title: item["title"]!,
              desc: item["desc"],
              onNext: isLast ? _finishOnboarding : _goToNextPage,
              onSkip: _skip,
              isLast: isLast,
              isSecond: isSecond,
              onBack: index > 0 ? _goToPreviousPage : null, // لو مش التانية
            );
          }),
        ],
      ),
    );
  }
}
