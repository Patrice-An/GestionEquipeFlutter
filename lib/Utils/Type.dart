enum TypeObjet {
  JOUEURS('joueurs.json','JoueurEndpoint.php'),
  RENCONTRES('rencontres.json','RencontreEndpoint.php');

  final String _path;
  final String _uri;

  const TypeObjet(this._path, this._uri);

  String getPath(){
    return _path;
  }

  String getUri(){
    return _uri;
  }
}