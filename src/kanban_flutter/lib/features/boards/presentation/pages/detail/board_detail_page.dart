import 'dart:async';
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/index.dart';
import '../../../../../style/index.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../di/injection_container.dart';
import '../../../domain/entities/index.dart';
import '../../blocs/index.dart';

class BoardDetailPage extends StatefulWidget {
  @override
  _BoardDetailPageState createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  final BoardViewController _boardViewController = new BoardViewController();
  BoardBloc _boardBloc;
  ColumnBloc _columnBloc;
  CardBloc _cardBloc;
  StreamSubscription _columnSubscription;
  StreamSubscription _cardSubscription;

  @override
  void initState() {
    super.initState();
    // TODO replace boardId
    _boardBloc = sl<BoardBloc>()
      ..add(GetBoardByIdEvent(boardId: 1, setLoading: true));
    _columnBloc = sl<ColumnBloc>();
    _cardBloc = sl<CardBloc>();

    _columnSubscription = _columnBloc.listen((state) {
      if (state is ColumnSuccess) {
        _boardBloc.add(GetBoardByIdEvent(boardId: 1));
      }
    });

    _cardSubscription = _cardBloc.listen((state) {
      if (state is CardSuccess) {
        _boardBloc.add(GetBoardByIdEvent(boardId: 1));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _boardBloc.close();
    _columnBloc.close();
    _cardBloc.close();
    _columnSubscription.cancel();
    _cardSubscription.cancel();
  }

  BoardItem _buildCard(CardItem card, int boardId) {
    return BoardItem(
      onDropItem: (int newColumnIndex, int newCardIndex, int oldColumnIndex,
          int oldCardIndex, BoardItemState state) {
        if (oldColumnIndex == newColumnIndex && newCardIndex == oldCardIndex) {
          return;
        }
        _cardBloc.add(UpdateCardIndexEvent(
          oldCardIndex: oldCardIndex,
          newCardIndex: newCardIndex,
          oldColumnIndex: oldColumnIndex,
          newColumnIndex: newColumnIndex,
          cardId: card.id,
          boardId: boardId,
        ));
      },
      item: ColumnCardItem(card: card),
    );
  }

  BoardList _buildColumn(ColumnItem column) {
    return BoardList(
      onDropList: (int newIndex, int oldIndex) {
        if (newIndex == oldIndex) {
          return;
        }
        _columnBloc.add(UpdateColumnIndexEvent(
          oldIndex: oldIndex,
          newIndex: newIndex,
          columnId: column.id,
          boardId: column.boardId,
        ));
      },
      backgroundColor: ThemeColor.column_bg,
      header: [
        ColumnHeader(column: column),
      ],
      footer: ColumnFooter(column: column),
      items:
          column.cards.map((card) => _buildCard(card, column.boardId)).toList(),
    );
  }

  Widget _buildBoardDetailPage(Board board) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateWidth(15),
        horizontal: getProportionateWidth(10),
      ),
      child: BoardView(
        boardViewController: _boardViewController,
        lists: board.columns.map((column) => _buildColumn(column)).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _boardBloc,
        ),
        BlocProvider(
          create: (_) => _columnBloc,
        ),
        BlocProvider(
          create: (_) => _cardBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: ThemeColor.board_bg,
        appBar: AppBar(
          title: Text('Trillo Shop'),
        ),
        body: BlocBuilder<BoardBloc, BoardState>(
          builder: (_, state) {
            if (state is BoardError) {
              return Center(child: Text(state.message));
            } else if (state is BoardLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BoardLoaded) {
              return _buildBoardDetailPage(state.board);
            }
            return Center(child: const Text(UNEXPECTED_FAILURE_MESSAGE));
          },
        ),
      ),
    );
  }
}
