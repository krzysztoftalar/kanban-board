import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widgets/index.dart';
import '../../../../../../core/helpers/index.dart';
import '../../../../../../style/index.dart';
import '../../../blocs/user_bloc/user_bloc.dart';
import 'index.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  UserBloc get userBloc => BlocProvider.of<UserBloc>(context);
  String userName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  @override
  void initState() {
    super.initState();
    _userNameFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameFocusNode.requestFocus();
    _emailFocusNode.requestFocus();
    _passwordFocusNode.requestFocus();
    _confirmPasswordFocusNode.requestFocus();
  }

  bool disableButton() =>
      userName.isEmpty ||
      email.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty;

  void _register() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      userBloc.add(
        RegisterEvent(
          userName: userName,
          email: email,
          password: password,
        ),
      );
    }
  }

  Widget _buildUserNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      focusNode: _userNameFocusNode,
      onSaved: (value) => userName = value,
      onChanged: (value) => setState(() => userName = value),
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(_emailFocusNode),
      decoration: InputDecoration(hintText: "Name"),
      style: defaultTextStyle,
      validator: userNameValidator,
    );
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
      onFieldSubmitted: (_) =>
          FocusScope.of(context).requestFocus(_confirmPasswordFocusNode),
      decoration: InputDecoration(hintText: "Password"),
      style: defaultTextStyle,
      validator: registerPasswordValidator,
    );
  }

  Widget _buildConfirmPasswordFormField() {
    return TextFormField(
      obscureText: true,
      focusNode: _confirmPasswordFocusNode,
      onSaved: (value) => confirmPassword = value,
      onChanged: (value) => setState(() => confirmPassword = value),
      onFieldSubmitted: (_) => _register(),
      decoration: InputDecoration(hintText: "Confirm Password"),
      style: defaultTextStyle,
      validator: (value) => confirmPasswordValidator(value, password),
    );
  }

  Widget _buildSubmitBtn() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, state) => Container(
        width: double.infinity,
        child: OutlinedActionButton(
          handler: _register,
          disableBtn: disableButton,
          btnContent: state is UserLoading
              ? SmallProgressIndicator()
              : Text('Create Account'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthFormTitle(title: 'Get Started with Git Boards'),
      body: SingleChildScrollView(
        child: Container(
          color: ThemeColor.board_bg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ServerAuthMessage(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: getSize(15)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _buildUserNameFormField(),
                      SizedBox(height: getSize(20)),
                      _buildEmailFormField(),
                      SizedBox(height: getSize(20)),
                      _buildPasswordFormField(),
                      SizedBox(height: getSize(20)),
                      _buildConfirmPasswordFormField(),
                      SizedBox(height: getSize(20)),
                      _buildSubmitBtn(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
