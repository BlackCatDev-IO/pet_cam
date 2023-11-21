import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_cam/l10n/l10n.dart';
import 'package:pet_cam/sockets/bloc/socket_bloc.dart';
import 'package:pet_cam/sockets/socket_repository.dart';
import 'package:pet_cam/sockets/view/socket_page.dart';
import 'package:pet_cam/web_rtc/web_rtc_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocketBloc>(
      create: (context) => SocketBloc(
        socketRepository: SocketRepository(),
        webRtcService: WebRtcService(),
      )..add(SocketInitEventListener()),
      lazy: false,
      child: const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SocketPage(),
      ),
    );
  }
}
