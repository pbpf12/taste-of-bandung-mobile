part of '_pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = get.get<ProfileCubit>();
    retrieveData();
  }

  @override
  void dispose() {
    _profileCubit.close();
    super.dispose();
  }

  Future<void> retrieveData() async => _profileCubit.retrieveData();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            bloc: _profileCubit,
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.isError) {
                return Center(child: Text("Error: ${state.isError}"));
              } else if (state.isLoaded) {
                final user = state.user!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar( 
                          child: Text(
                            user.username,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${user?.firstName ?? 'Not provided'} ${user?.lastName ?? 'Not provided'}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              user!.email,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfilePage(
                                  firstName: user.firstName,
                                  lastName: user.lastName,
                                  email: user.email,
                                ),
                              ),
                            );
                          },
                          child: const Text("Edit Profile"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      "History",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "You have ${state.history.length} orders",
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final response = await request.logout(
                              "http://${EndPoints().myBaseUrl}/auth/logout/",
                            );
                            String message = response["message"];
                            if (context.mounted) {
                              if (response['status']) {
                                await request.local.remove('user_credentials');
                                String uname = response["username"];
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                                SuccessMessenger(
                                        "$message Sampai jumpa, $uname.")
                                    .show(context);
                              } else {
                                ErrorMessenger(message).show(context);
                              }
                            }
                          },
                          child: const Text('Logout'),
                        ),
                        CupertinoSwitch(
                          value: themeProvider.isDarkMode,
                          onChanged: (value) {
                            themeProvider.toggleTheme();
                          },
                        ),
                      ],
                    ),
                  ],
                );
              } else if (state.isError) {
                return Center(child: Text("Error: ${state.isError}"));
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
