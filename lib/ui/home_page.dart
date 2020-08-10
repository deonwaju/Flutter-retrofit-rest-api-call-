import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/network/api_service.dart';
import 'package:flutter_apps/network/model/task_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api test"),
      ),
      body: _listFutureTask(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final api = Provider.of<ApiService>(context, listen: false);
          api
              .getTasks()
              .then((value) =>
              value.forEach((element) {
                print(element.title);
              }))
              .catchError((onError) {
            print(onError.toString());
          });
        },
        child: Icon(Icons.terrain),
      ),
    );
  }
}

FutureBuilder _listFutureTask(BuildContext context) {
  return FutureBuilder<List<TaskModel>>(
    future: Provider.of<ApiService>(context, listen: false).getTasks(),
    builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return Container(
            child: Center(
              child: Text(
                  "Please check your internet and try again"
              ),
            ),
          );
        }
        final tasks = snapshot.data;
        return _listViewTask(context: context, tasks: tasks);
      } else {
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    },
  );
}

ListView _listViewTask({BuildContext context, List<TaskModel> tasks}) {
  return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(tasks[index].url),
              title: Text(tasks[index].title),
              subtitle: Text(tasks[index].thumbnailUrl),
            ),
          ),
        );
      });
}

