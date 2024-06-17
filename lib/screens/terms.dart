import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rosary/controllers/terms_controller.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/main_app_bar_widget.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/affirmation_controller.dart';
import '../controllers/dailyVerse_controller.dart';
import '../controllers/langauge_controller.dart';

class TermsScreen extends StatefulWidget {
  TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  var _termsController = Get.find<TermsController>();
  var _languageController = Get.find<LocalizationController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _termsController.getTerm(_languageController.selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: MainAppBarWidget(text: "EULA"),
      body: GetBuilder<TermsController>(builder: (data) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 50.h,
              ),
              data.hasTerms
                  ? Html(
                      data: data.termsModel.eula,
                      style: {
                        'p': Style(
                            fontSize: FontSize(18.sp), fontFamily: "Georgian"),
                        'ul': Style(
                            fontSize: FontSize(16.sp), fontFamily: "Georgian"),
                      },
                    )
                  : Container()
            ]),
          ),
        );
      }),
    );
  }
}
