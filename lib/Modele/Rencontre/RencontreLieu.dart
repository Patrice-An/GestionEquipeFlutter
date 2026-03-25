enum RencontreLieu {
  DOMICILE,
  EXTERIEUR
}

//Recuperer le Lieu
extension RencontreLieuGetter on RencontreLieu{
  static RencontreLieu? fromName(String name){
    for (var value in RencontreLieu.values) {
      if(name==value){
        return value;
      }
    }
    return null;
  }
}

