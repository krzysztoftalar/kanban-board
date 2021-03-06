import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widgets/index.dart';
import '../../../../../../core/validators/boards_validators.dart';
import '../../../../../../style/index.dart';
import '../../../../domain/entities/column_item.dart';
import '../../../blocs/column_bloc/column_bloc.dart';

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

  int get cardsCount => widget.column.cards.length;

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
        EditColumnEvent(
          columnId: widget.column.id,
          title: newColumnTitle,
        ),
      );

      _toggleShowForm();
    }
  }

  void _deleteColumn() {
    _toggleConfirmDialog();
    columnBloc.add(DeleteColumnEvent(column: widget.column));
  }

  Widget _buildColumnTitleForm() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getSize(10),
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
          validator: columnTitleValidator,
        ),
      ),
    );
  }

  Widget _buildPopupMenu() {
    return Container(
      height: getSize(35),
      child: PopupMenuButton<PopUpMenuOptions>(
        offset: Offset(0, getSize(15)),
        onSelected: _menuChoiceAction,
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
      ),
    );
  }

  Widget _buildConfirmDialogText() {
    String title = '';

    if (cardsCount == 0) {
      title = "Are you sure you want to delete this column?";
    } else {
      title = "Are you sure you want to delete this column?\n"
          "$cardsCount ${cardsCount == 1 ? 'card' : 'cards'} will also be deleted.";
    }

    return Text(
      title,
      style: TextStyle(
        color: ThemeColor.text_selected,
        fontSize: getSize(ThemeSize.fs_15),
      ),
    );
  }

  Widget _buildColumnTitle() {
    return Container(
      padding: EdgeInsets.only(top: getSize(7), bottom: getSize(5)),
      child: Text(
        widget.column.title,
        style: TextStyle(
          fontSize: getSize(ThemeSize.fs_20),
          fontWeight: FontWeight.w600,
          color: ThemeColor.text_selected,
        ),
      ),
    );
  }

  Widget _buildCardsCount() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(bottom: getSize(8)),
      child: Text(
        "$cardsCount ${cardsCount == 1 ? 'card' : 'cards'}",
        style: TextStyle(
          fontSize: ThemeSize.fs_15,
          color: ThemeColor.text_disabled,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: getSize(5),
          horizontal: getSize(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child:
                      showForm ? _buildColumnTitleForm() : _buildColumnTitle(),
                ),
                _buildPopupMenu(),
              ],
            ),
            _buildCardsCount(),
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
