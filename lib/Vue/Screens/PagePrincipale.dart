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
                  const Text('Mini-Projet', style: TextStyle(fontSize: 40)),
                  Text('Rencontres trouvées : ${rencontres.length}'),
                  if(prochaineRencontre!=null)...[
                    Text('Prochaine Rencontre : ${prochaineRencontre.getEquipeAdverse()}')
                  ],
                  if(derniereRencontre!=null)...[
                    Text('Derniere Rencontre : ${derniereRencontre.getEquipeAdverse()}')
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
}
