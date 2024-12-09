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

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.firstName);
    _lastNameController = TextEditingController(text: widget.lastName);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [
          IconButton(
            onPressed: () {
              // Save the changes and navigate back
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  hintText: "First Name",
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  hintText: "Last Name",
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}