import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          height: 500,
          width: 420,
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("images/test.jpg"),
                    height: 200,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: loginController,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.lock),
                      labelText: "Username",
                      hintText: "Enter your username",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      //icon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.visibility),
                      labelText: "Password",
                      hintText: "Enter your password",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(18)),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        String username = loginController.text;
                        String password = passwordController.text;
                        if (username == 'admin' && password == 'admin') {
                          // Navigator.of(context).pop();
                          Navigator.pushNamed(context, '/chat');
                        }
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                    ),
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
