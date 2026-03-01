import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  
  // Google Client ID for Web (Needs to be provided by user)
  static const String _googleWebClientId = 'YOUR_GOOGLE_WEB_CLIENT_ID.apps.googleusercontent.com';

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: kIsWeb ? _googleWebClientId : null,
    scopes: ['email', 'profile'],
  );

  // Placeholders for pramari.de OAuth2
  static const String _pramariClientId = '7FUQcMNl3kg23QXsB96jUV47Rt1VETrEEi0jfbis';
  static const String _pramariRedirectUri = kIsWeb 
      ? 'http://localhost:57266' // Placeholder for Web
      : 'com.example.inoapp://oauthredirect';
  static const String _pramariDiscoveryUrl = 'https://pramari.de/o/.well-known/openid-configuration';

  Future<bool> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final GoogleSignInAuthentication auth = await account.authentication;
        await _saveToken(auth.accessToken ?? '', 'google');
        return true;
      }
    } catch (e) {
      print('Google login error: $e');
    }
    return false;
  }

  Future<bool> loginWithPramari() async {
    try {
      if (kIsWeb) {
        // Simple OAuth2 launch for Web since flutter_appauth doesn't support it
        // Note: You'll need to handle the token extraction from the URL on return
        final authUrl = Uri.parse('https://pramari.de/o/authorize/'
            '?client_id=$_pramariClientId'
            '&redirect_uri=$_pramariRedirectUri'
            '&response_type=token'
            '&scope=openid profile email');
        
        if (await canLaunchUrl(authUrl)) {
          await launchUrl(authUrl, webOnlyWindowName: '_self');
          return true; // We triggered the launch
        }
        return false;
      }

      final AuthorizationTokenResponse? result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          _pramariClientId,
          _pramariRedirectUri,
          discoveryUrl: _pramariDiscoveryUrl,
          scopes: ['openid', 'profile', 'email'],
        ),
      );

      if (result != null && result.accessToken != null) {
        await _saveToken(result.accessToken!, 'pramari');
        return true;
      }
    } catch (e) {
      print('Pramari login error: $e');
    }
    return false;
  }

  Future<void> _saveToken(String token, String provider) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    await prefs.setString('auth_provider', provider);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('auth_provider');
    await _googleSignIn.signOut();
  }
}
