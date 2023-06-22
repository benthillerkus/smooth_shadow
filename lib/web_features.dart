import 'package:flutter/animation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:smooth_shadow/configuration.dart';
import 'package:smooth_shadow/extensions.dart';

extension _CubicQueryFormat on Cubic {
  String get queryFormat =>
      "${a.humanReadable},${b.humanReadable},${c.humanReadable},${d.humanReadable}";

  static Cubic? fromQueryFormat(String? humanReadable) {
    if (humanReadable == null) return null;
    final values = humanReadable.split(",").map(double.tryParse).toList();
    if (values.length != 4 || values.contains(null)) return null;
    return Cubic(
      values[0]!,
      values[1]!,
      values[2]!,
      values[3]!,
    );
  }
}

extension _OffsetQueryFormat on Offset {
  String get queryFormat => "${dx.humanReadable},${dy.humanReadable}";

  static Offset? fromQueryFormat(String? humanReadable) {
    if (humanReadable == null) return null;
    final values = humanReadable.split(",").map(double.tryParse).toList();
    if (values.length != 2 || values.contains(null)) return null;
    return Offset(
      values[0]!,
      values[1]!,
    );
  }
}

void usePathUrlStrategy() {
  setUrlStrategy(PathUrlStrategy());
}

const _location = BrowserPlatformLocation();
Configuration? _futureConfig;

void updatePath(Configuration configuration) {
  _futureConfig = configuration;
  Future.delayed(const Duration(milliseconds: 200), () {
    if (_futureConfig != configuration) return;
    _location.replaceState(
        null,
        "Smooth Shadow",
        Uri.base.replace(queryParameters: {
          "lC": "${configuration.layerCount}",
          "mO": configuration.maxOpacity.humanReadable,
          "tD": configuration.transparencyDistribution.queryFormat,
          if (configuration.reverseOpacity) "rO": "",
          "mD": configuration.maxDistance.queryFormat,
          "dD": configuration.distanceDistribution.queryFormat,
          "mB": "${configuration.maxBlur}",
          "bD": configuration.blurDistribution.queryFormat,
          "sP": "${configuration.spread}",
        }).toString());
  });
}

Configuration getConfigurationFromPath() {
  final parameters = Uri.base.queryParameters;
  return const Configuration().copyWith(
    layerCount: int.tryParse(parameters["lC"] ?? ""),
    maxOpacity: double.tryParse(parameters["mO"] ?? ""),
    transparencyDistribution:
        _CubicQueryFormat.fromQueryFormat(parameters["tD"]),
    reverseOpacity: parameters.containsKey("rO"),
    maxDistance: _OffsetQueryFormat.fromQueryFormat(parameters["mD"]),
    distanceDistribution: _CubicQueryFormat.fromQueryFormat(parameters["dD"]),
    maxBlur: int.tryParse(parameters["mB"] ?? ""),
    blurDistribution: _CubicQueryFormat.fromQueryFormat(parameters["bD"]),
    spread: int.tryParse(parameters["sP"] ?? ""),
  );
}
