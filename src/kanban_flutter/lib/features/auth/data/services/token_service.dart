import 'dart:async';
import 'dart:convert';

import '../../../../di/injection_container.dart';
import '../../presentation/blocs/user_bloc/user_bloc.dart';

class TokenService {
  static UserBloc _userBloc = sl<UserBloc>();
  static Timer _timer;

  static Map<String, dynamic> decode(String token) {
    try {
      List<String> splitToken = token.split(".");
      String payloadBase64 = splitToken[1];
      String normalizedPayload = base64.normalize(payloadBase64);
      String payloadString = utf8.decode(base64.decode(normalizedPayload));
      Map<String, dynamic> decodedPayload = jsonDecode(payloadString);

      return decodedPayload;
    } catch (error) {
      return null;
    }
  }

  static DateTime getExpirationDate(String token) {
    final Map<String, dynamic> decodedToken = decode(token);

    if (decodedToken != null) {
      final DateTime expirationDate = new DateTime.fromMillisecondsSinceEpoch(0)
          .add(new Duration(seconds: decodedToken['exp']));
      return expirationDate;
    } else {
      return null;
    }
  }

  static void startRefreshTokenTimer(String token) {
    final expires = getExpirationDate(token).millisecondsSinceEpoch;
    final timeout =
        expires - DateTime.now().millisecondsSinceEpoch - (60 * 1000);

    _timer = Timer(
      Duration(milliseconds: timeout),
      () => _userBloc.add(CurrentUserEvent()),
    );
  }

  static void stopRefreshTokenTimer() => _timer.cancel();
}
