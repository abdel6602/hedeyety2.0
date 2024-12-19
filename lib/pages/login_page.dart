import 'package:flutter/material.dart';
import '../app_colors.dart';
import 'home_page.dart';
import 'sign_up_page.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _username = '';
  String _password = '';
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.primaryDark,
      body: _buildBody(),
    );

  }

  Widget _buildBody(){
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Icon
                _buildProfileAvatar(),
                const SizedBox(height: 30),
                // Username TextField
                _buildUsernameTextField(),
                const SizedBox(height: 15),
                // Password TextField and show password button
                _buildPasswordTextFieldStack(),

                const SizedBox(height: 10),
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildForgotPasswordTextButton(),
                ),

                const SizedBox(height: 20),
                // Login Button
                _buildLoginButton(),
                const SizedBox(height: 20),
                // Facebook Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLoginWithFacebookButton(),
                  ],
                ),
                const SizedBox(height: 20),
                // Sign Up Text
                _buildSignUpPrompt(),
              ],
            ),
          ),
        ),
      ),);
  }

  Widget _buildSignUpPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't Have An Account?",
          style: TextStyle(color: Colors.white),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
          child: Text(
            'Sign Up!',
            style: TextStyle(color: Colors.blue[400]),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginWithFacebookButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            const Text("Login with", style: TextStyle(color: Colors.black),),
            IconButton(
              onPressed: () {},
              icon:  Icon(Icons.facebook_rounded,
                  color: Colors.blue[900], size: 40),

            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(){
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.grey[800],
      child: Icon(
        Icons.person,
        size: 60,
        color: Colors.grey[400],
      ),
    );
  }

  Widget _buildUsernameTextField() {
    return TextField(
      controller: _usernameController,
      onChanged: (value) {
        setState(() {
          _username = value;
        });
      },
      decoration: InputDecoration(
        hintText: 'Email',
        filled: true,
        fillColor: AppColors.textColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordTextFieldStack() {
    return Stack(
      children: [
        TextField(
          controller: _passwordController,
          onChanged: (value) {
            setState(() {
              _password = value;
            });
          },
          obscureText: _isObscure,
          decoration: InputDecoration(
            hintText: 'Password',
            filled: true,
            fillColor: Colors.grey[300],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        //show password button
        Positioned(
          right: 0,
          child: IconButton(
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            },
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordTextButton() {
    return TextButton(
      onPressed: () {
        print("forgot password!");
      },
      child: Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.blue[400]),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: () {
        print('Username: $_username');
        print("***********");
        print("Password: $_password");
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFBC02D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: Text(
        'Login',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

