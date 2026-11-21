import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/5.png');
      case == 800:
        return Image.asset('assets/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/7.png');
      default:
        return Image.asset('assets/7.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsGeometry.fromLTRB(
            40,
            1.2 * kToolbarHeight,
            40,
            20,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional(3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF673AB7),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, -1.2),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFFAB40),
                    ),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  child: Container(
                    decoration: const BoxDecoration(color: Colors.transparent),
                  ),
                ),

                BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                  builder: (context, state) {
                    if (state is WeatherBlocSuccess) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📍 ${state.weather.areaName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: .w300,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Good Morning',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: .bold,
                              ),
                            ),
                            
                            getWeatherIcon(state.weather.weatherConditionCode!),

                            Center(
                              child: Text(
                                '${state.weather.temperature!.celsius!.round()}°C',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 55,
                                  fontWeight: .w600,
                                ),
                              ),
                            ),

                            Center(
                              child: Text(
                                state.weather.weatherMain!.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: .w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Center(
                              child: Text(
                                DateFormat('EEEE  dd ')
                                    .add_jm()
                                    .format(state.weather.date!),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: .w300,
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildWeatherInfoRow(
                                  iconPath: 'assets/11.png',
                                  label: 'Sunrise',
                                  time: DateFormat().add_jm().format(
                                    state.weather.sunrise!,
                                  ),
                                ),
                                _buildWeatherInfoRow(
                                  iconPath: 'assets/12.png',
                                  label: 'Sunset',
                                  time: DateFormat().add_jm().format(
                                    state.weather.sunset!,
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Divider(color: Colors.grey),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildWeatherInfoRow(
                                  iconPath: 'assets/13.png',
                                  label: 'Temp Max',
                                  time:
                                      '${state.weather.tempMax!.celsius!.round()} °C',
                                ),
                                _buildWeatherInfoRow(
                                  iconPath: 'assets/14.png',
                                  label: 'Temp Min',
                                  time:
                                      '${state.weather.tempMin!.celsius!.round()} °C',
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherInfoRow({
    required String iconPath,
    required String label,
    required String time,
  }) {
    return Row(
      children: [
        Image.asset(iconPath, scale: 8),
        Column(
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontWeight: .w300),
            ),
            const SizedBox(height: 3),
            Text(
              time,
              style: const TextStyle(color: Colors.white, fontWeight: .w700),
            ),
          ],
        ),
      ],
    );
  }
}
