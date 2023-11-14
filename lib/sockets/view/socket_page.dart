import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_cam/sockets/bloc/socket_bloc.dart';

class SocketPage extends StatelessWidget {
  SocketPage({super.key});

  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SocketBloc, SocketState>(
        builder: (context, state) {
          final socketBloc = context.read<SocketBloc>();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              OutlinedButton(
                onPressed: () => socketBloc.add(
                  SocketEmitEvent(
                    eventName: SocketEvents.send.name,
                    data: {'message': _textController.text},
                  ),
                ),
                child: const Text('Send'),
              ),
              TextFormField(
                controller: _textController,
                onFieldSubmitted: (value) => socketBloc.add(
                  SocketEmitEvent(
                    eventName: SocketEvents.send.name,
                    data: {'message': value},
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.receivedMessages.length,
                  itemBuilder: (context, index) {
                    return Text(
                      state.receivedMessages[index],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
