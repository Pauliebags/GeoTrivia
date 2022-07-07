
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
final formkey=GlobalKey<FormState>();
TextEditingController userName =TextEditingController();
TextEditingController password =TextEditingController();
class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignIN'),
      ),
      body: Form(
        key:formkey ,
        child: Column(
          children: [
            //userName
            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter YOur Name';
                }
              },
              controller: userName,
              decoration: InputDecoration(
                hintText: 'User Name',
                hintStyle: TextStyle(color: Colors.red),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.name,
            ),
            //PASSWORD
            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return 'Please Enter your Password';
                }
              },
              controller: password,
              decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.red),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            MaterialButton(onPressed: (){
            //  context.go('/');
              if(!formkey.currentState!.validate()){
                return;
              }
              formkey.currentState!.save();
              context.go('/');
              print(userName.text);
              print(password.text);
            },color: Colors.red,child: Text('Sign In'),),
            TextButton(onPressed: (){
              context.go('/CreateAccount');
            }, child: Text('CreateAccount'), style:ButtonStyle(),),
            TextButton(onPressed: (){
            //  context.go('/ForgotPassword');
            }, child: Text('ForgotPassword'), style:ButtonStyle(),),
          ],
        ),
      ),
    );
  }
}
