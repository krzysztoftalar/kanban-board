import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/common/pages/index.dart';
import './di/injection_container.dart' as di;

import 'features/boards/presentation/pages/detail/board_detail_page.dart';
import 'core/routes/routes.dart';
import 'features/boards/presentation/pages/home/home_page.dart';
import 'style/index.dart';
import 'style/theme.dart';
import 'core/config/app_config.dart';
import 'features/boards/presentation/blocs/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setEnvironment(Environment.development);

  await di.init();
  Bloc.observer = SimpleBlocObserver();

  runApp(KanbanApp());
}

class KanbanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: HomePage(),
      routes: {
        Routes.BOARD_DETAIL_PAGE: (_) => BoardDetailPage(),
      },
    );
  }
}
