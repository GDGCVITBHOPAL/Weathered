import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weathered/main.dart';

import '../../../utils/style.dart';

final Uri _url = Uri.parse('https://github.com/DSCVITBHOPAL/Weathered');

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Text(
              'Settings',
              style: AppStyle.textTheme.titleLarge,
            ),
          ),
          const Gap(8),

          // Theme Mode Dropdown
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(Icons.display_settings_rounded, size: 35.0),
                const Gap(10.0),
                Text('Theme Mode', style: AppStyle.textTheme.labelMedium),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton<ThemeMode>(
                        value: themeMode,
                        onChanged: (ThemeMode? newMode) {
                          if (newMode != null) {
                            ref.read(themeModeProvider.notifier).state =
                                newMode;
                          }
                        },
                        items: const [
                          DropdownMenuItem(
                            value: ThemeMode.system,
                            child: Text('System Default'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.light,
                            child: Text('Light Mode'),
                          ),
                          DropdownMenuItem(
                            value: ThemeMode.dark,
                            child: Text('Dark Mode'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Send Feedback
          GestureDetector(
            onTap: _launchUrl,
            child: Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 5),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(15.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.mail_outline_rounded, size: 35.0),
                  const Gap(10.0),
                  Text("Send Feedback", style: AppStyle.textTheme.labelMedium),
                ],
              ),
            ),
          ),

          // Made with Love
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Made With <3 GDSC VITB"),
                Gap(20.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
