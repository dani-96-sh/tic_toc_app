import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isTurnO = true;
  List<String> XorO = ['', '', '', '', '', '', '', '', ''];
  bool gameHasResult = false;
  int getScoreX = 0;
  int getScoreO = 0;
  int filledBoxes = 0;
  String WinnerTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                clearScore();
              },
              icon: Icon(Icons.refresh))
        ],
        elevation: 0,
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: Text(
          'Tic Toc App',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            getScore(),
            SizedBox(
              height: 20,
            ),
            getWinner(),
            SizedBox(
              height: 20,
            ),
            getGridviwe(),
            getTurn(),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget getScore() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Player O',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('$getScoreO',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Player X',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '$getScoreX',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget getWinner() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
          style:
              OutlinedButton.styleFrom(side: BorderSide(color: Colors.white)),
          onPressed: () {
            setState(() {
              gameHasResult = false;
            });
            clearGeme();
          },
          child: Text(
            WinnerTitle + ' Play Again',
            style: TextStyle(color: Colors.white, fontSize: 26),
          )),
    );
  }

  Widget getGridviwe() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 9,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => {tapped(index)},
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(
                  XorO[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: XorO[index] == "O" ? Colors.white : Colors.red,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: TextStyle(fontSize: 25, color: Colors.white),
    );
  }

  void tapped(index) {
    setState(() {
      if (gameHasResult) {
        return;
      }
      if (XorO[index] != '') {
        return;
      }

      if (isTurnO) {
        XorO[index] = 'O';
        filledBoxes = filledBoxes + 1;
      } else {
        XorO[index] = 'X';
        filledBoxes = filledBoxes + 1;
      }
      isTurnO = !isTurnO;

      checkWinner();
    });
  }

  void checkWinner() {
    if (XorO[0] == XorO[1] && XorO[0] == XorO[2] && XorO[0] != '') {
      gameResult(XorO[0], 'Winner is ' + XorO[0]);
      return;
    }
    if (XorO[3] == XorO[4] && XorO[3] == XorO[5] && XorO[3] != '') {
      gameResult(XorO[3], 'Winner is ' + XorO[3]);
      return;
    }
    if (XorO[6] == XorO[7] && XorO[6] == XorO[8] && XorO[6] != '') {
      gameResult(XorO[6], 'Winner is ' + XorO[6]);
      return;
    }
    if (XorO[0] == XorO[3] && XorO[0] == XorO[6] && XorO[0] != '') {
      gameResult(XorO[0], 'Winner is ' + XorO[0]);
      return;
    }
    if (XorO[1] == XorO[4] && XorO[1] == XorO[7] && XorO[1] != '') {
      gameResult(XorO[1], 'Winner is ' + XorO[1]);
      return;
    }
    if (XorO[2] == XorO[5] && XorO[2] == XorO[8] && XorO[2] != '') {
      gameResult(XorO[2], 'Winner is ' + XorO[2]);
      return;
    }
    if (XorO[0] == XorO[4] && XorO[0] == XorO[8] && XorO[0] != '') {
      gameResult(XorO[0], 'Winner is ' + XorO[0]);
      return;
    }
    if (XorO[2] == XorO[4] && XorO[2] == XorO[6] && XorO[2] != '') {
      gameResult(XorO[2], 'Winner is ' + XorO[2]);
      return;
    }
    if (filledBoxes == 9) {
      gameResult('', 'Drew');
    }
  }

  void gameResult(String Winner, String title) {
    setState(() {
      gameHasResult = true;
      if (Winner == 'X') {
        getScoreX = getScoreX + 1;
      } else if (Winner == 'O') {
        getScoreO = getScoreO + 1;
      } else {
        getScoreO = getScoreO + 1;
        getScoreX = getScoreX + 1;
      }

      WinnerTitle = title;
    });
  }

  void clearGeme() {
    setState(() {
      for (int i = 0; i < XorO.length; i++) {
        XorO[i] = '';
      }
    });
    filledBoxes = 0;
  }

  void clearScore() {
    setState(() {
      for (int i = 0; i < XorO.length; i++) {
        XorO[i] = '';
      }
      getScoreX = 0;
      getScoreO = 0;
    });
    filledBoxes = 0;
  }
}
