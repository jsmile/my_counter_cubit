import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_counter_cubit/cubits/cubit/counter_cubit.dart';
import 'package:my_counter_cubit/other_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'My Counter Cubit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.counter == 3) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Text(
                  '*** State Counter is ${state.counter}.',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            );
          } else if (state.counter <= -1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtherPage(),
              ),
            );
          }
        },
        child: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, state) {
            return Center(
              child: Text(
                '${state.counter}',
                style: TextStyle(fontSize: 52.0),
              ),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
            },
            heroTag: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10.0),
          FloatingActionButton(
            onPressed: () {
              BlocProvider.of<CounterCubit>(
                context,
              ).decreament();
            },
            heroTag: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
