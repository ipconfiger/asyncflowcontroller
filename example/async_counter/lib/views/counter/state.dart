class counterState {
  counterState(this.counter);

  int counter;

  counterState init() {
    return counterState(0);
  }

  counterState clone() {
    return counterState(this.counter);
  }
}
