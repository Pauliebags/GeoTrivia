import 'package:flutter/material.dart';
import 'theme_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../style/palette.dart';
import '../style/responsive_screen.dart';
import 'custom_name_dialog.dart';
import 'settings.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const _gap = SizedBox(height: 60);
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    final palette = context.watch<Palette>();
    final themeProvider = Provider.of<ThemeProvider>(context);
    setState((){});
    return Scaffold(
      backgroundColor: palette.backgroundSettings,
      body: ResponsiveScreen(
        squarishMainArea: ListView(
          children: [
            SettingsScreen._gap,
            const Text(
              'Settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Permanent Marker',
                fontSize: 55,
                height: 1,
              ),
            ),
            SettingsScreen._gap,
            ValueListenableBuilder<bool>(
              valueListenable: settings.soundsOn,
              builder: (context, soundsOn, child) => _SettingsLine(
                'Sound FX',
                Icon(soundsOn ? Icons.graphic_eq : Icons.volume_off),
                onSelected: () => settings.toggleSoundsOn(),
              ),
            ),
            ValueListenableBuilder<bool>(
              valueListenable: settings.musicOn,
              builder: (context, musicOn, child) => _SettingsLine(
                'Music',
                Icon(musicOn ? Icons.music_note : Icons.music_off),
                onSelected: () => settings.toggleMusicOn(),
              ),
            ),
            _SettingsLine(
              'Light/Dark',
              SwitchThemeMode(themeProvider: themeProvider),
              onSelected: () {},
            ),
            SettingsScreen._gap,
          ],
        ),
        rectangularMenuArea: ElevatedButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          child: const Text('Back'),
        ),
      ),
    );
    setState((){});
  }
}
class _NameChangeLine extends StatelessWidget {
  final String title;
  const _NameChangeLine(this.title);
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsController>();
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: () => showCustomNameDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 30,
                )),
            const Spacer(),
            ValueListenableBuilder(
              valueListenable: settings.playerName,
              builder: (context, name, child) => Text(
                '‘$name’',
                style: const TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _SettingsLine extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback? onSelected;
  const _SettingsLine(this.title, this.icon, {this.onSelected});
  @override
  Widget build(BuildContext context) {
    return InkResponse(
      highlightShape: BoxShape.rectangle,
      onTap: onSelected,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                  fontFamily: 'Permanent Marker',
                  fontSize: 30,
                )),
            const Spacer(),
            icon,
          ],
        ),
      ),
    );
  }
}
class SwitchThemeMode extends StatefulWidget {
  final themeProvider;
  const SwitchThemeMode({this.themeProvider, Key? key}) : super(key: key);
  @override
  State<SwitchThemeMode> createState() => _SwitchThemeModeState();
}
class _SwitchThemeModeState extends State<SwitchThemeMode> {
  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: widget.themeProvider.isDarkMode,
      onChanged: (value) {
        setState((){
          final provider = Provider.of<ThemeProvider>(context, listen: false);
          provider.toggleTheme(value);
        });
      },
    );
  }
}
