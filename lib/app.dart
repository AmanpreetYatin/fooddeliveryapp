import 'package:fooddeliveryapp/exports.dart';
import 'package:fooddeliveryapp/wrapper.dart';

class FodaApp extends StatelessWidget {
  const FodaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationState()),
        ChangeNotifierProvider(create: (_) => OverviewState()),
        ChangeNotifierProvider(
          create: (_) => CheckoutState(),
          lazy: true,
        )
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: const Wrapper(),
      ),
    );
  }
}
