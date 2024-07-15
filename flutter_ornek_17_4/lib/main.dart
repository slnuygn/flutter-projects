Future<void> main() async {
  await RunTest();
}

Future<void> RunTest(){
  return Future.delayed(Duration(seconds: 1))
      .then(
        (value) => erroredAsync()
      .then(
        (value) => Future.delayed(Duration(seconds: 1)))
      .catchError( (e) {
        print('Error caught! $e');
      }));
}

Future<void> erroredAsync() async {
  throw 'Error!';
}