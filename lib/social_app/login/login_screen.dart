import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/constants/signOu.dart';
import 'package:social_app/social_app/layout/shop_layout.dart';
import 'package:social_app/social_app/login/cubit.dart';
import 'package:social_app/social_app/login/states.dart';
import 'package:social_app/social_app/register/register_screen.dart';
import 'package:social_app/social_app/shared_prefernces/cashe_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSucessStates) {
            if (state.ShopLoginModel.status) {
              Cashe_Helper.saveData(
                Key: 'token',
                Value: state.ShopLoginModel.data.token,
              ).then((value) => {
                token = state.ShopLoginModel.data.token,
                    Navigator.pushReplacement(
                  context,
                        MaterialPageRoute(builder: (context) => ShopLayout()))
                  }
                  );
            }
            else {
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
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.orange.shade300,
            resizeToAvoidBottomInset: false,
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
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
                              fontSize: 30,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
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
                              borderSide: BorderSide(color: Colors.white)
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            hintText: 'Email Address ',
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
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                  email: _emailController.text,
                                  password: _passwordController.text);
                            }
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
                                borderSide: BorderSide(color: Colors.white)
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                            ),
                            border: const OutlineInputBorder(),
                            hintText: 'Password ',
                            labelStyle: TextStyle(color:Colors.black,fontSize: 15),
                            prefixIcon: Icon(Icons.security),
                            suffixIcon: IconButton(
                              icon: Icon(ShopLoginCubit.get(context).sufix),
                              onPressed: () {
                                ShopLoginCubit.get(context).changePasswordVis();
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
                          obscureText:
                              ShopLoginCubit.get(context).passwordHidden,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingStates,
                            builder: (context) =>
                                Container(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                        email: _emailController.text,
                                        password: _passwordController.text);
                                  }
                                },
                                child: const Text('LOGIN '),
                              )),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have An Account ? ',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()));
                              },
                              child: const Text(
                                'Regstier Now',
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
              ),
            ),
          );
        },
      ),
    );
  }
}
