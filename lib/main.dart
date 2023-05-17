import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as fr;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveller/constants/constant.dart';
import 'package:traveller/screens/weather/utils/converters.dart';
import 'package:traveller/traveller-main-page.dart';

import 'utils/dio.dart';

final httpClientProvider = fr.Provider<Dio>((_) => throw UnimplementedError());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    fr.ProviderScope(
      overrides: [
        httpClientProvider.overrideWith((ref) => HttpClient(ref).httpClient),
      ],
      child: AppStateContainer(
        child: BlocProvider(
          create: (_) => BlocDelegate(null),
          child: MainPage(),
        ),
      ),
    ),
  );
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class BlocDelegate extends Bloc<void, void> {
  BlocDelegate(void initialState) : super(initialState);

  @override
  onTransition(Transition<void, void> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<void> mapEventToState(void event) {
    throw UnimplementedError();
  }
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Traveller(),
      scaffoldMessengerKey: globalScaffoldKey,
    );
  }
}

class AppStateContainer extends ConsumerStatefulWidget {
  final Widget child;

  AppStateContainer({required this.child});

  @override
  _AppStateContainerState createState() => _AppStateContainerState();

  static _AppStateContainerState of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>())!
        .data;
  }
}

class _AppStateContainerState extends ConsumerState<AppStateContainer> {
  TemperatureUnit temperatureUnit = TemperatureUnit.celsius;

  @override
  initState() {
    super.initState();

    SharedPreferences.getInstance().then((sharedPref) {
      setState(() {
        temperatureUnit = TemperatureUnit.values[TemperatureUnit.celsius.index];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }

  updateTemperatureUnit(TemperatureUnit unit) {
    setState(() {
      this.temperatureUnit = unit;
    });
    SharedPreferences.getInstance().then((sharedPref) {
      sharedPref.setInt(CONSTANTS.SHARED_PREF_KEY_TEMPERATURE_UNIT, unit.index);
    });
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState data;

  const _InheritedStateContainer({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) => true;
}

class CONSTANTS {
  static const SHARED_PREF_KEY_TEMPERATURE_UNIT = "temp_unit";
}
