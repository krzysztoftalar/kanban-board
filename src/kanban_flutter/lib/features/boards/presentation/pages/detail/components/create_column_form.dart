import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widgets/index.dart';
import '../../../../../../core/validators/boards_validators.dart';
import '../../../../../../style/index.dart';
import '../../../../domain/entities/index.dart';
import '../../../blocs/column_bloc/column_bloc.dart';

class CreateColumnForm extends StatefulWidget {
  final Board board;

  CreateColumnForm({
    @required this.board,
  });

  @override
  _CreateColumnFormState createState() => _CreateColumnFormState();
}

class _CreateColumnFormState extends State<CreateColumnForm> {
  ColumnBloc get columnBloc => BlocProvider.of<ColumnBloc>(context);
  TextEditingController _columnController = TextEditingController();
  bool showForm = false;
  bool isTitleEmpty = true;

  final _formKey = GlobalKey<FormState>();
  final _columnFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _columnFocusNode.addListener(() {
      if (!_columnFocusNode.hasFocus) {
        setState(() => showForm = false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _columnFocusNode.dispose();
    _columnController.dispose();
  }

  void _toggleShowForm() => setState(() => showForm = !showForm);

  void _createColumn() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _toggleShowForm();

      columnBloc.add(
        CreateColumnEvent(
          boardId: widget.board.id,
          columnIndex: widget.board.columns.length,
          title: _columnController.text,
        ),
      );
    }
  }

  Widget _buildColumnTitleFormField() {
    return TextFormField(
      controller: _columnController,
      focusNode: _columnFocusNode,
      onFieldSubmitted: (_) => _createColumn(),
      decoration: InputDecoration(
        hintText: "Type a name for your column",
      ),
      style: defaultTextStyle,
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() => isTitleEmpty = true);
        } else if (value.isNotEmpty) {
          setState(() => isTitleEmpty = false);
        }
      },
      validator: columnTitleValidator,
    );
  }

  Widget _buildCreateColumnBtn() {
    return TextButton(
      onPressed: () {
        _toggleShowForm();
        _columnFocusNode.requestFocus();
      },
      child: Text(
        'Add Column',
        style: TextStyle(
          color: ThemeColor.link,
          fontSize: getSize(ThemeSize.fs_17),
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedCancelButton(handler: _toggleShowForm),
        SizedBox(width: getSize(15)),
        OutlinedSuccessButton(
          isFieldEmpty: isTitleEmpty,
          btnText: 'Add Column',
          handler: _createColumn,
        )
      ],
    );
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getSize(5),
        vertical: getSize(15),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildColumnTitleFormField(),
            SizedBox(height: getSize(10)),
            _buildButtonBar(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: getSize(5)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showForm ? _buildForm() : _buildCreateColumnBtn(),
          ],
        ),
      ),
    );
  }
}
