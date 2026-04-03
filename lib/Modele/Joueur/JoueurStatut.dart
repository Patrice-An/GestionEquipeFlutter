enum JoueurStatut {
  ACTIF,
  BLESSE,
  ABSENT,
  SUSPENDU
}

//Recuperer le statut
extension JoueurStatutGetter on JoueurStatut{
  static JoueurStatut? fromName(String name){
    for (var value in JoueurStatut.values) {
      if(name==value.name){
        return value;
      }
    }
    return null;
  }
}

