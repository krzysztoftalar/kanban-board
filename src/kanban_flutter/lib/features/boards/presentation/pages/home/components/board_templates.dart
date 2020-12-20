import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../style/index.dart';
import '../../../../data/repositories/board_templates_repository_impl.dart';
import '../../../blocs/index.dart';
import 'index.dart';

class BoardTemplates extends StatelessWidget {
  Widget _buildNewBoard(BuildContext context) {
    return GestureDetector(
      onTap: () => showCupertinoModalBottomSheet(
        context: context,
        builder: (ctx) => BlocProvider.value(
          value: BlocProvider.of<BoardBloc>(context),
          child: CreateBoardForm(templateId: 0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(getSize(20)),
        decoration: BoxDecoration(
          border: Border.all(color: ThemeColor.primary_border),
          borderRadius: BorderRadius.circular(5),
          color: ThemeColor.blue.withOpacity(0.3),
        ),
        child: Center(
          child: Text(
            'Create a new board',
            style: TextStyle(
              color: ThemeColor.text_selected,
              fontSize: getSize(ThemeSize.fs_17),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        _buildNewBoard(context),
        SizedBox(height: getSize(20)),
        Center(
          child: Text(
            '...or create a board from a template.',
            style: TextStyle(
              color: ThemeColor.text_normal,
              fontSize: getSize(ThemeSize.fs_17),
            ),
          ),
        ),
        SizedBox(height: getSize(20)),
        ...BOARD_TEMPLATES
            .map((board) => BoardTemplateItem(board: board))
            .toList(),
      ],
    );
  }
}
