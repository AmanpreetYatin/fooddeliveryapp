import 'package:fooddeliveryapp/exports.dart';




class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userRepo = locate<UserRepository>();

    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userRepo.currentUserNotifier.value!.email,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Center(
              child: FodaButton(
                onTap: () async {
                  await userRepo.logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    authPath,
                    (route) => false,
                    arguments: AuthenticationViewState.signIn,
                  );
                },
                title: 'Logout',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
