import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kanban_flutter/common/widgets/index.dart';
import 'package:kanban_flutter/core/error/failures.dart';
import 'package:kanban_flutter/di/injection_container.dart';
import 'package:kanban_flutter/features/boards/presentation/blocs/index.dart';
import 'package:kanban_flutter/features/boards/presentation/pages/home/home_page.dart';
import 'package:shimmer/shimmer.dart';

import '../../style/index.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  BoardsBloc _boardsBloc;

  @override
  void initState() {
    super.initState();
    _boardsBloc = sl<BoardsBloc>();
    _boardsBloc.add(GetBoardsEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _boardsBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      backgroundColor: ThemeColor.board_bg,
      body: BlocProvider(
        create: (_) => _boardsBloc,
        child: BlocBuilder<BoardsBloc, BoardsState>(
          builder: (_, state) {
            switch (state.status) {
              case BoardsStatus.failure:
                return ErrorMessage(message: GET_BOARDS_FAILURE_MASSAGE);
              case BoardsStatus.success:
                return HomePage();
              default:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: getProportionateWidth(5),
                            horizontal: getProportionateWidth(15),
                          ),
                          color: ThemeColor.default_border,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: FaIcon(
                              FontAwesomeIcons.gitAlt,
                              size: getProportionateWidth(80),
                              color: ThemeColor.accent,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateHeight(20)),
                      Shimmer.fromColors(
                        baseColor: ThemeColor.accent,
                        highlightColor: ThemeColor.default_border,
                        child: Text(
                          'Git Boards',
                          style: TextStyle(
                            fontSize: getProportionateWidth(50),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
