import 'package:flutter/material.dart';

import '../../shared/styles/colors.dart';

class LoginScreen extends StatefulWidget
{
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Shop',
              style: TextStyle(fontSize: 30,fontFamily: 'bebas'),
            ),
            Text(
              'Savvy',
              style: TextStyle(fontSize: 30,fontFamily: 'futura'),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key:formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onFieldSubmitted: (String value)
                    {
                      print(value);
                    },
                    onChanged: (String value)
                    {
                      print(value);
                    },
                    validator: (value)
                    {
                      if(value!.isEmpty){
                        return "email must not be empty";
                      }
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: TextStyle(),
                      prefixIcon: Icon(
                        Icons.email,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: MyColors.greyColor,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: MyColors.fire,),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isPassword,
                    onFieldSubmitted: (String value)
                    {
                      print(value);
                    },
                    onChanged: (String value)
                    {
                      print(value);
                    },
                    validator: (value)
                    {
                      if(value!.isEmpty){
                        return "password must not be empty";
                      }
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(),
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                            isPassword ? Icons.visibility_off : Icons.visibility
                        ), onPressed: () { setState(() {
                        isPassword = !isPassword;
                      }); },
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: MyColors.greyColor,
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color:MyColors.fire,),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 50.0,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: StadiumBorder(),backgroundColor: MyColors.fire),
                      onPressed: ()
                      {
                        if(formKey.currentState!.validate()){
                          print(emailController.text);
                          print(passwordController.text);
                          // Navigator. push(context, MaterialPageRoute(builder: (BuildContext context){ return MessengerScreen(); }));


                        }

                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Don\'t have an account?'
                      ),
                      TextButton(onPressed: (){},
                        child: Text(
                          'Register Now!',style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
