import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pie/components/error.dart';
import 'package:pie/components/home_page.dart';
import 'package:pie/components/login_page.dart';
import 'package:pie/lib/config.dart';
import 'package:pie/lib/global.dart';

main() {
  runApp(UncontrolledProviderScope(
    container: providers,
    child: const MainAPP(),
  ));
}

class MainAPP extends StatelessWidget {
  const MainAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pie',
      theme: ThemeData(
        primarySwatch: primaryColor,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: primaryColor).copyWith(secondary: secondaryColor),
        iconTheme: const IconThemeData(color: secondaryColor),
      ),
      scaffoldMessengerKey: scaffoldKey,
      home: const MainRoute(),
    );
  }
}

class MainRoute extends ConsumerWidget {
  const MainRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(systemNavigationBarColor: Theme.of(context).primaryColor));
    final initState = ref.watch(initPro);
    return initState.when(
      loading: () => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icon/icon.png', width: 100),
              const SizedBox(height: 20),
              LinearProgressIndicator(backgroundColor: primaryColor[50]),
            ],
          ),
        ),
      ),
      error: (e, _) => CenterError(e),
      data: (_) => providers.read(accountsPro).isEmpty ? const LoginPage() : const HomePage(),
    );
  }
}
