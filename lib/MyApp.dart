

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterdemo/page/main/MyHomePage.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'RouteConfig.dart';
import 'common/translation/messages.dart';
import 'mixin/image_picker_mixin.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          translations: Messages(),
          theme: ThemeData(
            // brightness: Brightness.light,
            // splashColor: Colors.transparent,
            // highlightColor: Colors.transparent,

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          // home: const MyHomePage(title: 'Flutter Demo Home Page'),
          // home: const MyHomePage(),
          getPages: RouteConfig.getPages,
          initialRoute: RouteConfig.home,
          builder: EasyLoading.init(),
          localizationsDelegates: const [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            // FormBuilderLocalizations.delegate,
            RefreshLocalizations.delegate
          ],
          //默认指定的语言
          locale: const Locale('zh', 'CN'),
          // 备用语言
          fallbackLocale: const Locale('en', 'US'),
          // locale: Get.deviceLocale,//跟随系统设置语言 持久化以后这里改一下
          supportedLocales: const [
            Locale('en', 'US'), // 美国英语
            Locale('zh', 'CN'), // 中文简体
          ],
          // locale: LanguageUtils.getLocale(),
          // fallbackLocale: const Locale("zh", "CN"),
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            print('当前语言：${deviceLocale.toString()}');
            return;
          },
          // supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}

