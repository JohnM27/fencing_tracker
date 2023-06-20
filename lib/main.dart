import 'package:fencing_tracker/application/authentication_service.dart';
import 'package:fencing_tracker/router.dart';
import 'package:fencing_tracker/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _router = router;

  ThemeData _buildTheme() {
    ThemeData themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: CustomColors.purple,
        brightness: Brightness.dark,
        outline: CustomColors.white,
        secondaryContainer: CustomColors.purple,
        primaryContainer: CustomColors.purple,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: CustomColors.purple.withOpacity(0.5),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: CustomColors.purple.withOpacity(0.5),
      ),
      useMaterial3: true,
    );
    return themeData.copyWith(
      textTheme: GoogleFonts.oxygenTextTheme(themeData.textTheme),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthenticationService(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Fencing tracker',
        theme: _buildTheme(),
        routerConfig: _router,
      ),
    );
  }
}
