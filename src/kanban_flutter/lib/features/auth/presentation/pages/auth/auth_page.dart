import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../di/injection_container.dart';
import '../../blocs/user_bloc/user_bloc.dart';
import '../../../../../style/index.dart';
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocProvider(
      create: (_) => _userBloc,
      child: Scaffold(
        backgroundColor: ThemeColor.board_bg,
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateWidth(20),
            horizontal: getProportionateWidth(15),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
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
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: ThemeColor.text_normal,
                            fontSize: ThemeSize.fs_17,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20),
                        onPressed: () => _showForm(context, Container()),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        ),
                        side: BorderSide(color: ThemeColor.accent),
                      ),
                      highlightColor: ThemeColor.blue.withOpacity(0.4),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: ThemeColor.text_normal,
                          fontSize: ThemeSize.fs_17,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      onPressed: () => _showForm(context, LoginForm()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
