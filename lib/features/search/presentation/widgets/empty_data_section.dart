part of '_widgets.dart';

class EmptyDataSection extends StatefulWidget {
  const EmptyDataSection({super.key});

  @override
  State<EmptyDataSection> createState() => _EmptyDataSectionState();
}

class _EmptyDataSectionState extends State<EmptyDataSection> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 300,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6),
            const Icon(
              Icons.inbox,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              'No Dishes Available',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}