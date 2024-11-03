part of '_pages.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchCubit _searchCubit;

  @override
  void initState() {
    super.initState();
    _searchCubit = get.get<SearchCubit>();
    retrieveData();
  }

  @override
  void dispose() {
    _searchCubit.close();
    super.dispose();
  }

  Future<void> retrieveData() async => _searchCubit.retrieveData();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( 
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.yellow.shade300,
                  Colors.yellow.shade700,
                ],
                begin: Alignment.topLeft, 
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.search, color: Colors.grey.shade700, size: 30,),
                      Icon(Icons.filter_alt_rounded, color: Colors.grey.shade700, size: 25,)
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(10, (index) {
                return InkWell(
                  onTap: () {
                    SuccessMessenger("Bahahaha").show(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 5, left: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Text("show bar"),
                  ),
                );
              }).toList(),
              )
            ),
          ),
          BlocBuilder<SearchCubit, SearchState>(
            bloc: _searchCubit,
            builder: (context, state) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.dishes.length,
                itemBuilder: (context, index) {
                  final dish = state.dishes[index];
                  return ListTile(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProdetailScreen(dihsId: dish.id,)
                    )),
                    leading: const Icon(Icons.dining_sharp),
                    title: Text(dish.name),
                    trailing: Text(dish.price),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
