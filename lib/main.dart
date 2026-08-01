import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/router/router_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/formatos.dart';
import 'features/configuracion/presentation/providers/ajustes_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // `intl` necesita cargar los símbolos de es_PE una sola vez antes de que
  // cualquier `DateFormat` los use (ver `core/utils/formatos.dart`).
  await initializeDateFormatting(kLocalePeru);

  runApp(const ProviderScope(child: AppFacturacion()));
}

class AppFacturacion extends ConsumerWidget {
  const AppFacturacion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Facturación SUNAT',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.claro(),
      darkTheme: AppTheme.oscuro(),
      themeMode: ref.watch(modoTemaProvider),
      routerConfig: ref.watch(routerProvider),

      // La app es íntegramente es-PE: fechas, selectores y textos de Material.
      locale: const Locale('es', 'PE'),
      supportedLocales: const [Locale('es', 'PE'), Locale('es')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
