import 'weather_api_client.dart';

Future<void> main(List<String> args) async {
  if (args.length != 1) {
    print('Syntax: bin/main.dart <city>');
    return;
  }
  final city = args.first;
  final api = WeatherApiClient();
  final weather = await api.getWeather(city);
  print(weather);
}
