import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'configuration.mapper.dart';

@MappableClass()
class Configuration with ConfigurationMappable {
  final int layerCount;
  final double maxOpacity;
  final Cubic transparencyDistribution;
  final bool reverseOpacity;
  final Offset maxDistance;
  final Cubic distanceDistribution;
  final int maxBlur;
  final Cubic blurDistribution;
  final int spread;

  const Configuration({
    this.layerCount = 6,
    this.maxOpacity = 0.07,
    this.transparencyDistribution = const Cubic(0.1, 0.5, 0.9, 0.5),
    this.reverseOpacity = false,
    this.maxDistance = const Offset(100, 100),
    this.distanceDistribution = const Cubic(0.7, 0.1, 0.9, 0.3),
    this.maxBlur = 80,
    this.blurDistribution = const Cubic(0.7, 0.1, 0.9, 0.3),
    this.spread = 0,
  });
}

final configurationProvider = StateProvider((_) => const Configuration());

final shadowsProvider = Provider((ref) {
  final configuration = ref.watch(configurationProvider);
  return List.generate(configuration.layerCount, growable: false, (index) {
    final progress = configuration.layerCount == 0
        ? 1.0
        : (index + 1) / configuration.layerCount;
    return BoxShadow(
      offset: configuration.maxDistance *
          configuration.distanceDistribution.transform(progress),
      color: Color.fromRGBO(
        0,
        0,
        0,
        (configuration.transparencyDistribution.transform(
                    configuration.reverseOpacity
                        ? (1 - index / configuration.layerCount)
                        : progress) *
                configuration.maxOpacity)
            .clamp(0, 1),
      ),
      blurRadius: configuration.blurDistribution.transform(progress) *
          configuration.maxBlur,
      spreadRadius: configuration.spread.toDouble(),
    );
  });
});
