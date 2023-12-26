import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:the_solomon_project/convo_detail_bloc/convo_detail_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_solomon_project/entities/message.dart';

class ConvoPage extends StatelessWidget {
  final String? convoId;
  ConvoPage({this.convoId, super.key});

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  void updateConvoTitle(String title, BuildContext context) {
    context.read<ConvoDetailBloc>().add(UpdateConvoTitle(title: title));
  }

  void sendMessage(String text, bool fromSoloman, BuildContext context) {
    if (text.isNotEmpty) {
      final Message message = Message(
        text: text,
        createdAt: DateTime.now(),
        id: 'X',
        fromSoloman: fromSoloman,
      );
      context.read<ConvoDetailBloc>().add(SendMessage(message: message));
      _messageController.clear();
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 1000,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }

    _messageFocusNode.requestFocus();
  }

  void switchPerson(bool toSolomon, BuildContext context) {
    context.read<ConvoDetailBloc>().add(SwitchPerson(toSolomon: toSolomon));
  }

  @override
  Widget build(BuildContext context) {
    if (convoId == null) {
      context.read<ConvoDetailBloc>().add(NewConvo());
    } else {
      context.read<ConvoDetailBloc>().add(ConvoDetailLoad(convoId: convoId!));
    }

    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<ConvoDetailBloc, ConvoDetailState>(
          builder: (context, state) {
            if (state is ConvoDetailLoaded) {
              return TextField(
                controller: _titleController
                  ..text = state.title
                  ..selection = TextSelection.fromPosition(
                    TextPosition(offset: state.title.length),
                  ),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  updateConvoTitle(value, context);
                },
              );
            }
            return const Text('Loading...');
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: BlocBuilder<ConvoDetailBloc, ConvoDetailState>(
              builder: (context, state) {
                if (state is ConvoDetailLoaded) {
                  final bool amSolomon = state.isSolomon;
                  return ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                      controller: _scrollController,
                      physics: const ClampingScrollPhysics(),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: state.messages[index].fromSoloman != amSolomon
                              ? OtherBubble(
                                  message: state.messages[index],
                                )
                              : SelfBubble(
                                  message: state.messages[index],
                                ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Text('Loading...');
                }
              },
            )),
            // Solomon switch
            BlocBuilder<ConvoDetailBloc, ConvoDetailState>(
              builder: (context, state) {
                if (state is ConvoDetailLoaded) {
                  return SwitchListTile(
                    title: const Text('Solomon'),
                    value: state.isSolomon,
                    onChanged: (value) {
                      switchPerson(value, context);
                    },
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),

            // Message input
            BlocBuilder<ConvoDetailBloc, ConvoDetailState>(
              builder: (context, state) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          focusNode: _messageFocusNode,
                          onSubmitted: (value) {
                            if (state is ConvoDetailLoaded) {
                              sendMessage(value, state.isSolomon, context);
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: 'Type a message...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (state is ConvoDetailLoaded) {
                            sendMessage(_messageController.text,
                                state.isSolomon, context);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OtherBubble extends StatelessWidget {
  final Message message;

  const OtherBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
                border: Border.all(
                  color: Colors.grey[400]!,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SelfBubble extends StatelessWidget {
  final Message message;

  const SelfBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      alignment: Alignment.topRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                border: Border.all(
                  color: Colors.blue[400]!,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
