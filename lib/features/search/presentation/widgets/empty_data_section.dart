part of '_widgets.dart';

class EmptyDataSection extends StatefulWidget {
  const EmptyDataSection({super.key});

  @override
  State<EmptyDataSection> createState() => _EmptyDataSectionState();
}

class _EmptyDataSectionState extends State<EmptyDataSection> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}