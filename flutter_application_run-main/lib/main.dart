// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_application_run/views/splashScreen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //----- ติดต่อกับ supabase project ที่เราจะทำงานด้วย -----
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ofmlntyajsiyzqscdzvt.supabase.co',
    publishableKey: 'sb_publishable_1BEAEcuAHqTM082qVb-LOQ_Mo5oPOB2',
  );

  //----------------------------------

  runApp(
    const FlutterTrackerApp(),
  );
}

class FlutterTrackerApp extends StatefulWidget {
  const FlutterTrackerApp({super.key});

  @override
  State<FlutterTrackerApp> createState() => _FlutterTrackerAppState();
}

class _FlutterTrackerAppState extends State<FlutterTrackerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUI(),
      theme: ThemeData(
        // useMaterial3: true,
        textTheme: ThemeData.light().textTheme.apply(
              fontFamily: GoogleFonts.kanit().fontFamily,
              fontFamilyFallback: GoogleFonts.kanit().fontFamilyFallback,
            ),
      ),
    );
  }
}
