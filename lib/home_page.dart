import 'package:flutter/material.dart';

import 'models/post.dart';
import 'services/dummy_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static String routeName = 'home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Boilerplate')),
      body: FutureBuilder(
        future: DummyService.getPostsWithCaching(),
        builder: (context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async => setState(() {}),
              child: ListView.separated(
                separatorBuilder: (context, idx) => const Divider(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text('${snapshot.data![index].id}'),
                    ),
                    title: Text(snapshot.data![index].title!),
                    subtitle: Text(snapshot.data![index].body!),
                  );
                },
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
