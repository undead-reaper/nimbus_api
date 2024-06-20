import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(
    body:
        'Welcome to Nimbus API! To get a screenshot of a tweet use /twitter?screenshot=<tweet_url>',
  );
}
