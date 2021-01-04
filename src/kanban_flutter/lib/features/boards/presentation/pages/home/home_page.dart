import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../common/widgets/index.dart';
import '../../../../../di/injection_container.dart';
import '../../../../../style/index.dart';
import '../../../../auth/data/services/token_service.dart';
import '../../../../auth/presentation/blocs/user_bloc/user_bloc.dart';
import '../../blocs/index.dart';
import 'components/index.dart';

final List<Widget> _pages = [
  BoardTemplates(),
  UserBoards(),
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  BoardBloc _boardBloc;
  BoardsBloc _boardsBloc;
  UserBloc _userBloc;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    _boardBloc = sl<BoardBloc>();
    _boardsBloc = sl<BoardsBloc>();
    _userBloc = sl<UserBloc>();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();

    _boardBloc.close();
    _boardsBloc.close();
    _userBloc.close();

    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        TokenService.stopRefreshTokenTimer();
        break;
      case AppLifecycleState.resumed:
        _userBloc.add(CurrentUserEvent());
        break;
      default:
        break;
    }
  }

  void _onBottomNavigationTap(int index) {
    if (index != _selectedIndex) {
      setState(() => _selectedIndex = index);
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (index) => _onBottomNavigationTap(index),
      currentIndex: _selectedIndex,
      backgroundColor: ThemeColor.board_header_bg,
      selectedItemColor: ThemeColor.light_blue,
      unselectedItemColor: ThemeColor.text_normal,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(
        fontSize: getSize(ThemeSize.fs_17),
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: getSize(ThemeSize.fs_17),
      ),
      items: [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.list),
          label: 'Boards',
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      brightness: Brightness.dark,
      automaticallyImplyLeading: false,
      backgroundColor: ThemeColor.board_header_bg,
      title: Text('Git Boards'),
      leading: Builder(
        builder: (context) => IconButton(
          splashColor: ThemeColor.accent.withOpacity(0.3),
          highlightColor: ThemeColor.accent.withOpacity(0.3),
          color: ThemeColor.text_normal,
          icon: Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
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
          create: (_) => _boardsBloc,
        ),
        BlocProvider(
          create: (_) => _userBloc,
        ),
      ],
      child: Scaffold(
        backgroundColor: ThemeColor.board_bg,
        bottomNavigationBar: _buildBottomNavigationBar(),
        appBar: _buildAppBar(),
        drawer: NavDrawer(),
        body: Padding(
          padding: EdgeInsets.all(getSize(15)),
          child: PageTransitionSwitcher(
            reverse: _selectedIndex == 0,
            duration: Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return SharedAxisTransition(
                child: child,
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                fillColor: Colors.transparent,
                transitionType: SharedAxisTransitionType.horizontal,
              );
            },
            child: _pages.elementAt(_selectedIndex),
          ),
        ),
      ),
    );
  }
}
