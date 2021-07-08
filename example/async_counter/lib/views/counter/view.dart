import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'event.dart';
import 'state.dart';

class counterPage extends StatelessWidget {
  final bloc = counterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            BlocProvider(
                create: (_) => bloc,
                child: BlocBuilder<counterBloc, counterState>(
                    builder: (context, state) {
                  return Text('${state.counter}',
                      style: Theme.of(context).textTheme.headline4);
                })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this.bloc.add(new IncreaseEvent());
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
