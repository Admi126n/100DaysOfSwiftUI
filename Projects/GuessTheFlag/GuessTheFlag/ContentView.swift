//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Adam Tokarski on 28/08/2023.
//

import SwiftUI

fileprivate struct FlagImage: View {
    private let imageName: String
	private let imageLabel: String
    
	init(ofCountry imageName: String, _ label: String?) {
        self.imageName = imageName
		self.imageLabel = label ?? "Unknown flag"
    }
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
			.accessibilityLabel(imageLabel)
    }
}

struct ContentView: View {
    private let animationDuration = 0.5
    
    @State private var showScore = false
    @State private var gameEnded = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy",
                             "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
	
	let labels = [
			"Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
			"France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
			"Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
			"Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
			"Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
			"Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
			"Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
			"Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
			"Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
			"UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
			"US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
		]
    
    @State private var score = 0
    @State private var questionsCounter = 0
    
    @State private var animationAmount = 0.0
    @State private var tappedFlag = 0
    @State private var fade = false
    
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
                            tappedFlag = number
                            withAnimation(.easeIn(duration: animationDuration)) {
                                animationAmount += 360
                                flagTapped(number)
                            }
                            
                            
                        } label: {
                            FlagImage(ofCountry: countries[number], labels[countries[number]])
                        }
                        .rotation3DEffect(tappedFlag == number ? .degrees(animationAmount) : .degrees(0), axis: (x: 1, y: 0, z: 0))
                        .opacity(fade && tappedFlag != number ? 0.25 : 1)
                        .scaleEffect(fade && tappedFlag != number ? 0.3 : 1)
                        
                        
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
            Button("Continue") {
                withAnimation {
                    askQuestion()
                }
            }
        }
        .alert("Finish!", isPresented: $gameEnded) {
            Button("Reset game") {
                withAnimation {
                    askQuestion()
                }
            }
        } message: {
            Text("You answered corrently to \(score) of 8 questions")
        }
    }
    
    private func flagTapped(_ number: Int) {
        fade = true
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration * 2) {
                withAnimation {
                    askQuestion()
                }
                
            }
        } else {
            scoreTitle = "Wrong! You tapped flag of \(countries[number])"
            score -= 1
            showScore = true
        }
    }
    
    private func askQuestion() {
        fade = false
        
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
