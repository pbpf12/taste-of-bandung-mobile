part of '../_widgets.dart';

class ProfileBar extends StatelessWidget {
  final UserModel user;

  const ProfileBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row (
      children: [
        const CircleAvatar( 
        radius: 40.0,
        backgroundColor: Colors.grey,
      ),
      const SizedBox(width: 16.0),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          ProfileInfo(
            text: user.username, 
            fontWeight: FontWeight.bold, 
            color: Colors.black),
          ProfileInfo(
            text: user.firstName != "" && user.lastName != "" ? "${user.firstName} ${user.lastName}" : "", 
            fontWeight: FontWeight.normal, 
            color: Colors.grey),
          ProfileInfo(
            text: user.email != "" ? user.email : "-", 
            fontWeight: FontWeight.normal, 
            color: Colors.grey),
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
    );
  }
}