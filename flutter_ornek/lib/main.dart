import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  myApp(){
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState();

  int _counter = 0;

  void _incrementCounter() {

    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {  },

          ),
          const Icon(Icons.add),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                print('increment pressed');
                _incrementCounter();
              },
              child: const Text(
                'Increment',
              ),
            ),
            Yazi('şu anki değer $_counter'),
            Sayac(
                'dışarıdaki değer $_counter',
                ilkDeger: 3,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

    );
  }
}



class Yazi extends StatelessWidget {
  final String icerik;
  const Yazi(this.icerik, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(icerik);
  }
}

class Sayac extends StatefulWidget{
  final String baslik;
  final int ilkDeger;
  const Sayac(this.baslik,{super.key, required this.ilkDeger});

  @override
  _SayacState createState() => _SayacState();
}

class _SayacState extends State<Sayac> {
  int sayi = 0;

  @override
  void initState() {
    super.initState();
    sayi = widget.ilkDeger;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {

          setState(() {
            sayi++;
          });

        },
        child: Text(
            '${widget.baslik}, içerideki $sayi'
        ));
  }
}

