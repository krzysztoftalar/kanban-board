import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/auth/presentation/blocs/user_bloc/user_bloc.dart';
import '../../../style/index.dart';
import 'index.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  UserBloc get userBloc => BlocProvider.of<UserBloc>(context);

  void _logout() => userBloc.add(LogoutEvent());

  List<DrawerOption> get options {
    return [
      DrawerOption(
          text: 'Profile & password', icon: Icons.lock_outline, handler: () {}),
      DrawerOption(
        text: 'Sign out',
        icon: Icons.logout,
        handler: _logout,
      ),
    ];
  }

  Widget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: ThemeColor.board_header_bg2,
      shadowColor: ThemeColor.text_disabled,
      title: Text(
        'Git Boards Settings',
        style: TextStyle(
          color: ThemeColor.text_selected,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: [
        IconButton(
          splashColor: ThemeColor.accent.withOpacity(0.3),
          highlightColor: ThemeColor.accent.withOpacity(0.3),
          color: ThemeColor.text_normal,
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColor.board_header_bg2,
      width: double.infinity,
      child: Column(
        children: [
          _buildAppBar(),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(30),
                  vertical: getSize(10),
                ),
                child: Column(
                  children: [
                    NavDrawerItem(options[0]),
                    Divider(
                      color: ThemeColor.text_disabled,
                      height: getSize(40),
                    ),
                    NavDrawerItem(options[1]),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
