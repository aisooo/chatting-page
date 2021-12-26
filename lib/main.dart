import 'dart:html';

import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

Future<void> main() async {
  const apiKey = 'b67pax5b2wdq';
  const userToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoidHV0b3JpYWwtZmx1dHRlciJ9.S-MJpoSwDiqyXpUURgO5wVqJ4vKlIVFLSEyrFYCOE1c';

  final client = StreamChatClient(
    apiKey,
    logLevel: Level.INFO,
  );

  await client.connectUser(
    User(
      id: '#',
    ),
    userToken,
  );
  final channel = client.channel('messaging', id: '#');
  channel.watch();

  runApp(MyApp(client, channel));
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;

  final Channel channel;

  MyApp(this.client, this.channel);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.dark().copyWith(accentColor: Color(0xff5ac18e));
    return MaterialApp(
      builder: (context, widget) {
        return StreamChat(
            child: widget,
            client: client,
            streamChatThemeData: StreamChatThemeData.fromTheme(theme));
      },
      home: StreamChannel(
        channel: channel,
        child: ChannelPage(),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(
        showBackButton: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: MessegeListView(),
          ),
          MessegeInput(),
        ],
      ),
    );
  }

  MessegeListView() {}

  MessegeInput() {}
}


