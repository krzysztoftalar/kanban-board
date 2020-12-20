import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../style/index.dart';
import '../../../../domain/entities/index.dart';
import '../../../blocs/index.dart';
import 'create_board_form.dart';

class BoardTemplateItem extends StatelessWidget {
  final BoardTemplate board;

  BoardTemplateItem({
    @required this.board,
  });

  Widget _buildIcon() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        padding: EdgeInsets.all(getSize(15)),
        width: getSize(80),
        height: getSize(80),
        color: board.iconColor,
        child: FittedBox(
          fit: BoxFit.fill,
          child: FaIcon(
            board.icon,
            color: ThemeColor.text_selected,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      board.title,
      style: TextStyle(
        color: ThemeColor.text_selected,
        fontSize: getSize(ThemeSize.fs_20),
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildColumns() {
    return Container(
      height: getSize(20),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Text(
            'Columns: ',
            style: TextStyle(
              fontSize: getSize(ThemeSize.fs_15),
              color: ThemeColor.text_disabled,
            ),
          ),
          Text(
            board.columns.join(", "),
            style: TextStyle(
              fontSize: getSize(ThemeSize.fs_15),
              color: ThemeColor.text_selected,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double margin = board.id == 5 ? 0 : 10;

    return GestureDetector(
      onTap: () => showCupertinoModalBottomSheet(
        context: context,
        builder: (ctx) => BlocProvider.value(
          value: BlocProvider.of<BoardBloc>(context),
          child: CreateBoardForm(templateId: board.id),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: board.color,
        ),
        margin: EdgeInsets.only(bottom: getSize(margin)),
        child: Padding(
          padding: EdgeInsets.all(getSize(10)),
          child: Row(
            children: [
              _buildIcon(),
              SizedBox(width: getSize(15)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildTitle(),
                    SizedBox(height: getSize(10)),
                    _buildColumns(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
