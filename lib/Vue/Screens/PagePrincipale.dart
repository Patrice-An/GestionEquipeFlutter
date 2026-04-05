import 'package:GestEquipe/l10n/app_localizations_en.dart';
import 'package:flutter/material.dart';
import '../../Controleur/RencontreControleur.dart';
import '../../Modele/Rencontre/Rencontre.dart';
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
    RencontreControleur c = RencontreControleur.getInstance();
    return FutureBuilder(
      future: _chargerDonnees(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        //Attente chargement
        if (snapshot.connectionState == ConnectionState.waiting) {
          Logs.addInfo("Attente chargement");
          return MainLayout(
            title: AppLocalizations.of(context)!.accueil,
            child: const Center(child:CircularProgressIndicator(),
            ),
          );
        }

        //Echec chargement
        if (snapshot.hasError) {
          Logs.addShout("Echec chargement rencontre sur PagePrincipale");
          return Scaffold(
            body: Center(child: Text("Echec chargement.")),
          );
        }

        //Reussite chargement
        if (snapshot.hasData) {
          Logs.addFinest("Reussite du chargement des rencontres sur PagePrincipale!");
          print(snapshot.data!.toString());
          final Set<Rencontre> rencontres = snapshot.data!["toutes"];
          final Rencontre? derniereRencontre = snapshot.data!["derniere"];
          final Rencontre? prochaineRencontre = snapshot.data!["prochaine"];
          return MainLayout(
            title: AppLocalizations.of(context)!.accueil,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Text de bienvenue
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
                    )
                  ),

                  //Prochaine rencontre
                  if(prochaineRencontre!=null)...[
                    Text(AppLocalizations.of(context)!.nextmatch, style: const TextStyle(fontSize: 20)),
                    _creerLigne(prochaineRencontre)
                  ],

                  //Derniere rencontre
                  if(derniereRencontre!=null)...[
                    Text(AppLocalizations.of(context)!.lastmatch, style: const TextStyle(fontSize: 20)),
                    _creerLigne(derniereRencontre)
                  ]
                ],
              ),
            ),
          );
        }
        return Center(child: Text("Erreur chargement non prévue."));
      },
    );
  }

  _creerLigne(Rencontre rencontre) {
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

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
