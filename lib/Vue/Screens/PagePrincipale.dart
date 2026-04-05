import 'package:GestEquipe/l10n/app_localizations_en.dart';
import 'package:flutter/material.dart';
import '../../Controleur/RencontreControleur.dart';
import '../../Modele/Rencontre/Rencontre.dart';
import '../../Modele/Rencontre/RencontreResultat.dart';
import '../../Utils/Logs.dart';
import '../../l10n/app_localizations.dart';
import 'MainLayout.dart';

class PagePrincipale extends StatelessWidget {
  const PagePrincipale({super.key});

  Future<Map<String, dynamic>> _chargerDonnees() async {
    await RencontreControleur.RafraichirListe();
    RencontreControleur c = RencontreControleur.getInstance();

    Set<Rencontre> toutes = await c.getAllRencontres();
    // On attend les deux autres appels asynchrones en parallèle
    final resultats = await Future.wait([
      c.getDerniereRencontre(), //Derniere rencontre
      c.getProchaineRencontre(), //Prochaine rencontre
    ]);

    return {
    'toutes': toutes,
    'derniere': resultats[0],
    'prochaine': resultats[1],
    };
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return FutureBuilder(
      future: _chargerDonnees(),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLayout(
            title: AppLocalizations.of(context)!.accueil,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Erreur"));
        }

        if (snapshot.hasData) {
          final Rencontre? derniere = snapshot.data!["derniere"];
          final Rencontre? prochaine = snapshot.data!["prochaine"];

          return MainLayout(
            title: AppLocalizations.of(context)!.accueil,
            child: orientation == Orientation.landscape
                ? _buildLandscape(context, prochaine, derniere)
                : _buildPortrait(context, prochaine, derniere),
          );
        }

        return const Center(child: Text("Erreur inconnue"));
      },
    );
  }

  Widget _buildPortrait(
      BuildContext context,
      Rencontre? prochaine,
      Rencontre? derniere,
      ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          // Welcome
          Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                AppLocalizations.of(context)!.welcome,
                style: const TextStyle(fontSize: 40),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          if (prochaine != null) ...[
            Text(AppLocalizations.of(context)!.nextmatch,
                style: const TextStyle(fontSize: 20)),
            _creerLigne(prochaine, context),
          ],

          if (derniere != null) ...[
            Text(AppLocalizations.of(context)!.lastmatch,
                style: const TextStyle(fontSize: 20)),
            _creerLigne(derniere, context),
          ],
        ],
      ),
    );
  }

  Widget _buildLandscape(
      BuildContext context,
      Rencontre? prochaine,
      Rencontre? derniere,
      ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Gauche
          Expanded(
            flex: 1,
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.welcome,
                  style: const TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Droite
          Expanded(
            flex: 2,
            child: ListView(

              children: [

                if (prochaine != null) ...[
                  Text(AppLocalizations.of(context)!.nextmatch,
                      style: const TextStyle(fontSize: 20)),
                  _creerLigne(prochaine, context),
                ],

                if (derniere != null) ...[
                  Text(AppLocalizations.of(context)!.lastmatch,
                      style: const TextStyle(fontSize: 20)),
                  _creerLigne(derniere, context),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  _creerLigne(Rencontre rencontre,BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              rencontre.getEquipeAdverse(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(rencontre.getDateEtHeure().toString()),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.location_city, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(rencontre.getLieu().name),
                ),
              ],
            ),

            const SizedBox(height: 6),

            Row(
              children: [
                const Icon(Icons.place, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(rencontre.getAdresse()),
                ),
              ],
            ),

            if(rencontre.getResultat() != null)...[
              Row(
                children: [Text(AppLocalizations.of(context)!.labelresultat),
                  switch(rencontre.getResultat()!) {
                    RencontreResultat.VICTOIRE => Icon(Icons.check_box, color: Colors.green),
                    RencontreResultat.PERDU => Icon(Icons.close, color: Colors.red),
                    RencontreResultat.NUL => Icon(Icons.indeterminate_check_box, color: Colors.grey),
                  },],
              )
            ],

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
