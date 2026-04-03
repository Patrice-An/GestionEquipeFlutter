enum RencontreResultat {
  VICTOIRE,
  PERDU,
  NUL
}

//Recuperer le Resultat
extension RencontreResultatGetter on RencontreResultat{
  static RencontreResultat? fromName(String? name){
    if(name==null){
      return null;
    }
    for (var value in RencontreResultat.values) {
      if(name==value.name){
        return value;
      }
    }
    return null;
  }
}

