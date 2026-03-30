class Configs{

  static const String _servUrl = "http://r401-serv.alwaysdata.net/Endpoint/";
  static const String _authUrl = "http://r401-auth.alwaysdata.net/clientapi.php";
  static const String _authKey = "AZeXA/pVPzt#6+U2FZXdtg#c!/S*+w7fAgbT2uBUU-pk6qfmdkJS7F#KVW?N!45z";
  static late String _jwt = "";

  static String getServUrl(){
    return _servUrl;
  }

  static String getAuthUrl(){
    return _authUrl;
  }

  static String getAuthKey(){
    return _authKey;
  }

  static void setJwt(String jwt){
    _jwt = jwt;
  }

  static String getJwt(){
    return _jwt;
  }
}