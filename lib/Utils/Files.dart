enum Files {
  JOUEURS('joueurs.json'),
  RENCONTRES('rencontres.json');

  final String path;

  const Files(this.path);
}