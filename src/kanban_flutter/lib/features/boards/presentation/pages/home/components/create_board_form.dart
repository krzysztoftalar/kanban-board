import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/board_bloc/board_bloc.dart';
import '../../../../../../common/widgets/index.dart';
import '../../../../../../style/index.dart';

class CreateBoardForm extends StatefulWidget {
  final int templateId;

  CreateBoardForm({
    @required this.templateId,
  });

  @override
  _CreateBoardFormState createState() => _CreateBoardFormState();
}

class _CreateBoardFormState extends State<CreateBoardForm> {
  BoardBloc get boardBloc => BlocProvider.of<BoardBloc>(context);
  TextEditingController _boardController = TextEditingController();
  bool isTitleEmpty = true;
  final _formKey = GlobalKey<FormState>();
  final _boardFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _boardFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    _boardFocusNode.dispose();
    _boardController.dispose();
  }

  void _createBoard() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      boardBloc.add(CreateBoardEvent(
        title: _boardController.text,
        templateId: widget.templateId,
      ));

      Navigator.of(context).pop();
    }
  }

  Widget _buildBoardTitleFormField() {
    return TextFormField(
      controller: _boardController,
      focusNode: _boardFocusNode,
      onFieldSubmitted: (_) => _createBoard(),
      decoration: InputDecoration(
        hintText: "Type a name for your board",
      ),
      style: defaultTextStyle,
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() => isTitleEmpty = true);
        } else if (value.isNotEmpty) {
          setState(() => isTitleEmpty = false);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Board title can't be empty.";
        } else if (value.length > 100) {
          return "Board title can't be over 100 characters.";
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateWidth(15),
            horizontal: getProportionateWidth(15),
          ),
          color: ThemeColor.menu_bg,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Create Board',
                    style: TextStyle(
                      color: ThemeColor.text_selected,
                      fontSize: ThemeSize.fs_20,
                    ),
                  ),
                ),
                SizedBox(height: getProportionateHeight(15)),
                Text(
                  'Board Name',
                  style: TextStyle(
                    color: ThemeColor.text_normal,
                    fontSize: ThemeSize.fs_17,
                  ),
                ),
                SizedBox(height: getProportionateHeight(5)),
                _buildBoardTitleFormField(),
                SizedBox(height: getProportionateHeight(10)),
                Container(
                  alignment: Alignment.topRight,
                  child: OutlinedSuccessButton(
                    isFieldEmpty: isTitleEmpty,
                    btnText: 'Create Board',
                    handler: _createBoard,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
