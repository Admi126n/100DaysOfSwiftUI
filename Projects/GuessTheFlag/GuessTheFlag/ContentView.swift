//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Adam Tokarski on 28/08/2023.
//

import SwiftUI

fileprivate struct FlagImage: View {
    private let imageName: String
    
    init(ofCountry imageName: String) {
        self.imageName = imageName
    }
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showScore = false
    @State private var gameEnded = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy",
                             "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score = 0
    @State private var questionsCounter = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("Guess the flag!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(ofCountry: countries[number])
                        }
                    }
                }
                .padding(20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Spacer()
                Spacer()
                
                Text("Your score: \(score)")
                    .foregroundColor(.white)
            }
        }
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue", action: askQuestion)
        }
        .alert("Finish!", isPresented: $gameEnded) {
            Button("Reset game", action: resetGame)
        } message: {
            Text("You answered corrently to \(score) of 8 questions")
        }
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            askQuestion()
        } else {
            scoreTitle = "Wrong! You tapped flag of \(countries[number])"
            score -= 1
            showScore = true
        }
    }
    
    private func askQuestion() {
        questionsCounter += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        if questionsCounter == 8 {
            gameEnded = true
        }
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
