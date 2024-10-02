import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sample_app_with_dio/my_repo.dart';
import 'package:sample_app_with_dio/user.dart';
import 'package:sample_app_with_dio/web_service.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User>? users;
  Future read() async {
    var dio = Dio();
    var webService = WebService(dio);
    var myRepo = MyRepo(webService);
    users = await myRepo.getAllUsers();
  }

  @override
  void initState() {
    super.initState();
    read();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: FutureBuilder(
            future: read(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: ListView.builder(
                        itemCount: users!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: ListTile(
                              tileColor:
                                  users![index].status.toString() == "active"
                                      ? Colors.green[800]
                                      : Colors.red,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(users![index].name.toString()),
                                      Text(users![index].gender.toString()),
                                    ],
                                  ),
                                  Text(users![index].email.toString()),
                                ],
                              ),
                            ),
                          );
                        }));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
