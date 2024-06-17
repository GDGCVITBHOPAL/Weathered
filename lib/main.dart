import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/features/home/view/home_view.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.system);

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;
        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.blueAccent);
          darkColorScheme = ColorScheme.fromSeed(seedColor: Colors.blueAccent);
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomeView(),
          theme: ThemeData(
            fontFamily: 'Poppins',
            colorScheme: lightColorScheme.copyWith(),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            fontFamily: 'Poppins',
            colorScheme: darkColorScheme.copyWith(),
            useMaterial3: true,
          ),
          themeMode: themeMode,
        );
      },
    );
  }
}
