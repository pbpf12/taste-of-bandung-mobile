part of '_pages.dart';

class EditProfilePage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;

  const EditProfilePage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late EditProfileCubit _editProfileCubit;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _emailController = TextEditingController(text: widget.email);
    _editProfileCubit = get.get<EditProfileCubit>();
    _editProfileCubit.retrieveData();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _editProfileCubit.close();
    super.dispose();
  }

  void updateData() {
    // Implement your update logic here
    String updatedFirstName = _firstNameController.text;
    String updatedLastName = _lastNameController.text;
    String updatedEmail = _emailController.text;

    // For example, you can print the updated values
    print('Updated First Name: $updatedFirstName');
    print('Updated Last Name: $updatedLastName');
    print('Updated Email: $updatedEmail');
  }

  Future<void> retrieveData() async => _editProfileCubit.retrieveData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
            onPressed: () {
              updateData();
              context.read<EditProfileCubit>().updateUserData({
                'first_name': _firstNameController.text,
                'last_name': _lastNameController.text,
                'email': _emailController.text,
              });
              // Save the changes and navigate back
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<EditProfileCubit, EditProfileState>(
          bloc: _editProfileCubit,
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.isError) {
              return Center(child: Text("Error: ${state.isError}"));
            } else if (state.isLoaded) {
              final user = state.user!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        hintText: user.firstName != ""
                            ? user.firstName
                            : 'First Name',
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        hintText:
                            user.lastName != "" ? user.lastName : "Last Name",
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: user.email != "" ? user.email : "Email",
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("An unexpected state occurred"));
            }
          },
        ),
      ),
    );
  }
}
