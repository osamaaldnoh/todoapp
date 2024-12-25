import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin
{
  TextEditingController searchController = TextEditingController();
  RxBool isExpansionChange = false.obs;
  RxBool isExpansionChange1 = false.obs;
  late final TabController tabController = TabController(
    length: 2,
   vsync: this);

}