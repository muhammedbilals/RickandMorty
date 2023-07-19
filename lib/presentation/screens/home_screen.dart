import 'package:flutter/material.dart';
import 'package:machinetest/core/colors/colors.dart';
import 'package:machinetest/model/charcter_model.dart';
import 'package:machinetest/presentation/widgets/AppBarWidget.dart';
import 'package:machinetest/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  late Future<RickyMortyCharacters> rickandmorty;
  int currentPage = 1;
  List<Result> characterList = [];
  bool isLoading = false;

  @override
  void initState() {
    rickandmorty = ApiService.getCharacters(currentPage);

    super.initState();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        loadMoreData();
      }
    });
  }

  Future<void> loadMoreData() async {
    
    if (!isLoading) {
      setState(() {
        isLoading = true;
        currentPage++;
      });

      final newCharacters = await ApiService.getCharacters(currentPage);
      if (newCharacters.results.isNotEmpty &&newCharacters.info.next!='') {
        setState(() {
          characterList.addAll(newCharacters.results);
          isLoading = false;
  
        });
      } else {
        setState(() {
          isLoading = false;
         
          return;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: AppBarWidget()),
        backgroundColor: colorbg,
        body: FutureBuilder(
          future: rickandmorty,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('error loading deta'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            characterList = snapshot.data!.results;

            return ListView.builder(
              controller: controller,
              itemCount: snapshot.data!.results.length,
              itemBuilder: (context, index) {
                if (index == characterList.length) {
                  buildLoaderIndicator();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      height: size.width * 0.4,
                      width: size.width,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: colorwhite),
                        child: Row(
                          children: [
                            SizedBox(
                              height: size.width * 0.4,
                              width: size.width * 0.4,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                      characterList[index].image)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: size.width * 0.4,
                                width: size.width * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        characterList[index].name,
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${characterList[index].status.name} ~',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          characterList[index] == ''
                                              ? ' ${characterList[index].species!.name}'
                                              : 'unkown',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Last Known Location:',
                                      style: TextStyle(
                                          color: colorblack.withOpacity(0.5)),
                                    ),
                                    Text(
                                      characterList[index].origin.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13),
                                    ),
                                    const Spacer(),
                                    Text(
                                      'First seen in:',
                                      style: TextStyle(
                                          color: colorblack.withOpacity(0.5)),
                                    ),
                                    Text(
                                      characterList[index]
                                          .location
                                          .name
                                          .toString(),
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return null;
              },
            );
          },
        ),
      ),
    );
  }

  Widget buildLoaderIndicator() {
    return SizedBox(
      height: 40.0,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(),
    );
  }
}
