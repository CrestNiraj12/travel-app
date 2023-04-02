import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traveller/Recommendation/recomendation_model.dart';
import 'package:traveller/firebase_options.dart';
import 'package:traveller/traveller-main-page.dart';

import 'Recommendation/list.dart';
import 'Weather/utils/converters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    AppStateContainer(
      child: BlocProvider(
        create: (_) => BlocDelegate(null),
        child: MainPage(),
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Recomends()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Traveller(),
          routes: {
            RecomDetail.routeName: (context) => RecomDetail(),
          }),
    );
  }
}

class AppStateContainer extends StatefulWidget {
  final Widget child;

  AppStateContainer({@required this.child});

  @override
  _AppStateContainerState createState() => _AppStateContainerState();

  static _AppStateContainerState of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>())
        .data;
  }
}

class _AppStateContainerState extends State<AppStateContainer> {
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
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer oldWidget) => true;
}

class CONSTANTS {
  static const SHARED_PREF_KEY_TEMPERATURE_UNIT = "temp_unit";
}
