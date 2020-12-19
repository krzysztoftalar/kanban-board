import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user_bloc/user_bloc.dart';
import '../../../../../common/widgets/index.dart';
import '../../../../../core/helpers/login_validators.dart';
import '../../../../../style/index.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  UserBloc get userBloc => BlocProvider.of<UserBloc>(context);
  String email = 'bob@test.com';
  String password = 'Pa\$\$w0rd';

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
      initialValue: 'bob@test.com',
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
      validator: passwordValidator,
      initialValue: 'Pa\$\$w0rd',
    );
  }

  Widget _buildFormTitle() {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      padding: EdgeInsets.symmetric(vertical: getProportionateWidth(20)),
      color: ThemeColor.card_bg,
      width: double.infinity,
      child: Center(
        child: Text(
          'Log In',
          style: TextStyle(
            color: ThemeColor.text_selected,
            fontSize: ThemeSize.fs_20,
          ),
        ),
      ),
    );
  }

  Widget _buildServerMessage() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, state) {
        if (state is UserError) {
          return Container(
            padding: EdgeInsets.all(getProportionateWidth(15)),
            child: Text(
              state.message,
              style: TextStyle(
                color: ThemeColor.text_error,
                fontSize: ThemeSize.fs_15,
              ),
            ),
          );
        }
        return SizedBox(height: getProportionateWidth(20));
      },
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
    return Container(
      color: ThemeColor.board_bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFormTitle(),
          _buildServerMessage(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateWidth(15),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildEmailFormField(),
                    SizedBox(height: getProportionateWidth(20)),
                    _buildPasswordFormField(),
                    SizedBox(height: getProportionateWidth(20)),
                    _buildSubmitBtn(),
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
