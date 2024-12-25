import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController
{
  final  pageController = PageController().obs;


  @override
  void dispose() {
    pageController.value.dispose();
    super.dispose();
  }

  nextPage()
  {
    pageController.value.nextPage(
      duration: const Duration(milliseconds: 600),
     curve: Curves.ease,
     );
  }

  
}