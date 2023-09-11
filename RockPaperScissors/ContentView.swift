//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Zach Mommaerts on 9/7/23.
//

import SwiftUI

struct ContentView: View {
    
    enum Outcomes {
        case win, lose, draw
    }
    
    var options = ["🪨", "📃", "✂️"]
    @State private var round = 1
    @State private var playerScore = 0
    @State private var cpuScore = 0
    @State private var showingScore = false
    @State private var showingFinalScore = false
    @State private var resultsTitle = ""
    @State private var playerChoice = "🪨"
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    
    var outcome: Outcomes {
        guard playerChoice != options[computerChoice] else {
            return .draw
        }
        
        if (playerChoice == "🪨" && options[computerChoice] == "📃") {
            return .lose
        } else if (playerChoice == "📃" && options[computerChoice] == "✂️") {
            return .lose
        } else if (playerChoice == "✂️" && options[computerChoice] == "🪨") {
            return .lose
        } else {
            return .win
        }
    }
    
    var body: some View {
        ZStack{
            Color.blue
            VStack {
                Spacer()
                Text("R/P/S")
                    .font(.largeTitle)
                Text("Round \(round)")
                    .font(.title2)
                    .padding(.vertical)
                Section {
                    HStack{
                        Spacer()
                        Text("Player Score: \(playerScore)")
                            .font(.title3)
                        Spacer()
                        Text("CPU Score: \(cpuScore)")
                            .font(.title3)
                        Spacer()
                    }
                    .padding(.vertical)
                    Text("Your opponent has chosen:")
                    Text(options[computerChoice])
                        .font(.system(size: 200))
                        .padding(.vertical)
                    Text(shouldWin ? "Select the option to win" : "Select the option to lose")
                        .padding(.bottom)
                }
                HStack{
                    Spacer()
                    Button("🪨"){
                        handleButtonPress(emoji: "🪨")
                    }
                    .font(.system(size: 50))
        
                    Spacer()
                    
                    Button("📃"){
                        handleButtonPress(emoji: "📃")
                    }
                    .font(.system(size: 50))
                    
                    Spacer()
                    
                    Button("✂️"){
                        handleButtonPress(emoji: "✂️")
                    }
                    .font(.system(size: 50))
                    Spacer()
                }
                Spacer()
            }
        }
        .foregroundColor(.white)
        .ignoresSafeArea()
        .alert(resultsTitle, isPresented: $showingScore) {
            Button("Continue", action: nextRound)
        } message: {
            Text("Your score is \(playerScore)")
        }
        .alert(resultsTitle, isPresented: $showingFinalScore) {
            Button("Restart", action: restartGame)
        } message: {
            Text("Final score: \(playerScore)")
        }
    }
    func nextRound() {
        round += 1
        computerChoice = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func restartGame() {
        round = 1
        playerScore = 0
        cpuScore = 0
        shouldWin.toggle()
        computerChoice = Int.random(in: 0...2)
    }
    
    func handleButtonPress(emoji: String) {
        playerChoice = emoji
        
        if(outcome == .draw) {
            resultsTitle = "Draw"
        } else if ((outcome == .win && shouldWin) || outcome == .lose && !shouldWin) {
            resultsTitle = "Correct"
            playerScore += 1
        } else {
            resultsTitle = "Incorrect"
            cpuScore += 1
        }
        
        if round == 10 {
            showingFinalScore = true
            if playerScore > cpuScore {
                resultsTitle = "You win!"
            } else if playerScore == cpuScore {
                resultsTitle = "You tied!"
            } else {
                resultsTitle = "You Lose!"
            }
        } else {
            showingScore = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
