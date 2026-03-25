enum RencontreResultat {
  VICTOIRE,
  PERDU,
  NUL
}

//Recuperer le Resultat
extension RencontreResultatGetter on RencontreResultat{
  static RencontreResultat? fromName(String name){
    for (var value in RencontreResultat.values) {
      if(name==value){
        return value;
      }
    }
    return null;
  }
}

