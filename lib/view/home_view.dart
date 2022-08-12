import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:readmore/readmore.dart';
import '../widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Blogs'),
        ),
        drawer: const CustomDrawer(),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var doc = snapshot.data!.docs[index];
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 8, bottom: 2),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.blue,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                doc['username'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.network(doc['postUrl']),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc['title'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                               Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.only(top: 1),
                                child: ReadMoreText(
                                  doc['description'],
                                  trimCollapsedText: ' show more',
                                  trimExpandedText: ' show less',
                                  trimLines: 3,
                                  trimMode: TrimMode.Line,
                                  lessStyle: const TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                  moreStyle: const TextStyle(
                                      color: Colors.blue, fontSize: 12),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd()
                                    .format(DateTime.parse(
                                        doc['datePublished'].toString()))
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider()
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasData) {
              return const Center(
                child: Text('Something Went Wrong'),
              );
            } else {
              return const Center(
                child: Text('No Blogs'),
              );
            }
          },
        ));
  }
}
