import 'package:flutter/material.dart';
import 'package:flutterreststarter/services/dummy_service.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter REST Starter"),
      ),
      body: FutureBuilder(
        future: DummyService.getPosts(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              separatorBuilder: (context, int) => Divider(),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  // leading: ,
                  title: Text(snapshot.data[index]['title']),
                  subtitle: Text(snapshot.data[index]['body']),
                );
              },
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
