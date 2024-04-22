class Auth {
  final String tokenEndpoint;
  final String clientId;
  final String clientSecret;

  Auth({
    required this.tokenEndpoint,
    required this.clientId,
    required this.clientSecret,
  });
}