import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/screens/register/register_bloc.dart';
import 'package:flutter_shop/screens/register/register_states.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child:
          BlocConsumer<RegisterBloc, RegisterStates>(builder: (context, state) {
        return Scaffold(
            body: BuildCondition(
          condition:state is! RegisterLoadingState,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("images/sign_up.gif"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            label: Text("email"),
                            prefixIcon: Icon(Icons.email)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            label: Text("phone"),
                            prefixIcon: Icon(Icons.phone)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            label: Text("name"),
                            prefixIcon: Icon(Icons.person)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            label: Text("password"),
                            prefixIcon: Icon(Icons.lock)),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            RegisterBloc.get(context).Register(
                                name: nameController.text.toString(),
                                phone: phoneController.text.toString(),
                                password: passwordController.text.toString(),
                                email: emailController.text.toString());
                          },
                          child: Text("Register")),
                    )
                  ],
                ),
              ),
            );
          },
          fallback: (context) {
            return Center(child: CircularProgressIndicator());
          },
        ));
      }, listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.registerModel.status == false) {
            Fluttertoast.showToast(msg: "${state.registerModel.massege}");
          }
        }
      }),
    );
  }
}
