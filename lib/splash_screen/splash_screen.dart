import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imaginate/feature/prompt/ui/create_prompt_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const CreatePromptScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[800],
        child: const Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                                foregroundImage: AssetImage("assets/splash_screen_image.jpeg"),
                              ),
                ),
              SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  
                  color: Colors.yellow,
                ),
              )
              ],
            ),
            Text(
              "Imaginate AI",
              style: TextStyle(
                color: Colors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        )),
      ),
    );
  }
}
