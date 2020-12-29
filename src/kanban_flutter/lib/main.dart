import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './di/injection_container.dart' as di;
import 'common/pages/index.dart';
import 'core/config/app_config.dart';
import 'core/routes/routes.dart';
import 'features/auth/presentation/pages/auth/auth_page.dart';
import 'features/boards/presentation/blocs/simple_bloc_observer.dart';
import 'features/boards/presentation/pages/detail/board_detail_page.dart';
import 'features/boards/presentation/pages/home/home_page.dart';
import 'style/index.dart';
import 'style/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setEnvironment(Environment.Development);

  await di.init();
  Bloc.observer = SimpleBlocObserver();

  runApp(KanbanApp());
}

class KanbanApp extends StatelessWidget {
  static final navigatorKey = new GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = new GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: SplashPage(),
      routes: {
        Routes.AUTH_PAGE: (_) => AuthPage(),
        Routes.HOME_PAGE: (_) => HomePage(),
        Routes.BOARD_DETAIL_PAGE: (_) => BoardDetailPage(),
      },
    );
  }
}
