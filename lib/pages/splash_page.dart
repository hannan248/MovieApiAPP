import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:movie/Model/app_config.dart';
import 'package:movie/services/http_service.dart';
import 'package:movie/services/movie_service.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({super.key, required this.onInitializationComplete});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
    ).then(
      (_) => _setup(context).then(
        (_) => widget.onInitializationComplete(),
      ),
    );
  }

  Future<void> _setup(BuildContext context) async {
    final getIt = GetIt.instance;
    final configFile = await rootBundle.loadString('assets/config/main.json');
    final configData = jsonDecode(configFile);
    getIt.registerSingleton<AppConfig>(
      AppConfig(
        configData['BASE_API_URL'],
        configData['BASE_IMAGE_API_URL'],
        configData['API_KEY'],
      ),
    );

    getIt.registerSingleton<HTTPService>(HTTPService(),);
    getIt.registerSingleton<MovieService>(MovieService(),);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/logo.png'),
                fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
