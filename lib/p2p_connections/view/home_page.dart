import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:pet_cam/p2p_connections/bloc/p2p_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final socketBloc = context.read<P2PBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Cam'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                socketBloc.add(
                  SocketCreateRoom(),
                );
              },
              child: const Text('Send Camera Feed'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => socketBloc.add(SocketJoinRoom()),
              child: const Text('View Remote Camera Feed'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                socketBloc.add(
                  SocketEmitEvent(
                    eventName: 'room_message',
                    data: {
                      'room': 'pet_cam_room',
                      'message': 'test message',
                    },
                  ),
                );
              },
              child: const Text('Room Message'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => socketBloc.add(ToggleCamera()),
              child: const Text('Toggle Camera'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => socketBloc
                  .add(SocketCloseConnection(localVideo: _localRenderer)),
              child: const Text('Disconnect'),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: BlocBuilder<P2PBloc, SocketState>(
                  builder: (context, state) {
                    log('remoteStream: ${state.remoteStream}}');

                    if (state.connectionStatus.isDisconnected) {
                      return const SizedBox();
                    }

                    if (state.connectionStatus.isConnecting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.connectionStatus.isConnected) {
                      _remoteRenderer.srcObject = state.remoteStream;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RTCVideoView(_remoteRenderer),
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
