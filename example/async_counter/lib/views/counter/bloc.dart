import 'package:asyncflowcontroller/asyncflowcontroller.dart';
import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class TransParam {
  int count = 0;
}

class counterBloc extends Bloc<counterEvent, counterState> {
  counterBloc() : super(counterState(0).init());

  @override
  Stream<counterState> mapEventToState(counterEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
    if (event is IncreaseEvent) {
      final flow =
          new AsynchronousFlow<TransParam, counterState>(TransParam(), [
        (TransParam param) async {
          await Future.delayed(Duration(seconds: 1));
          param.count++;
          return counterState(param.count);
        },
        (TransParam param) async {
          await Future.delayed(Duration(seconds: 1));
          param.count++;
          return counterState(param.count);
        },
        (TransParam param) async {
          await Future.delayed(Duration(seconds: 1));
          param.count++;
          return counterState(param.count);
        }
      ], onError: (TransParam param, Exception exception) async {
        return counterState(-1);
      });
      while (!flow.finished) {
        yield await flow.execute();
      }
    }
  }

  Future<counterState> init() async {
    return state.clone();
  }
}
