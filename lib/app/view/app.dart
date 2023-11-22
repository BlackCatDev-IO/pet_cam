import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_cam/l10n/l10n.dart';
import 'package:pet_cam/p2p_connections/bloc/p2p_bloc.dart';
import 'package:pet_cam/p2p_connections/socket_repository.dart';
import 'package:pet_cam/p2p_connections/view/home_page.dart';

import 'package:pet_cam/web_rtc/web_rtc_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<P2PBloc>(
      create: (context) => P2PBloc(
        socketRepository: SocketRepository(),
        webRtcService: WebRtcService(),
      )..add(InitSocketEventListener()),
      lazy: false,
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 33, 33, 33),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 33, 33, 33),
            foregroundColor: Colors.white,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
