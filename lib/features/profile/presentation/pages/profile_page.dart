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
    _profileCubit.retrieveData();
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
                    ProfileBar(user: user),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row (
                          children: [ 
                            Text(
                              "History",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.0),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _profileCubit.clearHistory();
                          },
                          child: const Icon(Icons.delete)
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                      child: ListView.builder(
                      itemCount: state.history.length,
                      itemBuilder: (context, index) {
                        final order = state.history[index];
                        return Card(
                          child: Row (
                            children: [
                              const SizedBox(width: 16.0),
                              const CircleAvatar(
                                radius: 20.0,
                                backgroundColor: Colors.grey,
                              ),
                              const SizedBox(width: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.dish.name,
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4.0),
                                  Text(
                                    order.createdAt.toString().substring(0, 10),
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final response = await _profileCubit.logout();
                            String message = response;
                            if (context.mounted) {
                              if (message == "Logged Out") {
                                await request.local.remove('user_credentials');
                                String uname = user.username;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPage()),
                                );
                                SuccessMessenger("$message Sampai jumpa, $uname.").show(context);
                              } else {
                                ErrorMessenger(message).show(context);
                              }
                            }
                          },
                          child: const Text('Logout'),
                        ),
                        const ThemeToggler(),
                        ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Delete Account"),
                                    content: const Text("Are you sure you want to delete your account? This action cannot be undone."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          _profileCubit.deleteAccount();
                                          Navigator.of(context).pop(); // Close the dialog
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => const LoginPage()),
                                          );
                                        },
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text('Delete Account'),
                        )
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
