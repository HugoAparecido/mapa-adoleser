import 'package:flutter/material.dart';
import 'package:mapa_adoleser/core/constants.dart';
import 'package:mapa_adoleser/core/utils/responsive_utils.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/appbar/custom_app_bar.dart';
import 'package:mapa_adoleser/presentation/ui/widgets/drawer/custom_drawer.dart';
import 'package:mapa_adoleser/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: CustomAppBar(isLoggedIn: authProvider.isLoggedIn),
      endDrawer: ResponsiveUtils.shouldShowDrawer(context)
          ? CustomDrawer(isLoggedIn: authProvider.isLoggedIn)
          : null,
      body: SingleChildScrollView(
        padding: ResponsiveUtils.pagePadding(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ==========================================
            // SEÇÃO 1: SOBRE O ADOLESER
            // ==========================================
            Text(
              AppTexts.about.aboutAdoleserTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 15),
            SelectableText(
              AppTexts.about.aboutAdoleserParagraph,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/megafonetexto.png',
              height: 200,
              fit: BoxFit
                  .contain, // Boa prática para garantir que a imagem não distorça
            ),

            // Espaçamento grande para separar as seções
            const SizedBox(height: 40),

            // ==========================================
            // SEÇÃO 2: SOBRE O PET BCC
            // ==========================================
            Text(
              AppTexts.about.aboutPETBCCTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 15),
            SelectableText(
              AppTexts.about.aboutPETBCCParagraph,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Logos lado a lado
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(
                    'assets/images/logo_ufscar.png',
                    height: 125,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                    width: 20), // Aumentei um pouco o respiro entre as logos
                Flexible(
                  child: Image.asset(
                    'assets/images/pet_logo_azul.png',
                    height: 225,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
