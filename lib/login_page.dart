import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Sign in.',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              SocialButton(
                  label: 'Continue with Facebook', icon: Icons.facebook),
              SizedBox(
                height: 20,
              ),
              LoginField(hint: 'Email'),
              SizedBox(
                height: 20,
              ),
              GradientButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final double horizontalPadding;

  const SocialButton(
      {Key? key,
      required this.label,
      required this.icon,
      this.horizontalPadding = 70})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(
        label,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      style: TextButton.styleFrom(
          padding:
              EdgeInsets.symmetric(vertical: 20, horizontal: horizontalPadding),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey, width: 3),
              borderRadius: BorderRadius.circular(10))),
    );
  }
}

class LoginField extends StatelessWidget {
  final String hint;

  const LoginField({Key? key, required this.hint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 360),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(22),
            hintText: hint,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 3),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 3),
                borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            colors: [Colors.orange, Colors.orangeAccent, Colors.red],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size(355, 55),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {},
          child: Text(
            'Login',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
          )),
    );
  }
}
