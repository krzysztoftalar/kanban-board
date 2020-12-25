import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widgets/index.dart';
import '../../../../../../core/validators/boards_validators.dart';
import '../../../../../../style/index.dart';
import '../../../../domain/entities/index.dart';
import '../../../blocs/index.dart';

class CreateBoardForm extends StatefulWidget {
  final int templateId;
  final Board board;

  CreateBoardForm({
    this.templateId,
    this.board,
  });

  @override
  _CreateBoardFormState createState() => _CreateBoardFormState();
}

class _CreateBoardFormState extends State<CreateBoardForm> {
  BoardsBloc get boardsBloc => BlocProvider.of<BoardsBloc>(context);
  TextEditingController _boardController;
  bool isTitleEmpty = true;

  final _formKey = GlobalKey<FormState>();
  final _boardFocusNode = FocusNode();

  bool get isEdited => widget.board != null;

  @override
  void initState() {
    super.initState();
    _boardFocusNode.requestFocus();
    _boardController =
        TextEditingController(text: isEdited ? widget.board.title : '');
  }

  @override
  void dispose() {
    super.dispose();
    _boardFocusNode.dispose();
    _boardController.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      if (isEdited) {
        boardsBloc.add(EditBoardEvent(
          boardId: widget.board.id,
          title: _boardController.text,
        ));
      } else {
        boardsBloc.add(CreateBoardEvent(
          title: _boardController.text,
          templateId: widget.templateId,
        ));
      }

      Navigator.of(context).pop();
    }
  }

  Widget _buildBoardTitleFormField() {
    return TextFormField(
      controller: _boardController,
      focusNode: _boardFocusNode,
      onFieldSubmitted: (_) => _submitForm(),
      decoration: InputDecoration(hintText: "Type a name for your board"),
      style: defaultTextStyle,
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() => isTitleEmpty = true);
        } else if (value.isNotEmpty) {
          setState(() => isTitleEmpty = false);
        }
      },
      validator: boardTitleValidator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: getSize(15),
            horizontal: getSize(15),
          ),
          color: ThemeColor.menu_bg,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    isEdited ? 'Edit Board' : 'Create Board',
                    style: TextStyle(
                      color: ThemeColor.text_selected,
                      fontSize: getSize(ThemeSize.fs_20),
                    ),
                  ),
                ),
                SizedBox(height: getSize(15)),
                Text(
                  'Board Name',
                  style: TextStyle(
                    color: ThemeColor.text_normal,
                    fontSize: getSize(ThemeSize.fs_17),
                  ),
                ),
                SizedBox(height: getSize(5)),
                _buildBoardTitleFormField(),
                SizedBox(height: getSize(10)),
                Container(
                  alignment: Alignment.topRight,
                  child: OutlinedSuccessButton(
                    isFieldEmpty: isTitleEmpty,
                    btnText: isEdited ? 'Save Changes' : 'Create Board',
                    handler: _submitForm,
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
