import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'solution.dart';

class home extends StatelessWidget{

  TextEditingController problemController = TextEditingController();

  final String username;

  home({super.key, required this.username});

  final List<String> icons = ["assets/image/sleep_problem.png",
    "assets/image/exam.png",
    "assets/image/pain.png",
    "assets/image/eye_strain.png",
    "assets/image/messy_room.png",
    "assets/image/low_budget.png",
    "assets/image/fitness.png",
    "assets/image/feeling_low.png"];

   List<LinearGradient> gradients = [
    LinearGradient(colors: [Colors.blue.shade200, Colors.white54],begin: Alignment(-1, -0.5), end: Alignment(2, 0.5),),
    LinearGradient(colors: [Colors.red.shade200, Colors.white54],begin: Alignment(-1, -0.5), end: Alignment(2, 0.5),),
    LinearGradient(colors: [Colors.green.shade200, Colors.white54],begin: Alignment(-1, -0.5), end: Alignment(2, 0.5),),
    LinearGradient(colors: [Colors.brown.shade200, Colors.white54],begin: Alignment(-1, -0.5), end: Alignment(2, 0.5),),
    LinearGradient(colors: [Colors.pink.shade100, Colors.white54],begin: Alignment(-1, -0.5), end: Alignment(2, 0.5),),
    LinearGradient(colors: [Colors.teal.shade200, Colors.white54],begin: Alignment(-1, -0.5), end: Alignment(2, 0.5),),
    LinearGradient(colors: [Colors.purple.shade100, Colors.white54],begin: Alignment(-1, -0.5), end: Alignment(2, 0.5),),
    LinearGradient(colors: [Colors.orange.shade100, Colors.white54],begin: Alignment(-1, -0.5), end: Alignment(2, 0.5),),
  ];

  final List<String> problem = [
    "Sleep Issues",
    "Exam Stress",
    "Back Pain",
    "Eye Strain",
    "Messy Room",
    "Low Budget Setup",
    "Want Fitness",
    "Feeling Low"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade100,
              Colors.white38,
              //Colors.amberAccent.shade100,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hey ${username.split(" ")[0]} 😎", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black87),),
                Text("How can I make your day easier?"),
                SizedBox(height: 20,),
                TextField(
                  controller: problemController,
                  maxLines: 1,
                  maxLength: 50,
                  cursorColor: Colors.grey,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    String userProblem = value.trim();

                    if (userProblem.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter your problem"),backgroundColor: Colors.red.shade400,),
                      );
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            solution(problem: userProblem),
                      ),
                    );
                    problemController.clear(); // optional
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Describe your problem...",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ), //SearchBar
                SizedBox(height: 30,),
                Expanded(
                  child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.35,
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20),
                      itemCount: problem.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            //Navigator.pushNamed(context, "/so");
                            HapticFeedback.heavyImpact();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                solution(problem: problem[index]),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: gradients[index],
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [BoxShadow(color: Colors.black26,blurRadius: 5)]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(icons[index],width: 55,),
                                Text(problem[index])
                              ],
                            )
                          ),
                        );
                      },),
                ) //GridView
              ],
            ),
          ),
        ),
      ),
    );
  }
}