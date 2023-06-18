extension DoubleExt on double {
  static double identity(double value) => value;

  double ratio(double min, double max) => (this - min) / (max - min);

  double map({
    double inMin = 0,
    double inMax = 1,
    num outMin = 0,
    num outMax = 1,
    double Function(double) f = identity,
  }) {
    // ignore: unnecessary_this
    final progress = this.clamp(inMin, inMax).ratio(inMin, inMax);
    return (outMax - outMin) * f(progress) + outMin;
  }

  String get humanReadable =>
      toStringAsFixed(3).replaceAll(RegExp(r"\.?0*$"), "");
}

extension IntExt on int {
  static int identity(int value) => value;

  double ratio(int min, int max) => (this - min) / (max - min);

  double map({
    int inMin = 0,
    int inMax = 1,
    num outMin = 0,
    num outMax = 1,
    double Function(double) f = DoubleExt.identity,
  }) {
    // ignore: unnecessary_this
    final progress = this.clamp(inMin, inMax).ratio(inMin, inMax);
    return (outMax - outMin) * f(progress) + outMin;
  }
}
