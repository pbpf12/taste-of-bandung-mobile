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
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox,
              size: 100,
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            Text(
              'No Data Available',
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