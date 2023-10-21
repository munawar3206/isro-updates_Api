import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newsapp/models/spaceResponse.dart';
import 'package:newsapp/services/space_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() => isAlertSet = true);
        }
      });

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Discover",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextSpan(
                  text: "The ISRO",
                  style: TextStyle(
                      color: Color.fromARGB(255, 167, 155, 255),
                      fontSize: 20,
                      fontWeight: FontWeight.bold))
            ])

                // style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
            const Text(
              "Find intresting article and Updates",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: FutureBuilder<List<Space>>(
              future: NewsApiServices().fetchSpaceArticle(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.redAccent,
                  ));
                } else {
                  return Container(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(
                              snapshot.data![index].name.toString(),
                              style: const TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                            Text(
                              snapshot.data![index].link.toString(),
                              style: const TextStyle(color: Colors.blue),
                            ),
                            Text(
                              snapshot.data![index].payload.toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 34, 0, 255)),
                            ),
                            Text(
                              snapshot.data![index].missionStatus.toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 83, 12)),
                            ),
                            Card(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      snapshot.data![index].payload.toString(),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index].launchDate
                                          .toString(),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ))
          ],
        ),
      )),
    );
  }
  
   showDialogBox()=>showCupertinoDialog<String>(context: context, builder: (BuildContext context) => CupertinoAlertDialog(
    title: const Text("No Connection"),
    content: const Text('Please check Internet'),
    actions:<Widget> [
      TextButton(onPressed: (){}, child: Text("OK"))
    ],
   ));
}
