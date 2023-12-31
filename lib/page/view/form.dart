import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CounterBloc>().add(const InitializeView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('counter - Bloc'),
      ),
      body: BlocBuilder<CounterBloc, CounterState>(builder: (context, state) {
        print('jusong now state is ${state}');
        return Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          // 이벤트 핸들러 등록
                          onPressed: () {
                            context.read<CounterBloc>().add(
                                const CounterPressed(
                                    CounterStateType.DECREMENT));
                            print('jusong onPressed 감소 in form');
                          }, // (1) CounterBloc에 이벤트 추가
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
                        state.vm.counter.toString(),
                        style: const TextStyle(fontSize: 36),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<CounterBloc>().add(
                                const CounterPressed(
                                    CounterStateType.INCREMENT));
                            print('jusong onPressed 증가 in form');
                          },
                          child: const Text(
                            '+',
                            style: TextStyle(fontSize: 32),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            if (state is DataLoadInProgress)
              Container(
                color: Colors.black38,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            else
              const SizedBox(),
          ],
          // data load in prograss 면 띄우기
        );
      }),
    );
  }
}
