import 'package:fooddeliveryapp/exports.dart';

import '../../components/oval_paint.dart';


class OnboardView extends StatelessWidget {
  const OnboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const OvalPaint(),
            const AmaobaPaint(),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImagePath.discuss,
                    height: 400,
                  ),
                  const SizedBox(height: AppTheme.cardPadding),
                  const SizedBox(height: AppTheme.cardPadding),
                  SizedBox(
                    width: AppTheme.size(context).width * 0.6,
                    child: Column(
                      children: [
                        const AuthHeader("Welcome\nto Food Delivery"),
                        const SizedBox(height: AppTheme.cardPadding),
                        FodaButton(
                            title: "Sign In",
                            onTap: () {
                              Navigator.of(context).pushNamed(authPath, arguments: AuthenticationViewState.signIn);
                            }),
                        const SizedBox(height: AppTheme.elementSpacing),
                        FodaButton(
                          title: "Sign Up",
                          gradiant: const [AppTheme.darkBlue],
                          onTap: () {
                            Navigator.of(context).pushNamed(authPath, arguments: AuthenticationViewState.signUp);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthHeader extends StatelessWidget {
  final String title;
  const AuthHeader(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppTheme.orange,
            height: 1,
          ),
    );
  }
}
