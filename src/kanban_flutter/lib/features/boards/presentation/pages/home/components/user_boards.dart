import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widgets/index.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../style/index.dart';
import '../../../blocs/index.dart';
import 'index.dart';

class UserBoards extends StatefulWidget {
  @override
  _UserBoardsState createState() => _UserBoardsState();
}

class _UserBoardsState extends State<UserBoards> {
  BoardsBloc get boardsBloc => BlocProvider.of<BoardsBloc>(context);
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    boardsBloc.add(GetBoardsEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<void> _refreshUserBoards() async {
    boardsBloc.add(GetBoardsEvent());
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      boardsBloc.add(GetBoardsEvent());
    }

    return false;
  }

  int calculateItemCount(BoardsState state) =>
      state.hasReachedMax ? state.boards.length : state.boards.length + 1;

  Widget _buildUserBoards(bool isError, [BoardsState state]) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: RefreshIndicator(
        backgroundColor: ThemeColor.menu_bg,
        onRefresh: _refreshUserBoards,
        child: ListView.builder(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: isError ? 1 : calculateItemCount(state),
          itemBuilder: (_, index) {
            return isError
                ? ErrorMessage(message: GET_BOARDS_FAILURE_MASSAGE)
                : index >= state.boards.length
                    ? BasicProgressIndicator()
                    : UserBoardItem(
                        key: ValueKey(state.boards[index].id),
                        board: state.boards[index],
                      );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyMessage() {
    return Center(
      child: Text(
        'No Boards',
        style: TextStyle(fontSize: getSize(25)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BoardsBloc, BoardsState>(
      builder: (_, state) {
        switch (state.status) {
          case BoardsStatus.failure:
            return _buildUserBoards(true);
          case BoardsStatus.success:
            if (state.boards.isEmpty) {
              return _buildEmptyMessage();
            }
            return _buildUserBoards(false, state);
          default:
            return BasicProgressIndicator();
        }
      },
    );
  }
}
