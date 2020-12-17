import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/common/widgets/index.dart';

import 'index.dart';
import '../../../blocs/column_bloc/column_bloc.dart';
import '../../../../domain/entities/column_item.dart';
import '../../../../../../style/index.dart';

enum PopUpMenuOptions {
  Rename,
  Delete,
}

class ColumnHeader extends StatefulWidget {
  final ColumnItem column;

  ColumnHeader({
    @required this.column,
  });

  @override
  _ColumnHeaderState createState() => _ColumnHeaderState();
}

class _ColumnHeaderState extends State<ColumnHeader> {
  ColumnBloc get columnBloc => BlocProvider.of<ColumnBloc>(context);
  String newColumnTitle;
  bool showForm = false;
  bool showConfirmDialog = false;
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
  }

  void _toggleShowForm() => setState(() => showForm = !showForm);

  void _toggleConfirmDialog() =>
      setState(() => showConfirmDialog = !showConfirmDialog);

  void _menuChoiceAction(PopUpMenuOptions choice) {
    switch (choice) {
      case PopUpMenuOptions.Rename:
        _toggleShowForm();
        _columnFocusNode.requestFocus();
        break;
      case PopUpMenuOptions.Delete:
        _toggleConfirmDialog();
        break;
    }
  }

  void _renameColumn() {
    if (newColumnTitle.isEmpty || newColumnTitle == widget.column.title) {
      _toggleShowForm();
      return;
    }

    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      columnBloc.add(
        UpdateColumnTitleEvent(
          columnId: widget.column.id,
          title: newColumnTitle,
        ),
      );

      _toggleShowForm();
    }
  }

  void _deleteColumn() {
    _toggleConfirmDialog();
    columnBloc.add(DeleteColumnEvent(columnId: widget.column.id));
  }

  Widget _buildColumnTitleForm() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateWidth(10),
      ),
      child: Form(
        key: _formKey,
        child: TextFormField(
          onFieldSubmitted: (_) => _renameColumn(),
          focusNode: _columnFocusNode,
          initialValue: widget.column.title,
          decoration: InputDecoration(
            hintText: "Type a name for your column",
          ),
          style: defaultTextStyle,
          onSaved: (value) => newColumnTitle = value,
          onChanged: (value) => setState(() => newColumnTitle = value),
          validator: (value) {
            if (value.isEmpty) {
              return "Column title can't be empty.";
            } else if (value.length > 100) {
              return "Column title can't be over 100 characters.";
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<PopUpMenuOptions>(
      onSelected: _menuChoiceAction,
      offset: Offset(0, 15),
      color: ThemeColor.menu_bg,
      icon: Icon(
        Icons.more_vert,
        color: ThemeColor.text_normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      itemBuilder: (_) => [
        PopupMenuItem(
          child: Text('Rename'),
          textStyle: defaultTextStyle,
          value: PopUpMenuOptions.Rename,
        ),
        PopupMenuItem(
          child: Text('Delete'),
          textStyle: defaultTextStyle,
          value: PopUpMenuOptions.Delete,
        ),
      ],
    );
  }

  Widget _buildConfirmDialogText() {
    final cardsCount = widget.column.cards.length;

    return Text(
      "Are you sure you want to delete this column?\n"
      "$cardsCount ${cardsCount == 1 ? 'card' : 'cards'} will also be deleted.",
      style: TextStyle(
        color: ThemeColor.text_selected,
        fontSize: ThemeSize.fs_15,
      ),
    );
  }

  Widget _buildColumnTitle() {
    return Text(
      widget.column.title,
      style: TextStyle(
        fontSize: getProportionateWidth(ThemeSize.fs_20),
        fontWeight: FontWeight.w500,
        color: ThemeColor.text_selected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateWidth(5),
          horizontal: getProportionateWidth(15),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child:
                      showForm ? _buildColumnTitleForm() : _buildColumnTitle(),
                ),
                _buildPopupMenu(),
              ],
            ),
            showConfirmDialog
                ? ConfirmDeleteDialog(
                    cancelHandler: _toggleConfirmDialog,
                    deleteHandler: _deleteColumn,
                    messageWidget: _buildConfirmDialogText,
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
