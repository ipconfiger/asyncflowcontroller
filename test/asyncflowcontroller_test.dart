import 'package:flutter_test/flutter_test.dart';

import 'package:asyncflowcontroller/asyncflowcontroller.dart';

class TransParam{
  int count = 0;
}

class State{
  State(this.counter, this.error);
  int counter = 0;
  String error;
}

void main() {
  test('adds one to input values', () async {
    AsynchronousFlow flow = new AsynchronousFlow<TransParam, State>(
      TransParam(),
      [
        (TransParam param) async {
          await Future.delayed(Duration(seconds:1));
          param.count += 1;
          return State(param.count, "");
        },
        (TransParam param) async {
          await Future.delayed(Duration(seconds:1));
          param.count += 1;
          return State(param.count, "");
        },
        (TransParam param) async {
          await Future.delayed(Duration(seconds:1));
          param.count += 1;
          return State(param.count, "");
        }
      ],
      onError: (TransParam param, Exception err) async{
        return State(-1, err.toString());
      },
    );
    int index = 1;
    while(!flow.finished){
      final state = await flow.execute();
      print('state is :${state.counter}');
      expect(state.counter, index);
      index+=1;
    }
    
  });
}
