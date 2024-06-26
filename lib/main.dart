import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_string.dart';
import 'core/constants/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/router/app_router_settings.dart';
import 'core/utils/app_navigator_key.dart';
import 'firebase_options.dart';
import 'src/features/auth/controller/auth_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  AppTheme.statusBarDesign;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthController>(create: (_){
            AuthController authController = AuthController();
            authController.onInit();
            return authController;
          })
        ],
        child: ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            useInheritedMediaQuery: true,
          builder: (context,child) {
            return MaterialApp(
              navigatorKey: AppNavigatorKey.key,
              title: AppString.appName,
              debugShowCheckedModeBanner: false,
              theme: AppTheme.themeData,
              initialRoute: AppRouter.initializer,
              onGenerateRoute: (RouteSettings settings) =>
                  GeneratedRoute.onGenerateRoute(settings),
            );
          }
        ));
  }
}
