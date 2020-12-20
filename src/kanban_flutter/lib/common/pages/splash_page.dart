import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/routes/routes.dart';
import '../../di/injection_container.dart';
import '../../features/auth/presentation/blocs/user_bloc/user_bloc.dart';
import '../../style/index.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  UserBloc _userBloc;
  StreamSubscription _userSubscription;

  @override
  void initState() {
    super.initState();
    _userBloc = sl<UserBloc>()..add(CurrentUserEvent());

    _userSubscription = _userBloc.listen((state) {
      if (state is UserAuthenticated) {
        Navigator.of(context).popAndPushNamed(Routes.HOME_PAGE);
      } else if (state is UserError) {
        Navigator.of(context).pushReplacementNamed(Routes.AUTH_PAGE);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userBloc.close();
    _userSubscription.cancel();
  }

  Widget _buildSplashPage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: getSize(5),
                horizontal: getSize(15),
              ),
              color: ThemeColor.default_border,
              child: FittedBox(
                fit: BoxFit.fill,
                child: FaIcon(
                  FontAwesomeIcons.gitAlt,
                  size: getSize(80),
                  color: ThemeColor.accent,
                ),
              ),
            ),
          ),
          SizedBox(height: getSize(20)),
          Shimmer.fromColors(
            baseColor: ThemeColor.accent,
            highlightColor: ThemeColor.default_border,
            child: Text(
              'Git Boards',
              style: TextStyle(
                fontSize: getSize(50),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: ThemeColor.board_bg,
      body: BlocProvider(
        create: (_) => _userBloc,
        child: _buildSplashPage(),
      ),
    );
  }
}
