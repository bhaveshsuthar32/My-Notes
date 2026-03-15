// import 'package:flutter/material.dart';
// import 'package:my_notebook/user/components/header.dart';

// class Regitster extends StatefulWidget {
//   const Regitster({super.key});

//   @override
//   State<Regitster> createState() => _RegitsterState();
// }

// class _RegitsterState extends State<Regitster> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
          
//           children: [
//             Center(

//             child: Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s"),
//             ),

//             Text("Regiter Now", style: TextStyle(color:Colors.black, fontSize: 28, fontFamily: "poppins" , ),),
//             SizedBox(height: 20,),

//             Text("Username", style: TextStyle(color : Colors.blue, fontSize: 20),),

//             TextFormField(
//               decoration: InputDecoration(
//                 // labelText: "Username",
//                 hintText: "Enter your username",
//                 border:OutlineInputBorder(),
//                 labelStyle: TextStyle(
//                   color: Colors.black54,
//                   fontSize: 14
//                 )
//               ),
//             )
            
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class Regitster extends StatefulWidget {
  const Regitster({super.key});

  @override
  State<Regitster> createState() => _RegitsterState();
}

class _RegitsterState extends State<Regitster> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// 🔹 Logo
              Center(
                child: Image.network(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUcRukhIeQOYXoLvcgWi1NJDhXdEBlwdypuA&s",
                  height: 120,
                ),
              ),

              const SizedBox(height: 20),

              /// 🔹 Title
              Text(
                "Register Now",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              /// 🔹 Username label
              Text(
                "Username",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontFamily: "Poppins",
                ),
              ),

              const SizedBox(height: 6),

              /// 🔹 Username field
              TextFormField(
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: "Enter your username",
                  hintStyle: TextStyle(color: Colors.grey),

                  filled: true,
                  fillColor: Colors.grey.shade100,

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 1.5,
                    ),
                  ),

                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
