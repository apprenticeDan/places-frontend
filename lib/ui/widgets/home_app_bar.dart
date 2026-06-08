import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:places/domain/providers.dart';
import 'package:places/ui/screens/login_screen.dart';
import 'package:places/ui/widgets/gradient_back.dart';

import 'card_image_list.dart';

class HomeAppBar extends ConsumerWidget {
  final String textoTitulo;

  const HomeAppBar(this.textoTitulo, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    final titulo = Container(
      margin: EdgeInsets.only(top: 40, left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            textoTitulo,
            style: TextStyle(
              fontFamily: "Lato",
              fontWeight: FontWeight.w900,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          // ─── Botón de Cerrar Sesión ─────────────────────────────────
          if (authState.isLoggedIn)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                tooltip: 'Cerrar Sesión',
                onPressed: () async {
                  await ref.read(authProvider.notifier).logout();
                  if (context.mounted) {
                    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
              ),
            ),
        ],
      ),
    );

    final appBar = Stack(
      children: <Widget>[
        GradientBack(),
        CardImageList(),
        titulo,
      ],
    );

    return appBar;
  }
}