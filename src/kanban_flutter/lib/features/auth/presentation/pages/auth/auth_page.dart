import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../di/injection_container.dart';
import '../../../../../style/index.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import 'components/index.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = sl<UserBloc>();

    _userBloc.listen((state) {
      if (state is UserAuthenticated) {
        Navigator.of(context).popAndPushNamed(Routes.HOME_PAGE);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _userBloc.close();
  }

  void _showForm(BuildContext context, Widget form) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (ctx) => BlocProvider.value(
        value: _userBloc,
        child: form,
      ),
    );
  }

  Widget _btnContent(String text) {
    return Text(
      text,
      style: TextStyle(
        color: ThemeColor.text_normal,
        fontSize: getSize(ThemeSize.fs_17),
      ),
    );
  }

  Widget _buildRegisterBtn() {
    return Expanded(
      child: Transform.translate(
        offset: Offset(1, 0),
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
            side: BorderSide(color: ThemeColor.accent),
          ),
          highlightColor: ThemeColor.blue.withOpacity(0.4),
          child: _btnContent('Sign Up'),
          padding: EdgeInsets.symmetric(vertical: getSize(20)),
          onPressed: () => _showForm(context, RegisterForm()),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Expanded(
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
          side: BorderSide(color: ThemeColor.accent),
        ),
        highlightColor: ThemeColor.blue.withOpacity(0.4),
        child: _btnContent('Log In'),
        padding: EdgeInsets.symmetric(vertical: getSize(20)),
        onPressed: () => _showForm(context, LoginForm()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (_) => _userBloc,
      child: Scaffold(
        backgroundColor: ThemeColor.board_bg,
        body: SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight,
            padding: EdgeInsets.symmetric(
              vertical: getSize(20),
              horizontal: getSize(15),
            ),
            child: Column(
              children: [
                AuthCarousel(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildRegisterBtn(),
                    _buildLoginBtn(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
