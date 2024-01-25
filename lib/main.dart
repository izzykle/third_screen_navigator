import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Named Routes Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => const FirstScreen(),
        '/second': (context) => const SecondScreen(),
        '/third': (context) => const ThirdScreen(),
      },
    ),
  );
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _navigateToSecond(context);
          },
          child: const Text('Launch second screen'),
        ),
      ),
    );
  }

  void _navigateToSecond(BuildContext context) {
    Navigator.pushNamed(context, '/second', arguments: '/');
  }
}

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  SecondScreenState createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  late String buttonText;
  late String previousRouteName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    previousRouteName = ModalRoute.of(context)?.settings.arguments as String? ?? '/';
    buttonText = _getButtonText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            _navigate(context);
          },
          child: Text(buttonText),
        ),
      ),
    );
  }

  void _navigate(BuildContext context) async {
    final String? previousRouteName = ModalRoute.of(context)?.settings.arguments as String?;

    if (previousRouteName == '/third') {
      Navigator.pushReplacementNamed(context, '/');
    } else if (previousRouteName == '/') {
      Navigator.pushNamed(context, '/third');
    }
  }

  String _getButtonText() {
    return 'Navigate to ${previousRouteName == '/third' ? 'First' : 'Third'} screen';
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _navigateToSecond(context);
          },
          child: const Text('Launch second screen'),
        ),
      ),
    );
  }

  void _navigateToSecond(BuildContext context) {
    Navigator.pushNamed(context, '/second', arguments: '/third');
  }
}
