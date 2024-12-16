
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trekkingmap/features/home/view/pages/home_page.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // we check wthether we are signed in or not
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoginPage();
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return  CircularProgressIndicator();
          }
              return HomePage();
        } 
      ),
    );
  }
}


// -------------------------------------

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 80.0,),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 25,
                ),
                child: SvgPicture.asset('assets/images/refash.svg', color: Color(0xFFB191C3), height: 200.0,)
              ),
              const Text(
                "Refashion Eco-Exports",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB191C3),
                ),
              ),
              const Text(
                "Premium Ecofriendly Nepalese Attire",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB191C3),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 55),
                child: GestureDetector(
                  onTap: () async {
                    await ref.read(authServiceProvider).signInWithGoogle();
                  },
                  child: Image.asset(
                    "assets/images/signinwithgoogle.png",
                    height: 60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// // -------------------------------------
// // -------------------------------------

final authServiceProvider = Provider(
  (ref) => AuthService(
    auth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
  ),
);

class AuthService {
  FirebaseAuth auth;
  GoogleSignIn googleSignIn;
  AuthService({
    required this.auth,
    required this.googleSignIn,
  });

  signInWithGoogle() async {
    final user = await googleSignIn.signIn();
    final googleAuth = await user!.authentication;
    final credencial = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await auth.signInWithCredential(credencial);
  }
}
