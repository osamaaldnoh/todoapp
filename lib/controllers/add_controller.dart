import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:todoapp/model/task.dart';

import '../res/appcolor.dart';

class AddController extends GetxController
{
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  RxString startTime = ''.obs;
  RxString finishTime = ''.obs;
  RxString selectDate = ''.obs;

  RxList<int> notification = RxList<int>(); 


  showDatePicker({required BuildContext context})
  {
    picker.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2023, 6, 1),
                      maxTime: DateTime(2025, 6, 1),
                      theme:const picker.DatePickerTheme(
                          doneStyle:
                              TextStyle(color: AppColors.kGreen, fontSize: 16)),
                       onConfirm: (date) {
                        selectDate.value = date.toString().substring(0,10);
                    print('confirm $date');
                  }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
                     
  }

  showDateTimePicker({required BuildContext context,bool? start = true}){
    picker.DatePicker.showDateTimePicker(context,
                      showTitleActions: true, 
                       onConfirm: (date) {
                        start == true ? startTime.value = date.toString().substring(10,16):
                    finishTime.value = date.toString().substring(10,16);
                    notification.value = dates(date);
                  }, locale: picker.LocaleType.en);      
  }

  isEditTasks({required bool isEdit,required Task task})
   {
     if(isEdit)
     {
      title.text = task.title!;
      desc.text = task.desc!;
      selectDate.value = task.date!;
      startTime.value = task.startTime!;
      finishTime.value = task.endTime!;
     }
   }
   
   List<int> dates (DateTime startDate)
   {
    DateTime now = DateTime.now();
    Duration difference = startDate.difference(now);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return [days, hours, minutes, seconds];
   }
   
   } 