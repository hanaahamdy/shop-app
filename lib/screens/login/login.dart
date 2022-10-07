import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/network/local.dart';
import 'package:flutter_shop/screens/const.dart';
import 'package:flutter_shop/screens/homeLayout/homeLayout.dart';
import 'package:flutter_shop/screens/login/login_bloc.dart';
import 'package:flutter_shop/screens/login/login_states.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocConsumer<LoginBloc, LoginStates>(
            listener: (context, state) => {
                  if (state is LoginSuccessState)
                    {
                      if (state.model.status)
                        {
                        token=state.model.data?.token,
                          LocalHelper.setData(key: "token", value: state.model.data?.token).then((value) {
                            print(state.model.data?.token);
                          }).then((value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomeLayout()),
                                  (route) => false);
                          }),
                        }

                      else
                        {
                          Fluttertoast.showToast(
                            msg: state.model.massege.toString(),
                            backgroundColor: Colors.red,
                            gravity: ToastGravity.BOTTOM,
                          )
                        }
                    }
                },
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(),
                body: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .07,
                            ),
                            TextFormField(
                              controller: emailController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "please enter your email address";
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.email),
                                  label: Text("Email"),
                                  hintText: "Enter your e-mail address"),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .03,
                            ),
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "please enter your password";
                                }
                              },
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  prefixIcon: Icon(Icons.lock),
                                  label: Text("password"),
                                  hintText: "Enter your password"),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .05,
                            ),
                            Container(
                              width: double.infinity,
                              child: MaterialButton(
                                color: Colors.blue,
                                textColor: Colors.white,
                                onPressed: () {
                                  LoginBloc.get(context).getLOginData(
                                      email: emailController.text,
                                      password: passwordController.text);
                                },
                                child: Text("Login"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
