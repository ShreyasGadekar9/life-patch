import 'package:flutter/material.dart';
import 'gemini_service.dart';

class solution extends StatefulWidget {
  final String problem;

  const solution({super.key, required this.problem});

  @override
  State<solution> createState() => _solutionState();
}

class _solutionState extends State<solution> {
  List<dynamic> products = [];
  String solution = "Loading...";
  final GeminiService gemini = GeminiService();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      String result =
      await gemini.getSolution(widget.problem);
      var productData = await gemini.getProducts();

      print("Gemini Result: $result");

      setState(() {
        solution = result;
        products = productData;
      });
    } catch (e) {
      print("Error: $e");

      setState(() {
        solution = "Something went wrong.\nCheck API key.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text(widget.problem),
      ),

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
        child: Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(255, 255, 255, 0.9),
                            Color.fromRGBO(220, 235, 255, 0.8),
                            Color.fromRGBO(255, 255, 255, 0.9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        solution,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ), //Solution
                  SizedBox(height: 20,),
                  Text("Recommended Products 💎",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                  SizedBox(height: 10,),
                  if (products.isNotEmpty)
                    Column(
                      children: products.take(4).map((product) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 15),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                          ),
                          child: Row(
                            children: [
                              Image.network(
                                product["thumbnail"],
                                width: 70,
                                height: 70,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product["title"],
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "₹ ${product["price"]}",
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}