import 'package:flutter/material.dart';
import 'package:machinetest/core/colors/colors.dart';
import 'package:machinetest/presentation/widgets/AppBarWidget.dart';
import 'package:machinetest/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: AppBarWidget()),
        backgroundColor: colorbg,
        body: FutureBuilder(
          future: ApiService.getCharacters(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('error loading deta'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
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
                                    snapshot.data!.results[index].image)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: size.width * 0.1,
                                  width: size.width * 0.5,
                                  child: Text(
                                    snapshot.data!.results[index].name,
                                    style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${snapshot.data!.results[index].status.name} ~',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      ' ${snapshot.data!.results[index].species.name}',
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
                                  snapshot.data!.results[index].origin.name,
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
                                  snapshot.data!.results[index].location.name
                                      .toString(),
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
