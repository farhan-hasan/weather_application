import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:networking_practice/config/notification/push_notification/push_notification_handler.dart';
import 'package:networking_practice/feature/audio_player/widgets/audio_player_widget.dart';
import 'package:networking_practice/feature/authentication/controllers/auth_controller.dart';
import 'package:networking_practice/feature/authentication/controllers/auth_generic.dart';
import 'package:networking_practice/feature/country/controllers/country_controller.dart';
import 'package:networking_practice/feature/country/controllers/country_generic.dart';
import 'package:networking_practice/feature/video_player/widgets/video_player_widget.dart';
import 'package:networking_practice/feature/weather/controllers/weather_controller.dart';
import 'package:networking_practice/feature/weather/controllers/weather_generic.dart';

import '../../../config/app_themes.dart';
import '../widgets/custom_search_deligate.dart';
import '../widgets/weather_detail_container.dart';

class WeatherScreen extends ConsumerStatefulWidget {
  const WeatherScreen({super.key});

  @override
  ConsumerState<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends ConsumerState<WeatherScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final List<String> _tabs = ['Today', 'Tomorrow', '10-Days'];
  final TextEditingController searchTEC = TextEditingController();
  List<String> cityList = [];
  String selectedTab = "Today";
  late Map<String, dynamic> extraString;
  Map<String, dynamic> map = <String, dynamic>{};
  String url =
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((t) {
      PushNotificationHandler.setupInteractedMessage();
      ref
          .read(weatherProvider.notifier)
          .fetchCurrentWeather(currentLocation: "Sylhet");
      initCityData();
    });
    //init();
  }

  init() {
    extraString =
        (GoRouterState.of(context).extra ?? map) as Map<String, dynamic>;
    print("Extra String: ${extraString.toString()}");
    if (extraString.isNotEmpty) {
      url = extraString["url"];
      String tab = extraString["tab"];
      int index = 0;
      if (tab == "Today") {
        index = 0;
      } else if (tab == "Tomorrow") {
        print("CHECK!!!!!!!!");
        index = 1;
      } else if (tab == "10-Days") {
        index = 2;
      }
      selectedTab = _tabs[index];
      _tabController?.animateTo(index);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("App state : $state");
    super.didChangeAppLifecycleState(state);
    if (AppLifecycleState.resumed == state) {
      init();
    }
  }

  void initCityData() async {
    cityList =
        await ref.read(countryProvider.notifier).readCitiesFromLocalDatabase();
    if (cityList.isEmpty) {
      ref.read(countryProvider.notifier).fetchCities();
      cityList = await ref
          .read(countryProvider.notifier)
          .readCitiesFromLocalDatabase();
    }
  }

  int getTab() {
    String tab = "";
    if (tab == "Today") return 0;
    if (tab == "Tomorrow") return 1;
    if (tab == "10-Days") return 2;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final weatherController = ref.watch(weatherProvider);
    final countryController = ref.watch(countryProvider);
    final authController = ref.watch(authProvider);

    //print(countryController.cityList);
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        //backgroundColor: Colors.white,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return buildSliverAppbarSection(
                context, weatherController, countryController, authController);
          },
          body: TabBarView(
            controller: _tabController,
            children: [
              buildTodayTab("Today", weatherController),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VideoPlayerWidget(url: url),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AudioPlayerWidget(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildSliverAppbarSection(
      BuildContext context,
      WeatherGeneric weatherController,
      CountryGeneric countryController,
      AuthGeneric authController) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverAppBar(
          elevation: 0,
          backgroundColor: AppThemes.lightColorScheme.background,
          collapsedHeight: kToolbarHeight,
          // Remove shadow
          title: SafeArea(
            child: Text(
              '${weatherController.currentWeatherData?.location?.name ?? "-"}, ${weatherController.currentWeatherData?.location?.country ?? "-"}',
              style: TextStyle(
                  color: weatherController.showCollapsedView == true
                      ? Colors.black
                      : Colors.white),
            ),
          ),

          actions: [
            IconButton(
              onPressed: () async {
                print(countryController.cityList);
                String location = await showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(
                      searchTerms: cityList,
                    ));
                ref
                    .read(weatherProvider.notifier)
                    .fetchCurrentWeather(currentLocation: location);
              },
              icon: Icon(
                Icons.search,
                color: weatherController.showCollapsedView == true
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            IconButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content: const Text(
                          'Are you sure?',
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: const Text(
                              'No',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              //Navigator.of(context).pop();
                              GoRouter.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'Yes',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              await ref.read(authProvider.notifier).logout();
                              if (ref.read(authProvider).isSuccess) {
                                GoRouter.of(context).goNamed("login");
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Logout failed')),
                                );
                              }
                            },
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.logout,
                color: weatherController.showCollapsedView == true
                    ? Colors.black
                    : Colors.white,
              ),
            )
          ],
          centerTitle: false,
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height * .4,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              WidgetsBinding.instance.addPostFrameCallback((t) {
                if (constraints.biggest.height <
                    MediaQuery.of(context).size.height * .10) {
                  //print("collapsed");
                  ref.read(weatherProvider.notifier).toggleAppbar(true);
                } else {
                  //print("expanded");
                  ref.read(weatherProvider.notifier).toggleAppbar(false);
                }
              });

              return FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: buildExpandedAppbar(weatherController),
              );
            },
          ),
        ),
      ),
      if (weatherController.showCollapsedView)
        buildCollapsedAppbar(weatherController)
      else
        const SliverToBoxAdapter(
          child: SizedBox.shrink(),
        ),
      SliverPersistentHeader(
        pinned: true,
        delegate: _PinnedHeaderDelegate(
          child: Container(
            decoration:
                BoxDecoration(color: AppThemes.lightColorScheme.background),
            child: TabBar(
              controller: _tabController,
              onTap: (value) {
                selectedTab = _tabs[value];
                _tabController?.index = value;
              },
              dividerColor: Colors.transparent,
              indicatorColor: Colors.transparent,
              labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: _tabs
                  .map((String name) => Tab(
                        child: Container(
                          decoration: BoxDecoration(
                              color: selectedTab == name
                                  ? AppThemes.lightColorScheme.primary
                                  : AppThemes.lightColorScheme.secondary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          height: 50,
                          width: 100,
                          child: Center(
                            child: Text(
                              name,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    ];
  }

  Widget buildTabs(String name, WeatherGeneric weatherController) {
    if (name == "Today") {
      return buildTodayTab(name, weatherController);
    } else if (name == "Tomorrow") {
      return buildTomorrowTab(name, url);
    } else {
      return const SafeArea(
          child: Center(
              child: Text(
        "10-Days",
        style: TextStyle(color: Colors.black),
      )));
    }
  }

  Widget buildTodayTab(String name, WeatherGeneric weatherController) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: PageStorageKey<String>(name),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverFillRemaining(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Wrap(
                    runSpacing: 15,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      WeatherDetailContainer(
                        title: "Wind Speed",
                        subtitle:
                            "${weatherController.currentWeatherData?.current?.windKph ?? "-"}km/h",
                        trailing:
                            "${weatherController.currentWeatherData?.current?.windMph ?? "-"}m/h",
                        icon: Icons.air,
                      ),
                      WeatherDetailContainer(
                        title: "Humidity",
                        subtitle:
                            "${weatherController.currentWeatherData?.current?.humidity ?? "-"}g/kg",
                        trailing:
                            "${weatherController.currentWeatherData?.current?.humidity ?? "-"}g/kg",
                        icon: Icons.water_drop,
                      ),
                      WeatherDetailContainer(
                        title: "Pressure",
                        subtitle:
                            "${weatherController.currentWeatherData?.current?.pressureIn ?? "-"}psi",
                        trailing:
                            "${weatherController.currentWeatherData?.current?.pressureMb ?? "-"}mb",
                        icon: Icons.water,
                      ),
                      WeatherDetailContainer(
                        title: "UV Index",
                        subtitle:
                            "${weatherController.currentWeatherData?.current?.uv ?? "-"}",
                        trailing:
                            "${weatherController.currentWeatherData?.current?.uv ?? "-"}",
                        icon: Icons.sunny,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildTomorrowTab(String name, String url) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: PageStorageKey<String>(name),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverFillRemaining(
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: VideoPlayerWidget(url: url)),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCollapsedAppbar(WeatherGeneric weatherController) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _PinnedHeaderDelegate(
        child: Container(
          height: kToolbarHeight * 2,
          color: AppThemes.lightColorScheme.background,
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Stack(
                  children: [
                    Positioned(
                      top: 11,
                      child: Text(
                        "${weatherController.currentWeatherData?.current?.tempC.toString() ?? "0"}°",
                        style:
                            const TextStyle(fontSize: 50, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 220,
                      height: kToolbarHeight * 2,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        "Feels like ${weatherController.currentWeatherData?.current?.feelslikeC?.toString() ?? "0"}°°",
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.network(
                      'https:${weatherController.currentWeatherData!.current!.condition!.icon!}',
                      fit: BoxFit.contain,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildExpandedAppbar(WeatherGeneric weatherController) {
    return Container(
      padding: const EdgeInsets.only(top: kToolbarHeight * 1.5),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/feature/weather/images/appbar_image.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(33),
          bottomRight: Radius.circular(33),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          //color: Colors.red.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                //color: Colors.white.withOpacity(0.5),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        flex: 7,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            //color: Colors.amber.withOpacity(0.5),
                            child: Wrap(
                              children: [
                                Text(
                                  "${weatherController.currentWeatherData?.current?.tempC.toString() ?? "0"}°",
                                  style: const TextStyle(
                                      fontSize: 65,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.fade),
                                  strutStyle:
                                      const StrutStyle(forceStrutHeight: true),
                                ),
                                Text(
                                  "Feels like ${weatherController.currentWeatherData?.current?.feelslikeC?.toString() ?? "0"}°",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            //color: Colors.black.withOpacity(0.5),
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Image.network(
                                    'https:${weatherController.currentWeatherData?.current?.condition?.icon ?? ""}',
                                    scale: .1,
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    weatherController.currentWeatherData
                                            ?.current?.condition?.text ??
                                        "-",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${DateTime.now().day} ${DateTime.now().month}, ${DateTime.now().year}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    weatherController.currentWeatherData?.current?.isDay == 1
                        ? "Day ${weatherController.currentWeatherData?.current?.feelslikeC?.toString() ?? "0"}°"
                        : "Night ${weatherController.currentWeatherData?.current?.feelslikeC?.toString() ?? "0"}°",
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _PinnedHeaderDelegate({required this.child});

  @override
  double get minExtent => 70.0;

  @override
  double get maxExtent => 70.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  bool shouldRebuild(_PinnedHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
