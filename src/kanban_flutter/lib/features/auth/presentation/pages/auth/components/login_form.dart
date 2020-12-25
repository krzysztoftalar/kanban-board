import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widgets/index.dart';
import '../../../../../../core/validators/login_validators.dart';
import '../../../../../../style/index.dart';
import '../../../blocs/user_bloc/user_bloc.dart';
import 'index.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  UserBloc get userBloc => BlocProvider.of<UserBloc>(context);
  String email = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    _emailFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

  bool disableButton() => email.isEmpty || password.isEmpty;

  void _login() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      userBloc.add(
        LoginEvent(
          email: email,
          password: password,
        ),
      );
    }
  }

  Widget _buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      focusNode: _emailFocusNode,
      onSaved: (value) => email = value,
      onChanged: (value) => setState(() => email = value),
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(_passwordFocusNode),
      decoration: InputDecoration(hintText: "Email"),
      style: defaultTextStyle,
      validator: emailValidator,
    );
  }

  Widget _buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      focusNode: _passwordFocusNode,
      onSaved: (value) => password = value,
      onChanged: (value) => setState(() => password = value),
      onFieldSubmitted: (_) => _login(),
      decoration: InputDecoration(hintText: "Password"),
      style: defaultTextStyle,
      validator: loginPasswordValidator,
    );
  }

  Widget _buildSubmitBtn() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, state) => Container(
        width: double.infinity,
        child: OutlinedActionButton(
          handler: _login,
          disableBtn: disableButton,
          btnContent:
              state is UserLoading ? SmallProgressIndicator() : Text('Log In'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthFormTitle(title: 'Log In'),
      body: Container(
        color: ThemeColor.board_bg,
        child: ListView(
          children: [
            ServerAuthMessage(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: getSize(15)),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildEmailFormField(),
                    SizedBox(height: getSize(20)),
                    _buildPasswordFormField(),
                    SizedBox(height: getSize(20)),
                    _buildSubmitBtn(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
