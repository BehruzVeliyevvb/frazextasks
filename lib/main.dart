import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frazex_task/provider/data_provider.dart';
import 'package:frazex_task/screens/posts_screen.dart';
import 'package:frazex_task/screens/search_screen.dart';
import 'package:provider/provider.dart';
import 'l10n/l10n.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DataProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => Consumer<DataProvider>(
        builder: (context, provider, _) => MaterialApp(
          title: 'Frazex',
          theme: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          debugShowCheckedModeBanner: false,
          locale: Locale(provider.getLangCode),
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const Home(),
        ),
      );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animation!.addListener(() {
      int value = _tabController.animation!.value.round();
      if (value != _selectedIndex) setState(() => _selectedIndex = value);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Consumer<DataProvider>(
        builder: (context, provider, _) => Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              centerTitle: true,
              title: Text(
                _selectedIndex == 0
                    ? AppLocalizations.of(context)!.postsScreen
                    : AppLocalizations.of(context)!.searchScreen,
              ),
            ),
          ),
          endDrawer: Drawer(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => provider.setLangCode = L10n.all[0].languageCode,
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: provider.getLangCode == L10n.all[0].languageCode
                            ? Colors.blue
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${L10n.getName(L10n.all[0].languageCode)} ${L10n.getFlag(L10n.all[0].languageCode)}',
                            style: TextStyle(
                              color: provider.getLangCode == L10n.all[0].languageCode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => provider.setLangCode = L10n.all[1].languageCode,
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        color: provider.getLangCode == L10n.all[1].languageCode
                            ? Colors.blue
                            : Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${L10n.getName(L10n.all[1].languageCode)} ${L10n.getFlag(L10n.all[1].languageCode)}',
                            style: TextStyle(
                              color: provider.getLangCode == L10n.all[1].languageCode
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              PostsScreen(),
              SearchScreen(),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            height: 56,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            backgroundColor: Colors.white,
            onDestinationSelected: (selectedIndex) {
              setState(() => _selectedIndex = selectedIndex);
              _tabController.animateTo(selectedIndex);
            },
            selectedIndex: _selectedIndex,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home),
                label: AppLocalizations.of(context)!.postsScreen,
              ),
              NavigationDestination(
                icon: const Icon(Icons.search),
                label: AppLocalizations.of(context)!.searchScreen,
              ),
            ],
          ),
          resizeToAvoidBottomInset: false,
        ),
      );
}
