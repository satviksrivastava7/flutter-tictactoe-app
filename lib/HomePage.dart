import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetImage cross = AssetImage("images/cross.png");
  AssetImage circle = AssetImage("images/circle.png");
  AssetImage initial = AssetImage("images/initial.png");

  bool firstTurn = true;
  // the First Player will play cross, so while firstTurn is true it will play cross, else circle 
  String message = "";
  // 'late' represents that thevariable is not storing any value at initialization, but will at some later on point 
  late List<String> gameState;

  // initState --> the by default state when the game starts (there will be 9 grids with initial.png loaded)
  void initState() {
      super.initState();
        setState(() {
          this.gameState = [
            "empty", "empty", "empty",
            "empty", "empty", "empty",
            "empty", "empty", "empty"
          ];
        });
  }

  // resetGame --> will return to initState 
  resetGame() {
    setState(() {
      this.message = ""; 
      this.gameState = [
        "empty", "empty", "empty",
        "empty", "empty", "empty",
        "empty", "empty", "empty"
      ];
    });
  }

  // playGame --> the state where game is being played (the respective images will load based on the turn on the selected grid)
  playGame(int index) {
    if(this.gameState[index] == "empty") {
      setState(() {
        if(this.firstTurn) {
          this.gameState[index] = "cross";
        }
        else {
          this.gameState[index] = "circle";
        }  
        this.firstTurn = !this.firstTurn;
        this.checkWin();
      });
    }
  }

  // getImage --> will load images in the desired position (grids)
  AssetImage getImage(String value) {
    switch (value) {
      case ('empty'):
        return initial;
      case ('cross'):
        return cross;
      case ('circle'):
        return circle;
    }
    return initial;
  }  

  // checkWin --> check the winning condition for the game
  checkWin() {
    if((gameState[0] != "empty") && (gameState[0] == gameState[1]) && (gameState[1] == gameState[2])){
      setState(() {
        this.message = "${this.gameState[0]} wins!";
      });
    }
    else if((gameState[3] != "empty") && (gameState[3] == gameState[4]) && (gameState[4] == gameState[5])){
      setState(() {
        this.message = "${this.gameState[3]} wins!";
      });
    }
    else if((gameState[6] != "empty") && (gameState[6] == gameState[7]) && (gameState[7] == gameState[8])){
      setState(() {
        this.message = "${this.gameState[6]} wins!";
      });
    }
    else if((gameState[0] != "empty") && (gameState[0] == gameState[3]) && (gameState[3] == gameState[6])){
      setState(() {
        this.message = "${this.gameState[0]} wins!";
      });
    }
    else if((gameState[1] != "empty") && (gameState[1] == gameState[4]) && (gameState[4] == gameState[7])){
      setState(() {
        this.message = "${this.gameState[1]} wins!";
      });
    }
    else if((gameState[2] != "empty") && (gameState[2] == gameState[5]) && (gameState[5] == gameState[8])){
      setState(() {
        this.message = "${this.gameState[2]} wins!";
      });
    }
    else if((gameState[0] != "empty") && (gameState[0] == gameState[4]) && (gameState[4] == gameState[8])){
      setState(() {
        this.message = "${this.gameState[0]} wins!";
      });
    }
    else if((gameState[2] != "empty") && (gameState[2] == gameState[4]) && (gameState[4] == gameState[6])){
      setState(() {
        this.message = "${this.gameState[2]} wins!";
      });
    }
    else if(!gameState.contains("empty")){
      setState(() {
        this.message = "No one wins!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: this.gameState.length,
              itemBuilder: (context, i) => SizedBox(
                width: 100.0,
                height: 100.0,
                child: MaterialButton(
                  onPressed: () {
                    this.playGame(i);
                  },
                  child: Image(
                    image: this.getImage(this.gameState[i]),
                  )
                )
              )
            )
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              this.message,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              )
            )
          ),
          MaterialButton(
            color: Colors.green,
            minWidth: 300.0,
            height: 50.0,
            child: Text(
              "Reset Game",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              )
            ),
            onPressed: () {
              this.resetGame();
            }
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Made by Satvik7",
              style: TextStyle(fontSize: 18.0),
            )
          )
        ]
      )
    );
  }
}