import 'package:flutter/material.dart';
import '../app_colors.dart';
import '/pages/home_page.dart';
import '../reusables/app_bar.dart';
import '../reusables/drawer.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key? key }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailControlller = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(showProfilePicture: true, title: 'Sign Up', isDarkMode: true,),
        drawer: MyDrawer(),
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.primaryDark,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    _buildProfileAvatar(),
                    const SizedBox(height: 30,),
                    _buildTextField(_nameController, "Full Name", false, (value){
                      if(value.isEmpty){
                        return 'Please enter your name';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20,),
                    _buildTextField(_emailControlller, 'Email', false, (value){
                      if(value.isEmpty){
                        return 'Please enter your email';
                      }
                      if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                        return "Please enter a valid email address";
                      }
                      return null;
                    }),
                    const SizedBox(height: 20,),
                    _buildTextField(_phoneNumberController, "Phone Number eg +201000000000", false, (value){
                      if(value == null || value.isEmpty){
                        return "Please enter your phone number";
                      }
                      if(!RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$').hasMatch(value)){
                        return "Please enter a valid phone number";
                      }
                      return null;
                    }),
                    const SizedBox(height: 20,),
                    _buildTextField(_passwordController, 'Password', true, (value){
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    }),
                    const SizedBox(height: 20,),
                    _buildTextField(_repeatPasswordController, 'Confirm Password', true, (value){
                      if(value == null || value.isEmpty){
                        return "Please Confirm your password";
                      }
                      if(value != _passwordController.text){
                        return "Passwords do not match";
                      }
                      return null;
                    }),
                    const SizedBox(height: 40,),
                    _buildTextButton('Sign Up', (){
                      if(_formKey.currentState!.validate()){
                        print("***********");
                        print('Sign Up');
                        print("***********");

                        //TODO: Implement Sign Up Logic
                        // TODO: Save uid in shared preferences
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));

                      }
                    }),
                    const SizedBox(height: 20,),
                    _buildLoginWithFacebookButton(),

                  ],
                ),
              ),
            ),
          ),
        )
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Sign Up with", style: TextStyle(color: Colors.black),),
            IconButton(
              onPressed: () {
                print("***********");
                print("Sign Up with Facebook");
                print("***********");
              },
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

  Widget _buildTextField(controllerObj, hint, isPassword, validatorFunction){
    return Stack(
      children: [
        TextFormField(
          obscureText: isPassword ? _isObscure : false,
          controller: controllerObj,
          onChanged: (value) {
            setState(() {
              controllerObj = value;
            });
          },
          validator: validatorFunction,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppColors.textColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
        ),

        if(isPassword) _renderShowPassword(),

      ],
    );

  }

  Widget _buildTextButton(String text, onPress) {
    return ElevatedButton(
      onPressed: onPress  ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _renderShowPassword(){
    return Positioned(
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
    );
  }

}