import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 50),
              Center(
                child: Container(
                    alignment: Alignment.center,
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(70)),
                    child: Image.asset(
                      "images/logo.png",
                      height: 40,
                      // fit: BoxFit.fill,
                    )),
              ),
              Container(height: 20),
              Text("Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              Container(height: 10),
              Text("Login To Continue Using The App",
                  style: TextStyle(color: Colors.grey)),
              Container(height: 20),
              Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Enter Your Email",
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 184, 184, 184))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              Container(height: 10),
              Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Container(height: 10),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Enter Your Password",
                    hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 184, 184, 184))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                alignment: Alignment.topRight,
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          MaterialButton(
            height: 40,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.orange,
            textColor: Colors.white,
            onPressed: () {},
            child: Text("Login"),
          ),
          Container(height: 20),

          MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.red[700],
              textColor: Colors.white,
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Login With Google  "),
                  Image.asset(
                    "images/4.png",
                    width: 20,
                  )
                ],
              )),
          Container(height: 20),
          // Text("Don't Have An Account ? Resister" , textAlign: TextAlign.center,)
          InkWell(
            onTap: (){
              
            },
            child: Center(
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: "Don't Have An Account ? ",
                ),
                TextSpan(
                  text: "Register",
                  style: TextStyle(color: Colors.orange , fontWeight: FontWeight.bold)
                ),
              ])),
            ),
          )
        ]),
      ),
    );
  }
}
