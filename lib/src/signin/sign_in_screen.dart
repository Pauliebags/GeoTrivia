import 'package:country_codes/country_codes.dart';
import 'package:flag/flag_enum.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:game_template/src/Questions/ui/shared/color.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
bool _passwordInVisible = true; //a boolean value
final formkey = GlobalKey<FormState>();
TextEditingController userName = TextEditingController();
TextEditingController password = TextEditingController();

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.pripmaryColor,
        title: Text('Welcome to GeoTrivia'),
      ),
      backgroundColor: AppColor.pripmaryColor,
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/geotrivia.jpg' ,width: 250.0, height: 250.0),
              SizedBox(
                height: 10,
              ),
              //userName
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter YOur Name';
                        }
                      },
                      controller: userName,
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                ),
              ),
              //PASSWORD
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter your Password';
                        }
                      },
                      controller: password,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordInVisible ? Icons.visibility_off : Icons.visibility, //change icon based on boolean value
                            color: Theme.of(context).primaryColorDark,),
                          onPressed: (){
                            setState((){
                              _passwordInVisible = !_passwordInVisible; //change boolean value
                            });
                          },
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                      ),
                      keyboardType: TextInputType.visiblePassword,

                      obscureText: _passwordInVisible,
                    ),

                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),

                child: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  elevation: 5.0,
                  minWidth: 150.0,
                  height: 35,
                  color: Color(0xFF801E48),
                  onPressed: () async{
                    //  context.go('/');


                    if (!formkey.currentState!.validate()) {
                      return;
                    }
                    formkey.currentState!.save();
                    try {
                   await   FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: userName.text, password: password.text);
                      context.go('/');
                    } on FirebaseException catch (e){
                      if (e.code == 'user-not-found') {
                        //use method toast
                        Fluttertoast.showToast(
                            msg: "user not found",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                      } else if (e.code == 'wrong-password') {
                        Fluttertoast.showToast(
                            msg: "Wrong Password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.black,
                            fontSize: 16.0
                        );
                      }
                    }
                    catch (e) {
                      Fluttertoast.showToast(
                          msg: "An unknown error occured",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }

                    //context.go('/');
                    print(userName.text);
                    print(password.text);
                  },

                  child: Text('Sign In'),
                ),
              ),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).go('/CreateAccount');
                },
                child: Text('CreateAccount'),
                style: ButtonStyle(),
              ),
              TextButton(
                onPressed: () {
                  //  context.go('/ForgotPassword');
                },
                child: Text('ForgotPassword'),
                style: ButtonStyle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
