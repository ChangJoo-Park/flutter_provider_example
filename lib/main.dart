import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Counter
///
/// Counter의 현재 상태는 [_count]에 담는다.
/// [increment] 메소드로 [_count]를 증가시키고, 리스너에 변경사항을 알린다.
class Counter with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (_) => Counter(),
        ),
      ],

      /// [MaterialApp] 전역에서 Counter를 사용할 수 있도록 Counsumer를 이용한다.
      child: Consumer<Counter>(builder: (context, counter, _) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Flutter Provider Example'),
        );
      }),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  Widget get _appbar {
    return AppBar(
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      body: Center(
        child: CounterLabel(),
      ),
      floatingActionButton: IncrementCounterFab(),
    );
  }
}

/// IncrementCounterFab
///
/// Fab이 눌리면 [Counter] Provider의 increment를 호출한다.
class IncrementCounterFab extends StatelessWidget {
  const IncrementCounterFab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return FloatingActionButton(
      onPressed: counter.increment,
      child: Icon(Icons.add),
    );
  }
}

/// CounterLabel
///
/// build 메소드 안에서 리스너가 변경을 수신하면 count 정보를 변경한다.
class CounterLabel extends StatelessWidget {
  const CounterLabel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return Text('${counter.count}');
  }
}
