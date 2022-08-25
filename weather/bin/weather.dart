class Weather {
  const Weather(
      {required this.isDay,
      required this.temp_c,
      required this.temp_f,
      required this.humidity});

  final String isDay;
  final double temp_f;
  final double temp_c;
  final int humidity;
  factory Weather.fromJson(Map<String, Object?> json) => Weather(
      isDay: json['is_day'] == 1 ? 'Day' :'Night',
      temp_c: json['temp_c'] as double,
      temp_f: json['temp_f'] as double,
      humidity: json['humidity'] as int);

  @override
  String toString() => '''
    'Period': ${isDay}
    'Current Temp in C': ${temp_c.toStringAsFixed(0)} C
    'Current Temp in F': ${temp_f.toStringAsFixed(0)} F
    'Humidity': ${humidity}
''';
}
