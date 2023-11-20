import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:pet_cam/sockets/bloc/socket_bloc.dart';

class SocketPage extends StatefulWidget {
  const SocketPage({super.key});

  @override
  State<SocketPage> createState() => _SocketPageState();
}

class _SocketPageState extends State<SocketPage> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pet Cam'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Open camera & microphone'),
          ),
          const SizedBox(
            width: 8,
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              context.read<SocketBloc>().add(
                    SocketCreateRoom(
                      localVideo: _localRenderer,
                      remoteVideo: _remoteRenderer,
                    ),
                  );
            },
            child: const Text('Create room'),
          ),
          const SizedBox(
            width: 8,
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SocketBloc>().add(
                    SocketJoinRoom(),
                  );
            },
            child: const Text('Join room'),
          ),
          const SizedBox(
            width: 8,
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SocketBloc>().add(
                    SocketEmitEvent(
                      eventName: 'room_message',
                      data: {
                        'room': 'test room 1',
                        'message': 'test message',
                      },
                    ),
                  );
              // signaling.hangUp(_localRenderer);
            },
            child: const Text('Room Message'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Hangup'),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: BlocSelector<SocketBloc, SocketState, MediaStream?>(
                selector: (state) => state.remoteStream,
                builder: (context, remoteStream) {
                  log('remoteStream: $remoteStream');
                  if (remoteStream != null) {
                    _remoteRenderer.srcObject = remoteStream;
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: BlocSelector<SocketBloc, SocketState, MediaStream?>(
                selector: (state) => state.localStream,
                builder: (context, localStream) {
                  log('remoteStream: $localStream');
                  if (localStream != null) {
                    _localRenderer.srcObject = localStream;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: RTCVideoView(_localRenderer),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Join the following Room: '),
                Flexible(
                  child: TextFormField(
                    controller: textEditingController,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
