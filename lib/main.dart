import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:the_solomon_project/convo_detail_bloc/convo_detail_bloc.dart';
import 'package:the_solomon_project/convo_page.dart';
import 'package:the_solomon_project/entities/convo_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
        providers: [
          BlocProvider(create: (context) => ConvoDetailBloc()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor seedColor = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: seedColor,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: seedColor,
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: ConvoListPage(),
    );
  }
}

class ConvoListPage extends StatelessWidget {
  ConvoListPage({Key? key}) : super(key: key);

  final List<ConvoPreview> convos = [
    ConvoPreview(
      title: 'Moving Out',
      lastMessage: 'I think you should...',
      lastMessageTime: DateTime.now(),
      id: '1',
      isFavorite: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Soloman Project'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Convo list
            Expanded(
              child: ListView.builder(
                itemCount: convos.length,
                itemBuilder: (context, index) {
                  final convo = convos[index];
                  // today, yesterday, or date
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          icon: Icons.star,
                          onPressed: (_) {},
                        ),
                        SlidableAction(
                          icon: Icons.delete,
                          backgroundColor: Colors.red,
                          onPressed: (_) {},
                        ),
                      ],
                    ),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => ConvoPage(
                                convoId: convo.id,
                              ),
                            ),
                          );
                        },
                        title: Text(
                          convo.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(convo.lastMessage),
                        trailing: convo.isFavorite
                            ? const Icon(Icons.star)
                            : const SizedBox.shrink(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ConvoPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
