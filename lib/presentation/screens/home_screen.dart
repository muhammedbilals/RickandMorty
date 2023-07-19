import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machinetest/bloc/character_bloc.dart';
import 'package:machinetest/core/colors/colors.dart';
import 'package:machinetest/presentation/widgets/AppBarWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();

  int currentPage = 1;

  bool isLoading = false;
  //scroll controll for pagination initialisation
  @override
  void initState() {
    super.initState();
    controller.addListener(() async {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        BlocProvider.of<CharacterBloc>(context).add(LoadMoreData(
          currentPage++,
        ));
        log('event triggered $currentPage');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: AppBarWidget()),
        backgroundColor: colorbg,
        body: BlocBuilder<CharacterBloc, CharacterState>(
          builder: (context, state) {
            if (state is CharacterInitial) {
              context.read<CharacterBloc>().add(FetchCharacters(currentPage));
            }

            if (state is DisplayCharacters) {
              return ListView.builder(
                controller: controller,
                itemCount: state.characterList.length,
                itemBuilder: (context, index) {
                  if (index == state.characterList.length) {
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
                                        state.characterList[index].image)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height: size.width * 0.4,
                                  width: size.width * 0.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        child: Text(
                                          state.characterList[index].name,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${state.characterList[index].status.name} ~',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          Text(
                                            // ignore: unrelated_type_equality_checks
                                            state.characterList[index] == ''
                                                ? ' ${state.characterList[index].species!.name}'
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
                                        state.characterList[index].origin.name,
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
                                        state.characterList[index].location.name
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
            }
            return const Center(child: CircularProgressIndicator());
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
