import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(myApp());

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  int roundNum = 1;
  int energy = 3;
  int cards = 6;
  int destroy = 0,
      success_steal = 0,
      failed_steal = 0,
      zero = 0,
      one = 0,
      two = 0,
      discard = 0,
      draw = 0,
      cardsPlayed = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Axie Infinity Enemy Counter App",
            style: TextStyle(
              fontFamily: "Noto Sans JP",
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.orangeAccent[200],
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Column(
            children: [
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
                  child: Container(
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.2)))),
              Expanded(
                flex: 1,
                child: Row(
                  //Round # and Reset button
                  children: [
                    Expanded(
                      child: Text(
                        "Round $roundNum",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Noto Sans JP",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: () {
                          print("Reset Button pressed.");
                          setState(() {
                            roundNum = 1;
                            energy = 3;
                            cards = 6;
                            one = two =
                                zero = destroy = failed_steal = success_steal = draw = discard = 0;
                          });
                        },
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            fontSize: 15
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 12,
                child: Row(
                  //2 columns
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        //for Energy
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Energy: $energy",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Noto Sans JP",
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              // - Energy Destroy +
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // minus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("-1 Destroy.");
                                      setState(() {
                                        destroy -= 1;
                                        if (destroy < 0) {
                                          destroy = 0;
                                        }
                                      });
                                    },
                                    child: Text("-"),
                                  ),
                                ),
                                SizedBox(width: 7),
                                Text(
                                  "Destroy: $destroy",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Noto Sans JP",
                                  ),
                                ),
                                //updating $destroy whenever buttons are pressed
                                SizedBox(width: 7),
                                SizedBox(
                                  //plus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("+1 Destroy.");
                                      setState(() {
                                        destroy += 1;
                                      });
                                    },
                                    child: Text("+"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              // - Energy Stolen +
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // minus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("-1 Steal.");
                                      setState(() {
                                        failed_steal -= 1;
                                        if (failed_steal < 0) {
                                          failed_steal = 0;
                                        }
                                      });
                                    },
                                    child: Text("-"),
                                  ),
                                ),
                                SizedBox(width: 7),
                                Text(
                                  "Failed Steal: $failed_steal",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Noto Sans JP",
                                  ),
                                ),
                                //updating $steal whenever buttons are pressed
                                SizedBox(width: 7),
                                SizedBox(
                                  //plus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("+1 Steal.");
                                      setState(() {
                                        failed_steal += 1;
                                      });
                                    },
                                    child: Text("+"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              // - 1 Cost Cards +
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // minus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("-1 1 card.");
                                      setState(() {
                                        success_steal -= 1;
                                        if (success_steal < 0) {
                                          success_steal = 0;
                                        }
                                      });
                                    },
                                    child: Text("-"),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Successful Steal: $success_steal",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Noto Sans JP",
                                  ),
                                ),
                                //updating $cardsPlayed whenever buttons are pressed
                                SizedBox(width: 6),
                                SizedBox(
                                  //plus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("+1 1 card.");
                                      setState(() {
                                        success_steal += 1;
                                      });
                                    },
                                    child: Text("+"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        //for Cards
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Cards: $cards",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Noto Sans JP",
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              // - 0 Cost Cards +
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // minus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("-1 0 card.");
                                      setState(() {
                                        zero -= 1;
                                        if (zero < 0) {
                                          zero = 0;
                                        }
                                      });
                                    },
                                    child: Text("-"),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "0 Cost Cards: $zero",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Noto Sans JP",
                                  ),
                                ),
                                //updating $cardsPlayed whenever buttons are pressed
                                SizedBox(width: 6),
                                SizedBox(
                                  //plus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("+1 0 card.");
                                      setState(() {
                                        zero += 1;
                                      });
                                    },
                                    child: Text("+"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              // - 1 Cost Cards +
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // minus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("-1 1 card.");
                                      setState(() {
                                        one -= 1;
                                        if (one < 0) {
                                          one = 0;
                                        }
                                      });
                                    },
                                    child: Text("-"),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "1 Cost Cards: $one",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Noto Sans JP",
                                  ),
                                ),
                                //updating $cardsPlayed whenever buttons are pressed
                                SizedBox(width: 6),
                                SizedBox(
                                  //plus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("+1 1 card.");
                                      setState(() {
                                        one += 1;
                                      });
                                    },
                                    child: Text("+"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              // - 2 Cost Cards +
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // minus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("-1 2 card.");
                                      setState(() {
                                        two -= 1;
                                        if (two < 0) {
                                          two = 0;
                                        }
                                      });
                                    },
                                    child: Text("-"),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "2 Cost Cards: $two",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Noto Sans JP",
                                  ),
                                ),
                                //updating $cardsPlayed whenever buttons are pressed
                                SizedBox(width: 6),
                                SizedBox(
                                  //plus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("+1 2 card.");
                                      setState(() {
                                        two += 1;
                                      });
                                    },
                                    child: Text("+"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              // - Draw Cards +
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // minus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("-1 Drawn Card.");
                                      setState(() {
                                        draw -= 1;
                                        if (draw < 0) {
                                          draw = 0;
                                        }
                                      });
                                    },
                                    child: Text("-"),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Draw: $draw",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Noto Sans JP",
                                  ),
                                ),
                                //updating $cardsPlayed whenever buttons are pressed
                                SizedBox(width: 6),
                                SizedBox(
                                  //plus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("+1 Drawn Card.");
                                      setState(() {
                                        draw += 1;
                                      });
                                    },
                                    child: Text("+"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              // - 2 Cost Cards +
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // minus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("-1 Discarded Cards.");
                                      setState(() {
                                        discard -= 1;
                                        if (discard < 0) {
                                          discard = 0;
                                        }
                                      });
                                    },
                                    child: Text("-"),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text(
                                  "Discard: $discard",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Noto Sans JP",
                                  ),
                                ),
                                //updating $cardsPlayed whenever buttons are pressed
                                SizedBox(width: 6),
                                SizedBox(
                                  //plus button
                                  width: 30,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      print("+1 Discarded Cards.");
                                      setState(() {
                                        discard += 1;
                                      });
                                    },
                                    child: Text("+"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 2,
                child: Container(
                  child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          print("I set a trap card and end my turn!");
                          setState(() {
                            roundNum += 1;
                            two *= 2;
                            cardsPlayed = zero + one + two + success_steal + failed_steal;
                            energy = energy - (destroy + failed_steal + one + two);
                            if (energy < 0) {
                              energy = 0;
                            }
                            energy += 2;
                            if (energy > 10) {
                              energy = 10;
                            }
                            cards = cards - (cardsPlayed + discard);
                            if (cards < 0) {
                              cards = 0;
                            }
                            cards += draw + 3;
                            if (cards > 9) {
                              cards = 9;
                            }
                            one = two = zero = destroy = failed_steal = success_steal = draw = discard = 0;
                          });
                        },
                        child: Text(
                          "End Turn",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Noto Sans JP",
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
