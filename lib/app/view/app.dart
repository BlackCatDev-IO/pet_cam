import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_cam/l10n/l10n.dart';
import 'package:pet_cam/lifecycle/cubit/lifecycle_cubit.dart';
import 'package:pet_cam/p2p_connections/bloc/p2p_bloc.dart';
import 'package:pet_cam/p2p_connections/socket_repository.dart';
import 'package:pet_cam/p2p_connections/view/home_page.dart';
import 'package:pet_cam/settings/bloc/settings_bloc.dart';
import 'package:pet_cam/theme/app_theme.dart';

import 'package:pet_cam/web_rtc/web_rtc_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<P2PBloc>(
          create: (context) => P2PBloc(
            socketRepository: SocketRepository(),
            webRtcService: WebRtcService(),
          )..add(InitSocketEventListener()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => SettingsBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => LifecycleCubit(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: AppTheme.theme,
        home: const HomePage(),
      ),
    );
  }
}
