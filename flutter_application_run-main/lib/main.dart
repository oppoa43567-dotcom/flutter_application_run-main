import 'package:flutter/material.dart';
import 'package:flutter_application_run/views/splashScreen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//-----------------------------
void main() {
//----------โค้ดตืิดต่อกับ supabase โปรเจ็กต์ที่เราจะทำงานด้วย--------------------
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://zqjzjzqzqzjzjzqzqzjz.supabase.co',
    sup

  );
  //-----------------------------------------------
  runApp(
    FlutterRunTrackerApp(),
  );
}

//-----------------------------
class FlutterRunTrackerApp extends StatefulWidget {
  const FlutterRunTrackerApp({super.key});

  @override
  State<FlutterRunTrackerApp> createState() => _FlutterRunTrackerAppState();
}

class _FlutterRunTrackerAppState extends State<FlutterRunTrackerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
      theme: ThemeData(
        textTheme: TextTheme.of(context).apply(
          fontFamily: GoogleFonts.kanit().fontFamily,
          fontFamilyFallback: GoogleFonts.kanit().fontFamilyFallback,
        ),
      ),
    );
  }
}
