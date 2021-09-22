import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: myApp()));

class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  //final _formKey = GlobalKey<FormState>();
  int roundNum = 1;
  int energy = 3;
  int cards = 6;
  int deck = 24;
  int destroy = 0,
      gain = 0,
      steal = 0,
      zero = 0,
      one = 0,
      two = 0,
      discard = 0,
      draw = 0,
      cardsPlayed = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Axie Counter App",
              style: TextStyle(
                fontFamily: "Noto Sans JP",
                color: Colors.black,
              ),
            ),
            Transform(
              transform: Matrix4.rotationY(math.pi),
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(
                  Icons.replay,
                  size: 30,
                ),
                onPressed: () {
                  print("Reset Button pressed.");
                  setState(() {
                    roundNum = 1;
                    energy = 3;
                    cards = 6;
                    deck = 24;
                    one = two =
                        zero = gain = destroy = steal = draw = discard = 0;
                  });
                }
              ),
            )
          ],
        ),
        backgroundColor: Colors.orangeAccent[200],
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
            Row(
              //Round #
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
              ],
            ),
            Column(
              //2 columns
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 50),
                  child: Row(
                    //for Info
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                        child: Text(
                          "Energy: $energy",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Noto Sans JP",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                        child: Text(
                          "Cards: $cards",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Noto Sans JP",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                        child: Text(
                          "Deck: $deck",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Noto Sans JP",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 45, 20),
                      child: ElevatedButton(
                        onPressed: () {
                          skillDialog(context);
                        },
                        child: Text(
                          "Energy-related",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(double.infinity, MediaQuery.of(context).size.height / 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 45, 20),
                      child: ElevatedButton(
                        onPressed: () {
                          costDialog(context);
                        },
                        child: Text(
                          "Card costs",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(double.infinity, MediaQuery.of(context).size.height / 14),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(45, 20, 45, 20),
                      child: ElevatedButton(
                        onPressed: () {
                          drawDialog(context);
                        },
                        child: Text(
                          "Hand-related",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(double.infinity, MediaQuery.of(context).size.height / 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(flex: 1, child: Container()),
            ElevatedButton(
              onPressed: () {
                print("I set a trap card and end my turn!");
                setState(() {
                  roundNum += 1;
                  two *= 2;
                  cardsPlayed = zero + one + two;
                  energy = energy - (destroy + steal + one + two);
                  if (energy < 0) {
                    energy = 0;
                  }
                  energy += gain + 2;
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
                  deck -= (cardsPlayed + discard + draw + 3);
                  if (deck <= 0) {
                    deck += 24;
                  }
                  one =
                      two = zero = gain = destroy = steal = draw = discard = 0;
                });
              },
              child: Text(
                "End Turn",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(double.infinity, MediaQuery.of(context).size.height / 15),
              ),
            ),
            Divider(height: MediaQuery.of(context).size.height / 20),
            Container(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        "2021 \u00a9 Matthew Ang"
                    )
                )
            )
          ],
        ),
      ),
    );
  }

  costDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Cost Menu"),
              content: Container(
                height: 175,
                child: Column(
                  children: [
                    Row(
                      // - 0 Cost Cards +
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // minus button
                          width: MediaQuery.of(context).size.height / 22,
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
                            fontSize: 18,
                            fontFamily: "Noto Sans JP",
                          ),
                        ),
                        //updating $cardsPlayed whenever buttons are pressed
                        SizedBox(width: 6),
                        SizedBox(
                          //plus button
                          width: MediaQuery.of(context).size.height / 22,
                          child: FloatingActionButton(
                            onPressed: () {
                              print("+1 0 card.");
                              setState(() {
                                zero += 1;
                                if (zero > deck) {
                                  zero = deck;
                                }
                              });
                            },
                            child: Text("+"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // - 1 Cost Cards +
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // minus button
                          width: MediaQuery.of(context).size.height / 22,
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
                            fontSize: 18,
                            fontFamily: "Noto Sans JP",
                          ),
                        ),
                        //updating $cardsPlayed whenever buttons are pressed
                        SizedBox(width: 6),
                        SizedBox(
                          //plus button
                          width: MediaQuery.of(context).size.height / 22,
                          child: FloatingActionButton(
                            onPressed: () {
                              print("+1 1 card.");
                              setState(() {
                                one += 1;
                                if (one > deck) {
                                  one = deck;
                                }
                              });
                            },
                            child: Text("+"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // - 2 Cost Cards +
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // minus button
                          width: MediaQuery.of(context).size.height / 22,
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
                              print("+1 2 card.");
                              setState(() {
                                two += 1;
                                if (two > deck) {
                                  two = deck;
                                }
                              });
                            },
                            child: Text("+"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  // passing false
                  child: Text(
                    "Close",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true), // passing true
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((exit) {
      if (exit == null) {
        return;
      }
      if (!exit) {
        resetCards();
      }
    });
  }

  drawDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Hand Menu"),
              content: Container(
                height: 125,
                child: Column(
                  children: [
                    Row(
                      // - Draw Cards +
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // minus button
                          width: MediaQuery.of(context).size.height / 22,
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
                            fontSize: 20,
                            fontFamily: "Noto Sans JP",
                          ),
                        ),
                        //updating $cardsPlayed whenever buttons are pressed
                        SizedBox(width: 6),
                        SizedBox(
                          //plus button
                          width: MediaQuery.of(context).size.height / 22,
                          child: FloatingActionButton(
                            onPressed: () {
                              print("+1 Drawn Card.");
                              setState(() {
                                draw += 1;
                                if (draw > deck) {
                                  draw = deck;
                                }
                              });
                            },
                            child: Text("+"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // - Discard +
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // minus button
                          width: MediaQuery.of(context).size.height / 22,
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
                            fontSize: 20,
                            fontFamily: "Noto Sans JP",
                          ),
                        ),
                        //updating $cardsPlayed whenever buttons are pressed
                        SizedBox(width: 6),
                        SizedBox(
                          //plus button
                          width: MediaQuery.of(context).size.height / 22,
                          child: FloatingActionButton(
                            onPressed: () {
                              print("+1 Discarded Cards.");
                              setState(() {
                                discard += 1;
                                if (discard > deck) {
                                  discard = deck;
                                }
                              });
                            },
                            child: Text("+"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  // passing false
                  child: Text(
                    "Close",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true), // passing true
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((exit) {
      if (exit == null) {
        return;
      }
      if (!exit) {
        resetHand();
      }
    });
  }

  skillDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Skill Menu"),
              content: Container(
                height: 200,
                width: 275,
                child: Column(
                  children: [
                    Row(
                      // - Energy gained (Opponent) +
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.height / 22,
                          child: FloatingActionButton(
                            onPressed: () {
                              print("-");
                              setState(
                                () {
                                  gain -= 1;
                                  if (gain < 0) {
                                    gain = 0;
                                  }
                                },
                              );
                            },
                            child: Text('-'),
                          ),
                        ),
                        Text(
                          "Energy gained: $gain",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Noto Sans JP",
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.height / 22,
                          child: FloatingActionButton(
                            onPressed: () {
                              print('+');
                              setState(() {
                                gain += 1;
                                if (gain > 10) {
                                  gain = 10;
                                }
                              });
                            },
                            child: Text('+'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // - Energy Destroyed +
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.height / 22,
                          child: FloatingActionButton(
                            onPressed: () {
                              print("-");
                              setState(
                                () {
                                  destroy -= 1;
                                  if (destroy < 0) {
                                    destroy = 0;
                                  }
                                },
                              );
                            },
                            child: Text('-'),
                          ),
                        ),
                        Text(
                          "Energy destroyed: $destroy",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Noto Sans JP",
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.height / 22,
                          child: FloatingActionButton(
                            onPressed: () {
                              print('+');
                              setState(() {
                                destroy += 1;
                                if (destroy > 10) {
                                  destroy = 10;
                                }
                              });
                            },
                            child: Text('+'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      // - Energy Steal (You) +
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          // minus button
                          width: MediaQuery.of(context).size.height / 22,
                          child: FloatingActionButton(
                            onPressed: () {
                              print("-1 Steal.");
                              setState(() {
                                steal -= 1;
                                if (steal < 0) {
                                  steal = 0;
                                }
                              });
                            },
                            child: Text("-"),
                          ),
                        ),
                        Text(
                          "Energy steal (You): $steal",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Noto Sans JP",
                          ),
                        ),
                        //updating $steal whenever buttons are pressed
                        SizedBox(
                          //plus button
                          width: MediaQuery.of(context).size.height / 22,
                          child: FloatingActionButton(
                            onPressed: () {
                              print("+1 Steal.");
                              setState(() {
                                steal += 1;
                                if (steal > 10) {
                                  steal = 10;
                                }
                              });
                            },
                            child: Text("+"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  // passing false
                  child: Text(
                    "Close",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true), // passing true
                  child: Text(
                    "Save",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    ).then((exit) {
      if (exit == null) {
        return;
      }
      if (!exit) {
        resetEnergy();
      }
    });
  }

  resetEnergy() {
    destroy = 0;
    gain = 0;
    steal = 0;
  }

  resetCards() {
    zero = 0;
    one = 0;
    two = 0;
  }

  resetHand() {
    discard = 0;
    draw = 0;
  }
}
