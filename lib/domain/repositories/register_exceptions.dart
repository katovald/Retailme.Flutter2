class APIExceptions implements Exception{
  final String message;
  final int statusCode;
  final String statusText;

  APIExceptions(this.message,this.statusCode, this.statusText);
}