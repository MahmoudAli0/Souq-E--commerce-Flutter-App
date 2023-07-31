import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/constants/signOu.dart';
import 'package:social_app/social_app/login/cubit.dart';
import 'package:social_app/social_app/login/login_screen.dart';
import 'package:social_app/social_app/register/cubit/cubit.dart';
import 'package:social_app/social_app/register/cubit/states.dart';
import 'package:social_app/social_app/shared_prefernces/cashe_helper.dart';
class RegisterScreen extends StatelessWidget {

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _emailController= TextEditingController();
    var _passwordController= TextEditingController();
    var _phoneController= TextEditingController();
    var _nameController= TextEditingController();
    var _confirmPasswordController= TextEditingController();
    var formKey = GlobalKey<FormState>();

    return  BlocProvider(create: (BuildContext context) =>ShopRegisteCubit() ,
      child: BlocConsumer<ShopRegisteCubit,ShopRegisterStates>(
        listener: (context,state){
          if (state is ShopRegisterSucessStates) {
            if (state.ShopLoginModel.status) {
              Cashe_Helper.saveData(
                Key: 'token',
                Value: state.ShopLoginModel.data.token,
              ).then((value) => {
                token = state.ShopLoginModel.data.token,

                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ShopLoginScreen()))
              }
              );
            } else {
              print(state.ShopLoginModel.message);
              Fluttertoast.showToast(
                  msg: state.ShopLoginModel.message.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16,
                  gravity: ToastGravity.BOTTOM);
            }
          }

        },
        builder: (context,state){
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.orange.shade300,
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: AssetImage('images/appLogo.png'),width: 100,),
                    Text(
                      'SOUQ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.black),
                    ),
                    SizedBox(height: 40,),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      decoration:  InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: ' User Name ',
                        labelStyle: TextStyle(color:Colors.black,fontSize: 15),
                        prefixIcon: Icon(Icons.person),

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name Must Not be Empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      decoration:  InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: 'Phone  ',
                        labelStyle: TextStyle(color:Colors.black,fontSize: 15),
                        prefixIcon: Icon(Icons.phone),

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone Must Not be Empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: Colors.black,
                      decoration:  InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: 'Emaill Address  ',
                        labelStyle: TextStyle(color:Colors.black,fontSize: 15),
                        prefixIcon: Icon(Icons.email),

                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email Must Not be Empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _passwordController,
                      onFieldSubmitted: (value) {

                      },
                      keyboardType: TextInputType.visiblePassword,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        border: const OutlineInputBorder(),
                        hintText: 'Password ',
                        labelStyle: TextStyle(color:Colors.black,fontSize: 15),
                        prefixIcon: Icon(Icons.security),
                        suffixIcon: IconButton(
                          icon:Icon(ShopRegisteCubit.get(context).sufix),
                          onPressed: () {
                            ShopRegisteCubit.get(context).changePasswordVis();
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password Must Not be Empty';
                        } else {
                          return null;
                        }
                      },
                      obscureText:ShopRegisteCubit.get(context).passwordHidden,
                    ),
                    SizedBox(height: 40,),
                    ConditionalBuilder(
                      condition: state is! ShopRegisterLoadingStates,
                      builder: (context) =>
                          Container(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisteCubit.get(context).userRegister(email: _emailController.text, password: _passwordController.text, name: _nameController.text, phone: _phoneController.text);
                                  }
                                },
                                child: const Text('REGISTER '),
                              )),
                      fallback: (context) =>
                      const Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already An Account ? ',
                          style: TextStyle(fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ShopLoginScreen()));
                          },
                          child: const Text(
                            'Login Now',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.white,fontStyle: FontStyle.italic),
                          ),
                        ),
                      ],
                    )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
