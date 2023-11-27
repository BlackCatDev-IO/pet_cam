import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:pet_cam/p2p_connections/bloc/p2p_bloc.dart';
import 'package:pet_cam/settings/bloc/settings_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final widgets = [
    const ViewerTab(),
    const CameraTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final settingsBloc = context.read<SettingsBloc>();

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        if (state.deviceRole.isNotSet) {
          return const SetupScreen();
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Pet Cam'),
          ),
          body: widgets[settingsBloc.state.deviceRole.index],
          bottomNavigationBar: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              log('state index ${state.deviceRole.index}');
              return NavigationBar(
                selectedIndex: state.deviceRole.index,
                onDestinationSelected: (int index) {
                  log('Nav index: $index');

                  if (index == 0) {
                    settingsBloc
                        .add(SetDeviceRole(deviceRole: DeviceRole.viewer));
                  } else {
                    settingsBloc
                        .add(SetDeviceRole(deviceRole: DeviceRole.camera));
                  }
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.videocam),
                    label: 'Viewer',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.camera_alt),
                    label: 'Camera',
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Settings',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class CameraTab extends StatefulWidget {
  const CameraTab({super.key});

  @override
  State<CameraTab> createState() => _CameraTabState();
}

class _CameraTabState extends State<CameraTab> {
  @override
  void initState() {
    super.initState();
    final deviceRole = context.read<SettingsBloc>().state.deviceRole;
    final p2pBloc = context.read<P2PBloc>();
    if (deviceRole.isCamera) {
      p2pBloc.add(CreateAndSendRtcOffer());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Camera',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class ViewerTab extends StatefulWidget {
  const ViewerTab({
    super.key,
  });

  @override
  State<ViewerTab> createState() => _ViewerTabState();
}

class _ViewerTabState extends State<ViewerTab> {
  final _localRenderer = RTCVideoRenderer();
  final _remoteRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _localRenderer.initialize();
    _remoteRenderer.initialize();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p2pBloc = context.read<P2PBloc>();
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => p2pBloc.add(ConnectToRemoteCamera()),
            child: const Text('View Remote Camera Feed'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => p2pBloc.add(ToggleCamera()),
            child: const Text('Toggle Camera'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () =>
                p2pBloc.add(CloseConnection(localVideo: _localRenderer)),
            child: const Text('Disconnect'),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: BlocBuilder<P2PBloc, P2PState>(
              builder: (context, state) {
                log('remoteStream: ${state.remoteStream}}');

                if (state.connectionStatus.isConnected) {
                  _remoteRenderer.srcObject = state.remoteStream;
                } else if (_remoteRenderer.srcObject != null) {
                  _remoteRenderer.srcObject = null;
                }

                log('_remoteRenderer: $_remoteRenderer');
                return switch (state.connectionStatus) {
                  ConnectionStatus.connecting =>
                    const Center(child: CircularProgressIndicator()),
                  ConnectionStatus.connected => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RTCVideoView(_remoteRenderer),
                        ),
                      ],
                    ),
                  _ => const SizedBox(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final settingsBloc = context.read<SettingsBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                settingsBloc.add(SetDeviceRole(deviceRole: DeviceRole.viewer));
              },
              child: const Text('Set Viewer Role'),
            ),
            ElevatedButton(
              onPressed: () {
                settingsBloc.add(SetDeviceRole(deviceRole: DeviceRole.camera));
              },
              child: const Text('Set Camera Role'),
            ),
          ],
        ),
      ),
    );
  }
}
