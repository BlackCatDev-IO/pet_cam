import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_cam/l10n/l10n.dart';
import 'package:pet_cam/sockets/bloc/socket_bloc.dart';
import 'package:pet_cam/sockets/socket_repository.dart';
import 'package:pet_cam/sockets/view/socket_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SocketBloc>(
      create: (context) => SocketBloc(
        socketRepository: SocketRepository(),
      )..add(SocketInitListener()),
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
          colorScheme: ColorScheme.fromSwatch(
            accentColor: const Color(0xFF13B9FF),
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SocketPage(),
      ),
    );
  }
}
