import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = '';

  Future<void> _launchSpotifyAuth() async {
    final url = Uri.parse('http://localhost:8888/login');

    try {
      String res = await FlutterWebAuth2.authenticate(
          url: url.toString(), callbackUrlScheme: 'test-spotify-auth');

      Uri responseUri = Uri.parse(res);
      String? accessToken = responseUri.queryParameters['access_token'];
      String? refreshToken = responseUri.queryParameters['refresh_token'];
      String? userName = responseUri.queryParameters['user_name'];
      String? userEmail = responseUri.queryParameters['user_email'];
      String? userId = responseUri.queryParameters['user_id'];

      if (accessToken != null && refreshToken != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('spotify_access_token', accessToken);
        await prefs.setString('spotify_refresh_token', refreshToken);
        await prefs.setString('user_info', refreshToken);

        setState(() {
          result = "Authorization successful! Access Token: $accessToken & user info $userName $userEmail $userId";
        });
      } else {
        setState(() {
          result = "Authorization failed!";
        });
      }
    } catch (error) {
      setState(() {
        result = "Auth error: $error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Spotify Auth Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _launchSpotifyAuth,
              child: const Text('Authorize with Spotify'),
            ),
            Text(result),
          ],
        ),
      ),
    );
  }
}
