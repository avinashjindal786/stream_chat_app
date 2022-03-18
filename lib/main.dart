import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'config.dart';
import 'package:stream_chat_app/api/stream_api.dart';

import 'package:stream_chat_app/api/page/channal_list.dart';
Future main() async {
  final client = StreamChatClient(Config.apiKey, logLevel: Level.SEVERE);

  await StreamApi.initUser(
    client,
    username: 'Emily',
    urlImage:
    'https://cdn1.iconfinder.com/data/icons/user-pictures/100/female1-512.png',
    id: Config.idEmily,
    token: Config.tokenEmily,
  );

//  await StreamApi.initUser(
//    client,
//    username: 'Peter',
//    urlImage:
//        'https://png.pngtree.com/png-vector/20190710/ourmid/pngtree-user-vector-avatar-png-image_1541962.jpg',
//    id: Config.idPeter,
//    token: Config.tokenPeter,
//  );

 final channel = await StreamApi.createChannel(
   client,
   type: 'messaging',
   id: 'sample2',
   name: 'Family',
   image:
       'https://image.freepik.com/fotos-kostenlos/glueckliche-familie-in-einer-reihe-liegen_1098-1101.jpg',
   idMembers: [Config.idEmily, Config.idPeter],
 );

  // final channel = await StreamApi.watchChannel(
  //   client,
  //   type: 'messaging',
  //   id: 'sample',
  // );

  runApp(MyApp(client: client,channel: channel,));
}

class MyApp extends StatelessWidget {
  final StreamChatClient client;
  final Channel channel;
   MyApp({required this.client,required this.channel});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Chat',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Stream Chat', client: client,channel: channel,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title,required this.client,required this.channel}) ;

  final Channel channel;
  final StreamChatClient client;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:  StreamChat(
        streamChatThemeData: StreamChatThemeData(
          otherMessageTheme:MessageThemeData(
            messageTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          ownMessageTheme: MessageThemeData(
            messageTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
            avatarTheme: AvatarThemeData(
              constraints: BoxConstraints(maxWidth: 80, maxHeight: 80),
              borderRadius: BorderRadius.circular(120),
            ),
          ),
        ),
        child: ChannelListPage(),
        client: widget.client,
      ),
    );
  }
}
