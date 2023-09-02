//
//  ContentView.swift
//  RockPaperScissorsPuzzle
//
//  Created by Adam Tokarski on 02/09/2023.
//

import SwiftUI

struct AnswerButton: View {
    let title: String
    let action: (String) -> Void
    
    var body: some View {
        Button {
            action(title)
        } label: {
            Text(title)
                .font(.largeTitle)
        }
        .buttonStyle(.bordered)
    }
}

struct ContentView: View {
    @State private var appAnswer = 0
    @State private var playerShouldWin = true
    @State private var score = 0
    @State private var answeredQuestions = 0
    @State private var shouldShowEndAlert = false
    
    let answers = ["🪨", "📜", "✂️"]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .white, .gray],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 50) {
                Text("Your score: \(score) / \(answeredQuestions)")
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                
                Text("I've choosen \(answers[appAnswer]) and you should \(playerShouldWin ? "win" : "loose")")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                
                HStack {
                    Spacer()
                    ForEach(answers, id: \.self) {
                        AnswerButton(title: $0, action: chectAnswer)
                        Spacer()
                    }
                }
            }
            .padding()
            .alert("Game ended!", isPresented: $shouldShowEndAlert) {
                Button("Reset game") {
                    resetGame()
                }
            } message: {
                Text("You answered correctly to \(score) of 10 questions.")
            }
        }
    }
    
    private func chectAnswer(for answer: String) {
        var correct = false
        
        answeredQuestions += 1
        
        if playerShouldWin {
            if appAnswer + 1 < answers.count {
                correct = answer == answers[appAnswer + 1]
            } else {
                correct = answer == answers[0]
            }
        } else {
            if appAnswer - 1 < 0 {
                correct = answer == answers[2]
            } else {
                correct = answer == answers[appAnswer - 1]
            }
        }
        
        if correct {
            score += 1
        }
        
        showEndAlert()
        drawMoves()
    }
    
    private func showEndAlert() {
        if answeredQuestions == 10 {
            shouldShowEndAlert = true
        }
    }
    
    private func drawMoves() {
        appAnswer = Int.random(in: 0...2)
        playerShouldWin = Bool.random()
    }
    
    private func resetGame() {
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
