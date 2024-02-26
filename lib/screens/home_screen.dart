import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/components/dynamic_column.dart';
import 'package:weather_app/constants/api_key.dart';
import 'package:weather_app/services/location_service.dart';
import 'dart:io' show Platform;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationService locationService = LocationService();
  final WeatherFactory _wf = WeatherFactory(apiKey);

  Weather? _weather;

  @override
  void initState() {
    super.initState();

    locationService.getCurrentLocation().then(
      (position) {
        _wf
            .currentWeatherByLocation(position.latitude, position.longitude)
            .then((weather) => setState(() {
                  _weather = weather;
                }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: DynamicColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(child: _locationHeader()),
          Expanded(flex: isLandscape ? 1 : 2, child: _weatherIcon()),
          Expanded(child: _currentTemp()),
        ],
      ),
    );
  }

  Widget _locationHeader() {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Column(
      mainAxisAlignment:
          isLandscape ? MainAxisAlignment.center : MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Platform.isIOS
            ? const Icon(
                CupertinoIcons.map_pin,
                size: 32,
              )
            : const Icon(Icons.location_pin),
        const SizedBox(
          height: 10,
        ),
        Text(
          _weather?.areaName ?? "",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 0.30,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
      mainAxisAlignment:
          isLandscape ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "${_weather?.temperature?.celsius?.toStringAsFixed(0)}°C",
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Widget _dateTimeInfo() {
  //   DateTime _dateTime = _weather!.date!;
  //   return Column(
  //     children: [
  //       Text(
  //         DateFormat("h:mm a").format(_dateTime),
  //         style: const TextStyle(
  //           fontSize: 36,
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 10,
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisSize: MainAxisSize.max,
  //         children: [
  //           Text(
  //             DateFormat("EEEE").format(_dateTime),
  //             style: const TextStyle(
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           Text(" ${DateFormat("dd/mm/y").format(_dateTime)}")
  //         ],
  //       )
  //     ],
  //   );
  // }

  // Widget _extraInfo() {
  //   return Container(
  //     height: MediaQuery.sizeOf(context).height * 0.15,
  //     width: MediaQuery.sizeOf(context).width * 0.85,
  //     decoration: BoxDecoration(
  //       color: Colors.deepPurpleAccent,
  //       borderRadius: BorderRadius.circular(20),
  //     ),
  //     padding: const EdgeInsets.all(8.0),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.max,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisSize: MainAxisSize.max,
  //           children: [
  //             Text(
  //               "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}°C",
  //               style: const TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //             Text(
  //               "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}°C",
  //               style: const TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisSize: MainAxisSize.max,
  //           children: [
  //             Text(
  //               "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
  //               style: const TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //             Text(
  //               "Huminity: ${_weather?.humidity?.toStringAsFixed(0)}%",
  //               style: const TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
