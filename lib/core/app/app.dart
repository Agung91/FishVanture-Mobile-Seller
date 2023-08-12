import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:seller/core/auth/bloc/local_auth.dart';
import 'package:seller/core/route/bloc_route.dart';
import 'package:seller/core/route/route_page.dart';
import 'package:seller/modules/fish/bloc/bloc_fish.dart';
import 'package:seller/modules/fish/repo/repo_fish.dart';
import 'package:seller/modules/login/screen/page_login.dart';
import 'package:seller/modules/pond/bloc/bloc_pond.dart';
import 'package:seller/modules/pond/repo/repo_pond.dart';
import 'package:seller/modules/edit_profile/bloc/bloc_edit_profile.dart';
import 'package:seller/modules/edit_profile/repo/repo_edit_profile.dart';
import 'package:seller/modules/pool/bloc/bloc_pool.dart';
import 'package:seller/modules/pool/repo/repo_pool.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  Future<void> checkForUpdate() async {
    if (kDebugMode) {
      return;
    }
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability != 0) {
        InAppUpdate.performImmediateUpdate();
      }
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => LocalAuth(),
          lazy: false,
        ),
        Provider(
          create: (_) => EditProfileBloc(ProfileHttpRepo()),
        ),
        Provider(
          create: (_) => PondBloc(PondHttpRepo()),
        ),
        Provider(
          create: (_) => PoolBloc(PoolHttpRepo()),
        ),
        Provider(
          create: (_) => FishBloc(FishHttpRepo()),
        ),
      ],
      child: MaterialApp(
        title: 'Aplikasi Seller',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorObservers: [routeObserver],
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        home: AppPage(navigatorKey: _navigatorKey),
      ),
    );
  }
}

class AppPage extends StatelessWidget {
  const AppPage({
    Key? key,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _navigatorKey = navigatorKey,
        super(key: key);

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return RouteBloc().pop();
      },
      child: StreamBuilder<List<RoutePage>>(
          stream: RouteBloc().pages.stream,
          initialData: RouteBloc().pages.value,
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (data == null) {
              return Navigator(
                key: _navigatorKey,
                observers: [HeroController()],
                pages: const [
                  MaterialPage(child: LoginPage()),
                ],
                onPopPage: (route, result) {
                  return route.didPop(result);
                },
              );
            }
            return Navigator(
              key: _navigatorKey,
              observers: [HeroController()],
              pages: data.map((e) => e.page).toList(),
              onPopPage: (route, result) {
                return route.didPop(result);
              },
            );
          }),
    );
  }
}
