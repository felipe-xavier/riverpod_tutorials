import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import '../notifiers.dart';

final _counterProvider = StateNotifierProvider<CounterStateNotifier>((ref) {
  return CounterStateNotifier();
});

final isEvenProvider = Provider<bool>((ref) {
  final counter = ref.watch(_counterProvider.state);
  return (counter.count % 4 == 0);
});

class CounterStateNotifierPage extends ConsumerWidget {
  const CounterStateNotifierPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final counter = watch(_counterProvider.state);
    return Scaffold(
      appBar: AppBar(
        title: Text('State Notifier Page'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Count: ${counter.count}'),
            const IsEvenCounter(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read(_counterProvider).increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class IsEvenCounter extends ConsumerWidget {
  const IsEvenCounter();
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    print('building');
    final isEven = watch(isEvenProvider);
    return Text(isEven ? 'Is Even' : 'Not Even');
  }
}
