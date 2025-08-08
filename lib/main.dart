import 'package:souq_al_balad/global/data/local/cache_helper.dart';
import 'package:souq_al_balad/global/data/remote/firebase_api.dart';
import 'package:souq_al_balad/global/localization/app_localization.dart';
import 'package:souq_al_balad/global/themes/themes.dart';
import 'package:souq_al_balad/global/utils/key_shared.dart';
import 'package:souq_al_balad/modules/splash_screen/view/screen/splash_screen_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.delayed(const Duration(milliseconds: 50));

  await CacheHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// light mode by default
  if (CacheHelper.getData(key: 'theme_mode') == null) {
    await CacheHelper.saveData(key: 'theme_mode', value: false);
  }
  // SystemChrome.setEnabledSystemUIMode(
  //   SystemUiMode.immersiveSticky,
  //   overlays: [SystemUiOverlay.top],
  // );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // If you want to allow upside down, add:
    // DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    super.initState();
    // CacheHelper.removeData(key: 'token');
    /// load application language:
    CacheHelper.loadLanguage().then((languageCode) {
      setState(() {
        if (CacheHelper.getData(key: HEADERLANGUAGEKEY) == null) {
          CacheHelper.saveData(key: HEADERLANGUAGEKEY, value: languageCode);
        }
        _locale = Locale(languageCode);
      });
      Get.updateLocale(_locale!);
    });
    FirebaseApi().requestNotificationPermission();
    FirebaseApi().firebaseInit(context);
    FirebaseApi().setupInteractMessage(context);
    //FirebaseApi().isTokenRefresh();
    //FirebaseApi().getDeviceToken();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(400, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          supportedLocales: const [
            Locale('ar', ''),
            Locale('en', ''),
            Locale('tr', ''),
            Locale('de', ''),
          ],
          locale: _locale,
          localizationsDelegates: const [
            AppLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (local, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == local!.languageCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          title: 'سوق البلدي',
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          themeMode: CacheHelper().getThemeMode(),
          home: const SplashScreenApp(),
        );
      },
    );
  }
}
