import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workmanager/workmanager.dart';
import 'package:miscellaneous/config/config.dart';
import 'package:miscellaneous/domain/domain.dart';
import 'package:miscellaneous/presentation/providers/providers.dart';

class DbPokemonsScreen extends ConsumerWidget {
  const DbPokemonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonsDb = ref.watch(pokemonDbProvider);
    final isPokemonFetchActive = ref.watch(backgroundPokemonFetchProvider);

    if (pokemonsDb.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final List<Pokemon> pokemons = pokemonsDb.value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Process'),
        actions: [
          IconButton(
            onPressed: () {
              Workmanager().registerOneOffTask(
                fetchBackgroundTaskKey,
                fetchBackgroundTaskKey,
                initialDelay: const Duration(seconds: 3),
                inputData: {'bkg process': 'simple task'},
              );
            },
            icon: const Icon(Icons.add_alarm_sharp),
          ),
        ],
      ),
      body: CustomScrollView(slivers: [_PokemonsGrid(pokemons: pokemons)]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(backgroundPokemonFetchProvider.notifier).toggleProcess();
        },
        label: (isPokemonFetchActive == true)
            ? const Text('Deactive periodic fetch')
            : const Text('Active periodic fetch'),
        icon: const Icon(Icons.av_timer),
      ),
    );
  }
}

class _PokemonsGrid extends StatelessWidget {
  final List<Pokemon> pokemons;

  const _PokemonsGrid({required this.pokemons});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return Column(
          children: [
            Image.network(pokemon.spriteFront, fit: BoxFit.contain),
            Text(pokemon.name),
          ],
        );
      },
    );
  }
}
