import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscellaneous/config/config.dart';
import 'package:miscellaneous/domain/domain.dart';
import 'package:miscellaneous/presentation/providers/providers.dart';

class PokemonScreen extends ConsumerWidget {
  final String pokemonId;

  const PokemonScreen({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonProvider(pokemonId));

    return pokemon.when(
      data: (pokemon) => _PokemonView(pokemon: pokemon),
      error: (error, stackTrace) =>
          _PokemonErrorView(message: error.toString()),
      loading: () => const _LoadingWidget(),
    );
  }
}

class _PokemonView extends StatelessWidget {
  final Pokemon pokemon;

  const _PokemonView({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
        actions: [
          IconButton(
            onPressed: () {
              SharePlugin.shareLink(
                pokemon.spriteFront,
                'Look at this pokemon',
              );
            },
            icon: const Icon(Icons.share_outlined),
          ),
        ],
      ),
      body: Center(
        child: Image.network(
          pokemon.spriteFront,
          fit: BoxFit.contain,
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}

class _PokemonErrorView extends StatelessWidget {
  final String message;

  const _PokemonErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text(message)));
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
