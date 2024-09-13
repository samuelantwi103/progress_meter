// main.dart
import 'package:flutter/material.dart';
import 'package:progress_meter/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  )
  runApp(MultiProvider(
    providers:[
      ChangeNotifierProvider(create(_)=> MemberProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orange,
          ),
          useMaterial3: true,
          snackBarTheme: SnackBarThemeData(
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
          )),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orange,
            brightness: Brightness.dark
          ),
          brightness: Brightness.dark,
          useMaterial3: true,
          snackBarTheme: SnackBarThemeData(
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
          )),
      themeMode: ThemeMode.light,
      home: LoginPage(),
    );
  }
}
