import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rosary/model/font_size_model.dart';
import 'package:rosary/utils/appColor.dart';
import 'package:rosary/widgets/main_text.dart';

import '../controllers/dailyReading_controller.dart';
import '../controllers/langauge_controller.dart';
import 'ad_mob_banner.dart';

class DailyReadingScreen extends StatefulWidget {
  DailyReadingScreen({super.key});

  @override
  State<DailyReadingScreen> createState() => _DailyReadingScreenState();
}

class _DailyReadingScreenState extends State<DailyReadingScreen> {
  var _dailyReadingController = Get.find<DailyReadingController>();
  var _languageController = Get.find<LocalizationController>();
  double headerOne = 28.sp;
  double headerTwo = 15.sp;
  double headerThree = 14.sp;
  double paragraph = 16.sp;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(microseconds: 100), () {
      _dailyReadingController.getFontSizeCache();
      _dailyReadingController.getReading(_languageController.selectedIndex);
    });
  }

  final List<double> _fontSizes = [
    12.0,
    14.0,
    16.0,
    18.0,
    20.0,
    22.0,
    24.0,
    26.0,
    28.0,
    30.0
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyReadingController>(
      builder: (reading) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
                actions: [
                  PopupMenuButton<double>(
                    icon: Icon(Icons.format_size,
                        color: Colors.white, size: 30.r),
                    onSelected: (double selectedFontSize) {
                      _dailyReadingController.saveFontSizeCache(
                        FontSizeModel(
                          headerOne: (selectedFontSize * 1.5).toString(),
                          headerTwo: (selectedFontSize * 1.3).toString(),
                          headerThree: selectedFontSize.toString(),
                          paragraph: selectedFontSize.toString(),
                        ),
                      );
                      // setState(() {
                      //   headerThree = selectedFontSize;
                      //   headerOne = selectedFontSize * 2;
                      //   headerTwo = selectedFontSize * 1.3;
                      //   paragraph = selectedFontSize;
                      // });
                    },
                    itemBuilder: (BuildContext context) {
                      return _fontSizes.map((double fontSize) {
                        return PopupMenuItem<double>(
                          value: fontSize,
                          child: Row(
                            children: [
                              Text(
                                '${fontSize.toStringAsFixed(1)}',
                                style: TextStyle(fontSize: fontSize),
                              ),
                              if (fontSize ==
                                  double.parse(
                                    _dailyReadingController
                                        .fontSizeModel.paragraph
                                        .toString(),
                                  ))
                                const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                ),
                            ],
                          ),
                        );
                      }).toList();
                    },
                  ),
                ],
                bottom: TabBar(
                  indicatorColor: Colors.white, // Color of the indicator
                  indicatorWeight: 4.0, // Thickness of the indicator
                  labelColor: Colors.white, // Color of the selected tab
                  unselectedLabelColor:
                      Colors.white60, // Color of the unselected tab
                  labelStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),

                  tabs: [
                    Tab(text: "today_reading".tr),
                    Tab(text: 'today_reflection'.tr),
                  ],
                ),
                backgroundColor: Theme.of(context).colorScheme.secondary),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        MainText(
                          text: getFormattedDate(
                            reading.dailyReadingModel.date!,
                          ),
                          size: double.parse(
                            reading.fontSizeModel.paragraph.toString(),
                          ),
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        Container(
                          color: Theme.of(context).colorScheme.background,
                          child: Html(
                            data: reading.dailyReadingModel.content,
                            style: {
                              "h1": Style(
                                fontSize: FontSize(double.parse(
                                  _dailyReadingController
                                          .fontSizeModel.headerOne ??
                                      "1.0",
                                )),
                                fontWeight: FontWeight.w700,
                                // color: Colors.black,
                                textAlign: TextAlign.center,
                                margin: Margins.only(bottom: 20),
                              ),
                              "h2": Style(
                                fontSize: FontSize(double.parse(
                                  _dailyReadingController
                                          .fontSizeModel.headerTwo ??
                                      "1.0",
                                )),
                                fontWeight: FontWeight.w600,
                                // color: Colors.black87,
                                textAlign: TextAlign.center,
                                margin: Margins.only(bottom: 15),
                              ),
                              "h3": Style(
                                fontSize: FontSize(double.parse(
                                  _dailyReadingController
                                          .fontSizeModel.headerThree ??
                                      "1.0",
                                )),
                                fontWeight: FontWeight.w600,
                                // color: Colors.black54,
                                margin: Margins.only(top: 20, bottom: 10),
                                textAlign: TextAlign.left,
                              ),
                              "p": Style(
                                fontSize: FontSize(double.parse(
                                  _dailyReadingController
                                          .fontSizeModel.paragraph ??
                                      "0.0",
                                )),
                                lineHeight: const LineHeight(1.7),
                                textAlign: TextAlign.justify,
                                //color: Colors.black87,
                                margin: Margins.only(bottom: 15),
                              ),
                              "strong": Style(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              "div": Style(
                                margin: Margins.symmetric(vertical: 20),
                                padding: HtmlPaddings.symmetric(horizontal: 10),
                              ),
                              "blockquote": Style(
                                fontSize: FontSize.large,
                                fontStyle: FontStyle.italic,
                                //color: Colors.grey.shade700,
                                padding: HtmlPaddings.symmetric(
                                    horizontal: 15, vertical: 10),
                                backgroundColor: Colors.grey.shade200,
                                border: const Border(
                                    left: BorderSide(
                                        color: Colors.teal, width: 4)),
                                margin: Margins.symmetric(vertical: 20),
                              ),
                            },
                          ),
                        ),
                        SizedBox(
                          height: 100.h,
                        ),
                        AdMobBanner()
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        color: Theme.of(context).colorScheme.background,
                        child: Html(
                          data: reading.dailyReadingModel.summary,
                          style: {
                            "h1": Style(
                              fontSize: FontSize(double.parse(
                                  _dailyReadingController
                                          .fontSizeModel.headerOne ??
                                      "0.0")),
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.center,
                              margin: Margins.only(bottom: 20),
                            ),
                            "h2": Style(
                              fontSize: FontSize(headerTwo),
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.center,
                              margin: Margins.only(bottom: 15),
                            ),
                            "h3": Style(
                              fontSize: FontSize(headerThree),
                              fontWeight: FontWeight.w600,
                              margin: Margins.only(top: 20, bottom: 10),
                              textAlign: TextAlign.left,
                            ),
                            "p": Style(
                              fontSize: FontSize(
                                double.parse(_dailyReadingController
                                        .fontSizeModel.paragraph ??
                                    "0.0"),
                              ),
                              lineHeight: LineHeight(1.7),
                              textAlign: TextAlign.justify,
                              //color: Colors.black87,
                              margin: Margins.only(bottom: 15),
                            ),
                            "strong": Style(
                              fontWeight: FontWeight.bold,
                              // color: Colors.black,
                            ),
                            "div": Style(
                              margin: Margins.symmetric(vertical: 20),
                              padding: HtmlPaddings.symmetric(horizontal: 10),
                            ),
                            "blockquote": Style(
                              fontSize: FontSize.large,
                              fontStyle: FontStyle.italic,
                              //color: Colors.grey.shade700,
                              padding: HtmlPaddings.symmetric(
                                  horizontal: 15, vertical: 10),
                              backgroundColor: Colors.grey.shade200,
                              border: const Border(
                                  left:
                                      BorderSide(color: Colors.teal, width: 4)),
                              margin: Margins.symmetric(vertical: 20),
                            ),
                          },
                        ),
                      ),
                      SizedBox(
                        height: 100.h,
                      ),
                      AdMobBanner()
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String getFormattedDate(String date) {
    try {
      String dateString = date;

      // Parse the date string into a DateTime object
      DateTime dateTime = DateTime.parse(dateString);

      // Create a DateFormat object with the desired format
      DateFormat formatter = DateFormat('MMMM d, yyyy');

      // Format the DateTime object to a string
      return formatter.format(dateTime);
    } catch (ex) {
      return "";
    }
  }
}
