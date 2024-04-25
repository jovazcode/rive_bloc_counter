import 'package:flutter/material.dart';

import 'package:rive_bloc/rive_bloc.dart';

// The Riverpod Counter example migrated to `RiveBloc`
void main() {
  runApp(
    /// Adding [RiveBlocScope] enables `RiveBloc` for the entire project
    RiveBlocScope(
      providers: [counterProvider],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Home());
  }
}

/// Defines a new shared state for the application,
/// accessible using [counterProvider].
final counterProvider = RiveBlocProvider.state(CounterCubit.new);

/// This class is both responsible for initializing the state
/// and exposing ways to modify it (cf [increment]).
class CounterCubit extends ValueCubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return RiveBlocBuilder(builder: (context, ref, _) {
      return Scaffold(
        appBar: AppBar(title: const Text('Counter example')),
        body: Center(
          child: Text('${ref.watch(counterProvider).state}'),
        ),
        floatingActionButton: FloatingActionButton(
          // The read method is a utility to read a provider without listening to it
          onPressed: () => ref.read(counterProvider).increment(),
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
