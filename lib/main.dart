// main.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trying_storing/config/get_it_config.dart';
import 'package:trying_storing/controller/counter_controller.dart';
import 'package:trying_storing/model/handle_model.dart';
import 'package:trying_storing/service/bird_service.dart';
import 'package:trying_storing/model/bird_model.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BirdModelAdapter());
  await Hive.openBox<BirdModel>('birdBox');

  init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterController(),
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  ValueNotifier<ResultModel> result = ValueNotifier(ResultModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePageWithListBird(),
                  ));
            },
            icon: Icon(Icons.toc)),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            result.value = await core.get<BirdServiceImp>().getAllBird();
          },
          child: Text('Get Birds'),
        ),
      ),
    );
  }
}

class HomePageWithListBird extends StatelessWidget {
  HomePageWithListBird({super.key});

  ValueNotifier<ResultModel> result = ValueNotifier(ResultModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: result,
        builder: (context, value, child) {
          if (value is ListOf<BirdModel>) {
            return ListView.builder(
                itemCount: value.modelList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(value.modelList[index].name),
                    leading: Image.network(
                      value.modelList[index].image,
                      errorBuilder: (context, error, stackTrace) {
                        return FlutterLogo();
                      },
                    ),
                  );
                });
          } else if (value is ExceptionModel) {
            return Text(value.message);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        result.value = await BirdServiceImp().getAllBird();
      }),
    );
  }
}
