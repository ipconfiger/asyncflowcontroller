typedef Future<K> AsynchronousTask<T, K>(T stub);
typedef Future<K> AsynchronousError<T, K>(T stub, Exception err);

class AsynchronousFlow<T, K> {
  AsynchronousFlow(this.transParam, this.taskList,
      {required AsynchronousError<T, K> onError}) {
    errHandler = onError;
  }
  late AsynchronousError<T, K> errHandler;
  List<AsynchronousTask<T, K>> taskList;
  T transParam;
  int processCount = 0;
  bool get finished => this.processCount == this.taskList.length;

  Future<K> execute() async {
    try {
      K result = await taskList[processCount](transParam);
      processCount += 1;
      return result;
    } on Exception catch (e) {
      processCount = this.taskList.length;
      return await errHandler(transParam, e);
    }
  }
}
