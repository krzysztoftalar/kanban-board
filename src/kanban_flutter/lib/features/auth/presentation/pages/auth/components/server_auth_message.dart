import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../style/index.dart';
import '../../../blocs/user_bloc/user_bloc.dart';

class ServerAuthMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, state) {
        if (state is UserError) {
          return Container(
            padding: EdgeInsets.all(getSize(15)),
            child: Text(
              state.message,
              style: TextStyle(
                color: ThemeColor.text_error,
                fontSize: getSize(ThemeSize.fs_15),
              ),
            ),
          );
        }
        return SizedBox(height: getSize(20));
      },
    );
  }
}
