import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_pattern_test_3/page/bloc/bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // BlocProvider로 MaterialApp을 감싼다.
      create: (context) => CounterBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('counter - Bloc'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //  `CounterBloc`을 필요로 하는 하위 위젯을 반환하는 빌더 패턴으로 감싼다.
          BlocBuilder<CounterBloc, CounterState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        // 이벤트 핸들러 등록
                        onPressed: () => context
                            .read<CounterBloc>()
                            .add(const CounterDecrementPressed()),
                        child: const Text(
                          '-',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      // 상태값 출력
                      state.count.toString(),
                      style: const TextStyle(fontSize: 36),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => context
                            .read<CounterBloc>()
                            .add(const CounterIncrementPressed()),
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}