import 'package:flutter/material.dart';

class JoueurListView extends Stateless{

  private List<Joueur> _items;

  Widget build(BuildContext context) {
    return ListView.builder(
      // ListView.builder pour afficher une liste dynamique
      itemCount: _items.length,
      itemBuilder:
          (context, index) =>
          ListTile(
            // ListTile est un gabarit généralement utilisé pour afficher un item de ListView
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            title: Text(
              _items[index],
              style: const TextStyle(fontSize: 30),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => setState(() => _items.removeAt(index)),
            ),
            // Affichage d'un SnackBar lors du tap sur un item.
            // Le SnackBar est un widget qui affiche un message temporaire en bas de l'écran
            onTap:
                () =>
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Item sélectionné: ${_items[index]} n°${index + 1}',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                ),
          ),
    )
  }


}

