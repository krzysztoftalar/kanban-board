import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../common/widgets/index.dart';
import '../../../../../../core/routes/routes.dart';
import '../../../../../../style/index.dart';
import '../../../../data/repositories/board_templates_repository_impl.dart';
import '../../../../domain/entities/index.dart';
import '../../../blocs/boards_bloc/boards_bloc.dart';
import '../../../blocs/index.dart';
import 'index.dart';

enum PopUpMenuOptions {
  Rename,
  Delete,
}

class UserBoardItem extends StatefulWidget {
  final Board board;

  UserBoardItem({
    @required this.board,
  });

  @override
  _UserBoardItemState createState() => _UserBoardItemState();
}

class _UserBoardItemState extends State<UserBoardItem> {
  BoardsBloc get boardsBloc => BlocProvider.of<BoardsBloc>(context);
  bool showConfirmDialog = false;

  void _toggleConfirmDialog() =>
      setState(() => showConfirmDialog = !showConfirmDialog);

  void _menuChoiceAction(PopUpMenuOptions choice) {
    switch (choice) {
      case PopUpMenuOptions.Rename:
        showCupertinoModalBottomSheet(
          context: context,
          builder: (ctx) => BlocProvider.value(
            value: boardsBloc,
            child: CreateBoardForm(board: widget.board),
          ),
        );
        break;
      case PopUpMenuOptions.Delete:
        _toggleConfirmDialog();
        break;
    }
  }

  void _deleteBoard() {
    _toggleConfirmDialog();
    boardsBloc.add(DeleteBoardEvent(boardId: widget.board.id));
  }

  Widget _buildPopupMenu() {
    return PopupMenuButton<PopUpMenuOptions>(
      onSelected: _menuChoiceAction,
      offset: Offset(0, getSize(15)),
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
    return Text(
      "Are you sure you want to delete \"${widget.board.title}\"?",
      style: TextStyle(
        color: ThemeColor.text_selected,
        fontSize: getSize(ThemeSize.fs_15),
      ),
    );
  }

  Widget _buildIcon() {
    final boardTemplate = getBoardTemplateById(widget.board.templateId);

    return Container(
      width: getSize(25),
      height: getSize(25),
      child: FittedBox(
        fit: BoxFit.fill,
        child: FaIcon(
          boardTemplate.icon,
          color: boardTemplate.iconColor,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      widget.board.title,
      style: TextStyle(
        color: ThemeColor.text_selected,
        fontSize: getSize(ThemeSize.fs_17),
      ),
    );
  }

  Widget _buildListTile() {
    final border = showConfirmDialog
        ? BoxDecoration(
            border: Border.all(
              color: ThemeColor.blue,
              width: 2.0,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          )
        : BoxDecoration();

    return Container(
      decoration: border,
      child: ListTile(
        onTap: () => Navigator.of(context).pushNamed(
          Routes.BOARD_DETAIL_PAGE,
          arguments: widget.board.id,
        ),
        title: _buildTitle(),
        leading: _buildIcon(),
        trailing: _buildPopupMenu(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: getSize(5)),
      child: Column(
        children: [
          _buildListTile(),
          showConfirmDialog
              ? ConfirmDeleteDialog(
                  cancelHandler: _toggleConfirmDialog,
                  deleteHandler: _deleteBoard,
                  messageWidget: _buildConfirmDialogText,
                  borderRadius: 5,
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
