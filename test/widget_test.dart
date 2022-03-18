// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stream_chat_app/main.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_app/config.dart';
import 'package:stream_chat_app/api/stream_api.dart';
void main() async {
  final client = StreamChatClient(Config.apiKey, logLevel: Level.SEVERE);
  final channel = await StreamApi.createChannel(
    client,
    type: 'messaging',
    id: 'sample2',
    name: 'Family',
    image:
    'https://image.freepik.com/fotos-kostenlos/glueckliche-familie-in-einer-reihe-liegen_1098-1101.jpg',
    idMembers: [Config.idEmily, Config.idPeter],
  );
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(client: client, channel: channel));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
