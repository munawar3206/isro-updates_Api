import 'package:flutter/material.dart';
import 'package:newsapp/models/spaceResponse.dart';
import 'package:newsapp/services/space_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(TextSpan(children: [
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
            Text(
              "Find intresting article and Updates",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: FutureBuilder<List<Space>>(
              future: NewsApiServices().fetchSpaceArticle(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
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
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                            Text(
                              snapshot.data![index].link.toString(),
                              style: TextStyle(color: Colors.blue),
                            ),
                            Text(
                              snapshot.data![index].payload.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 34, 0, 255)),
                            ),
                            Text(
                              snapshot.data![index].missionStatus.toString(),
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 83, 12)),
                            ),
                            // Image(
                            //     image: NetworkImage(snapshot
                            //         .data![index].
                            //         .toString())),
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
}
