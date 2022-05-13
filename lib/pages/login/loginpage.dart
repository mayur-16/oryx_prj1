
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oryx_prj1/pages/home/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextStyle style1 =
  const TextStyle(fontSize: 40, fontWeight: FontWeight.bold);
  final List<Color> colorizeColors = const [
    Colors.black87,
    Colors.green,
    Colors.orange,
    Colors.teal,
  ];

  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocus = FocusNode();

  bool _isObscure = true;
  //bool _loading = false;
  bool _usernameInvalid = false, _passwordInvallid = false;


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body: /*_loading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : */SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06),
                  Text(
                    "ORYX ALUMINIUM",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.merriweather(color: const Color(0xff34495E),
                        fontSize: 17,fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08),

                  Center(
                    child: Image.asset("assets/oryx_logo.jpeg",height: 80,width: 120),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09),
                  TextFormField(
                    controller: usernameController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
/*                            focusColor: Colors.black87,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black87)),*/
                      border: const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      errorText:
                      _usernameInvalid ? "username invalid" : null,
                      labelText: "Username",
                      hintText: "Enter user name",
                      prefixIcon: const Icon(Icons.account_box),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter user name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _isObscure,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (term) {
                      loginValidation();
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                      ),
                      contentPadding: const EdgeInsets.all(10),
                      labelText: "Password",
                      hintText: "Enter Password",
                      prefixIcon: const Icon(Icons.lock),
                      errorText:
                      _passwordInvallid ? "Password invalid" : null,
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: loginValidation,
                          child: const Text("Login"))),
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05),
                ],
              ),
            ),
          )),
    );
  }

  void loginValidation() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        //clear all error messages
        _usernameInvalid = false;
        _passwordInvallid = false;
        //_loading=true;
      });

      Get.to(const HomePage());
      /*Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomePage()));*/
      passwordFocus.unfocus();
      //getLoginDetailsfromApi();
    } else {
      return;
    }
  }
}

//like fontstyles  ---- tangerine,rockSalt,ralewayDots
//best fontstyles -----cabinSketch,londrinaSketch
