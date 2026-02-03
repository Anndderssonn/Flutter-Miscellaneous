import 'package:miscellaneous/config/config.dart';
import 'package:quick_actions/quick_actions.dart';

class QuickActionsPlugin {
  static void registerActions() {
    final QuickActions quickActions = const QuickActions();
    quickActions.initialize((type) {
      switch (type) {
        case 'biometric':
          router.push('/biometrics');
          break;
        case 'compass':
          router.push('/compass');
          break;
        case 'pokemons':
          router.push('/pokemons');
          break;
        case 'charizard':
          router.push('/pokemons/6');
          break;
      }
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      const ShortcutItem(
        type: 'biometric',
        localizedTitle: 'Biometric',
        icon: 'finger',
      ),
      const ShortcutItem(
        type: 'compass',
        localizedTitle: 'Compass',
        icon: 'compass',
      ),
      const ShortcutItem(
        type: 'pokemons',
        localizedTitle: 'Pokemons',
        icon: 'pokemons',
      ),
      const ShortcutItem(
        type: 'charizard',
        localizedTitle: 'Charizard',
        icon: 'charizard',
      ),
    ]);
  }
}
