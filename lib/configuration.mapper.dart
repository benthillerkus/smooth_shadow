// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

part of 'configuration.dart';

class ConfigurationMapper extends ClassMapperBase<Configuration> {
  ConfigurationMapper._();

  static ConfigurationMapper? _instance;
  static ConfigurationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ConfigurationMapper._());
    }
    return _instance!;
  }

  static T _guard<T>(T Function(MapperContainer) fn) {
    ensureInitialized();
    return fn(MapperContainer.globals);
  }

  @override
  final String id = 'Configuration';

  static int _$layerCount(Configuration v) => v.layerCount;
  static const Field<Configuration, int> _f$layerCount =
      Field('layerCount', _$layerCount, opt: true, def: 6);
  static double _$maxOpacity(Configuration v) => v.maxOpacity;
  static const Field<Configuration, double> _f$maxOpacity =
      Field('maxOpacity', _$maxOpacity, opt: true, def: 0.07);
  static Cubic _$transparencyDistribution(Configuration v) =>
      v.transparencyDistribution;
  static const Field<Configuration, Cubic> _f$transparencyDistribution = Field(
      'transparencyDistribution', _$transparencyDistribution,
      opt: true, def: const Cubic(0.1, 0.5, 0.9, 0.5));
  static bool _$reverseOpacity(Configuration v) => v.reverseOpacity;
  static const Field<Configuration, bool> _f$reverseOpacity =
      Field('reverseOpacity', _$reverseOpacity, opt: true, def: false);
  static Offset _$maxDistance(Configuration v) => v.maxDistance;
  static const Field<Configuration, Offset> _f$maxDistance = Field(
      'maxDistance', _$maxDistance,
      opt: true, def: const Offset(100, 100));
  static Cubic _$distanceDistribution(Configuration v) =>
      v.distanceDistribution;
  static const Field<Configuration, Cubic> _f$distanceDistribution = Field(
      'distanceDistribution', _$distanceDistribution,
      opt: true, def: const Cubic(0.7, 0.1, 0.9, 0.3));
  static int _$maxBlur(Configuration v) => v.maxBlur;
  static const Field<Configuration, int> _f$maxBlur =
      Field('maxBlur', _$maxBlur, opt: true, def: 80);
  static Cubic _$blurDistribution(Configuration v) => v.blurDistribution;
  static const Field<Configuration, Cubic> _f$blurDistribution = Field(
      'blurDistribution', _$blurDistribution,
      opt: true, def: const Cubic(0.7, 0.1, 0.9, 0.3));
  static int _$spread(Configuration v) => v.spread;
  static const Field<Configuration, int> _f$spread =
      Field('spread', _$spread, opt: true, def: 0);

  @override
  final Map<Symbol, Field<Configuration, dynamic>> fields = const {
    #layerCount: _f$layerCount,
    #maxOpacity: _f$maxOpacity,
    #transparencyDistribution: _f$transparencyDistribution,
    #reverseOpacity: _f$reverseOpacity,
    #maxDistance: _f$maxDistance,
    #distanceDistribution: _f$distanceDistribution,
    #maxBlur: _f$maxBlur,
    #blurDistribution: _f$blurDistribution,
    #spread: _f$spread,
  };

  static Configuration _instantiate(DecodingData data) {
    return Configuration(
        layerCount: data.dec(_f$layerCount),
        maxOpacity: data.dec(_f$maxOpacity),
        transparencyDistribution: data.dec(_f$transparencyDistribution),
        reverseOpacity: data.dec(_f$reverseOpacity),
        maxDistance: data.dec(_f$maxDistance),
        distanceDistribution: data.dec(_f$distanceDistribution),
        maxBlur: data.dec(_f$maxBlur),
        blurDistribution: data.dec(_f$blurDistribution),
        spread: data.dec(_f$spread));
  }

  @override
  final Function instantiate = _instantiate;

  static Configuration fromMap(Map<String, dynamic> map) {
    return _guard((c) => c.fromMap<Configuration>(map));
  }

  static Configuration fromJson(String json) {
    return _guard((c) => c.fromJson<Configuration>(json));
  }
}

mixin ConfigurationMappable {
  String toJson() {
    return ConfigurationMapper._guard((c) => c.toJson(this as Configuration));
  }

  Map<String, dynamic> toMap() {
    return ConfigurationMapper._guard((c) => c.toMap(this as Configuration));
  }

  ConfigurationCopyWith<Configuration, Configuration, Configuration>
      get copyWith => _ConfigurationCopyWithImpl(
          this as Configuration, $identity, $identity);
  @override
  String toString() {
    return ConfigurationMapper._guard((c) => c.asString(this));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            ConfigurationMapper._guard((c) => c.isEqual(this, other)));
  }

  @override
  int get hashCode {
    return ConfigurationMapper._guard((c) => c.hash(this));
  }
}

extension ConfigurationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Configuration, $Out> {
  ConfigurationCopyWith<$R, Configuration, $Out> get $asConfiguration =>
      $base.as((v, t, t2) => _ConfigurationCopyWithImpl(v, t, t2));
}

abstract class ConfigurationCopyWith<$R, $In extends Configuration, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {int? layerCount,
      double? maxOpacity,
      Cubic? transparencyDistribution,
      bool? reverseOpacity,
      Offset? maxDistance,
      Cubic? distanceDistribution,
      int? maxBlur,
      Cubic? blurDistribution,
      int? spread});
  ConfigurationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ConfigurationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Configuration, $Out>
    implements ConfigurationCopyWith<$R, Configuration, $Out> {
  _ConfigurationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Configuration> $mapper =
      ConfigurationMapper.ensureInitialized();
  @override
  $R call(
          {int? layerCount,
          double? maxOpacity,
          Cubic? transparencyDistribution,
          bool? reverseOpacity,
          Offset? maxDistance,
          Cubic? distanceDistribution,
          int? maxBlur,
          Cubic? blurDistribution,
          int? spread}) =>
      $apply(FieldCopyWithData({
        if (layerCount != null) #layerCount: layerCount,
        if (maxOpacity != null) #maxOpacity: maxOpacity,
        if (transparencyDistribution != null)
          #transparencyDistribution: transparencyDistribution,
        if (reverseOpacity != null) #reverseOpacity: reverseOpacity,
        if (maxDistance != null) #maxDistance: maxDistance,
        if (distanceDistribution != null)
          #distanceDistribution: distanceDistribution,
        if (maxBlur != null) #maxBlur: maxBlur,
        if (blurDistribution != null) #blurDistribution: blurDistribution,
        if (spread != null) #spread: spread
      }));
  @override
  Configuration $make(CopyWithData data) => Configuration(
      layerCount: data.get(#layerCount, or: $value.layerCount),
      maxOpacity: data.get(#maxOpacity, or: $value.maxOpacity),
      transparencyDistribution: data.get(#transparencyDistribution,
          or: $value.transparencyDistribution),
      reverseOpacity: data.get(#reverseOpacity, or: $value.reverseOpacity),
      maxDistance: data.get(#maxDistance, or: $value.maxDistance),
      distanceDistribution:
          data.get(#distanceDistribution, or: $value.distanceDistribution),
      maxBlur: data.get(#maxBlur, or: $value.maxBlur),
      blurDistribution:
          data.get(#blurDistribution, or: $value.blurDistribution),
      spread: data.get(#spread, or: $value.spread));

  @override
  ConfigurationCopyWith<$R2, Configuration, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ConfigurationCopyWithImpl($value, $cast, t);
}
