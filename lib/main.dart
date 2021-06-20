import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pexel/root/root.dart';
import 'package:pexel/stateprovider/stateProvider.dart';
import 'package:provider/provider.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
        create:  (context)=>CurrentState (),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,

          home: OurRoot(),
        ),
      );
  }
}

