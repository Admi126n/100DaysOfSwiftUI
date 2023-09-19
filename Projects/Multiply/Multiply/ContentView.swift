//
//  ContentView.swift
//  Multiply
//
//  Created by Adam Tokarski on 19/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var questionsArrray: [Question] = []
    
    @FocusState private var keyboardFocused: Bool
    @State private var settingsActive = true
    @State private var showEndScreen = false
    
    @State private var numberOfQuestions = 5
    @State private var multiplycationRange = 2
    @State private var answeredQuestions = 0
    @State private var score = 0
    @State private var answer = 1
    
    var body: some View {
        Form {
            SettingsSection(
                $numberOfQuestions,
                $multiplycationRange,
                isActive: settingsActive) {
                    settingsActive = false
                    startGame()
                }
            
            GameSection(
                title: nextQuestion(),
                isAcive: settingsActive,
                answer: $answer,
                isFocused: $keyboardFocused)
        }
        .hideDoneToolbar({
            keyboardFocused = false
        }, {
            checkAnswer()
        })
        .alert("Game ended!", isPresented: $showEndScreen) {
            Button("Reset game") {
                score = 0
            }
        } message: {
            Text("You answered correctly to \(score) of \(numberOfQuestions) questions")
        }
    }
    
    private func nextQuestion() -> String {
        if questionsArrray.count == numberOfQuestions {
            return questionsArrray[answeredQuestions].question
        } else {
            return "1 x 1 ="
        }
    }
    
    private func startGame() {
        resetGame()
        fillQuestionsArray()
        settingsActive = false
    }
    
    private func fillQuestionsArray() {
        for _ in 0..<numberOfQuestions {
            questionsArrray.append(
                Question(num1: Int.random(in: 2...multiplycationRange),
                         num2: Int.random(in: 2...multiplycationRange)))
        }
    }
    
    private func resetGame() {
        answeredQuestions = 0
        questionsArrray = []
    }
    
    private func checkAnswer() {
        if questionsArrray[answeredQuestions].correctAnswer == answer {
            score += 1
        }
        
        answeredQuestions += 1
        
        if answeredQuestions == numberOfQuestions {
            resetGame()
            settingsActive = true
            showEndScreen = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - custom structs
fileprivate struct Question {
    let correctAnswer: Int
    let question: String
    
    init(num1: Int, num2: Int) {
        self.correctAnswer = num1 * num2
        self.question = "\(num1) x \(num2) ="
    }
}

fileprivate struct StartGameButton: View {
    let isActive: Bool
    let action: () -> ()
    let title: String
    
    init(isActive: Bool, title: String = "Start game", action: @escaping () -> Void) {
        self.isActive = isActive
        self.title = title
        self.action = action
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button("Start game") {
                withAnimation {
                    action()
                }
            }
            .buttonStyle(.borderedProminent)
            .padding(2)
            .disabled(!isActive)
            Spacer()
        }
    }
}

fileprivate struct GameSection: View {
    let title: String
    let isAcive: Bool
    let answer: Binding<Int>
    let isFocused: FocusState<Bool>.Binding
    
    var body: some View {
        Section("Game") {
            HStack {
                Text(title)
                    .animation(.default)
                
                TextField("Answer", value: answer, format: .number)
                    .keyboardType(.decimalPad)
                    .focused(isFocused)
                    .disabled(isAcive)
            }
        }
        .opacity(isAcive ? 0.5 : 1)
    }
}

fileprivate struct SettingsSection: View {
    private let noQuestionsRange = Array(stride(from: 5, to: 21, by: 5))
    var numberOfQuestions: Binding<Int>
    var multiplicationRange: Binding<Int>
    var isActive: Bool
    var buttonAction: () -> ()
    
    init(_ numberOfQuestions: Binding<Int>, _ multiplicationRange: Binding<Int>, isActive: Bool, buttonAction: @escaping () -> Void) {
        self.numberOfQuestions = numberOfQuestions
        self.multiplicationRange = multiplicationRange
        self.isActive = isActive
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        Section("Settings") {
            Picker("Number of questions", selection: numberOfQuestions) {
                ForEach(noQuestionsRange, id: \.self) { Text("\($0)") }
            }
            .pickerStyle(.menu)
            .disabled(!isActive)
            
            Stepper("Multiplication table up to \(multiplicationRange.wrappedValue)",
                    value: multiplicationRange, in: 3...10)
            .disabled(!isActive)
            
            StartGameButton(isActive: isActive, action: buttonAction)
        }
        .opacity(isActive ? 1 : 0.5)
    }
}

// MARK: - custom ViewModifiers
struct KeyboardToolbar: ViewModifier {
    let hideAction: () -> ()
    let doneAction: () -> ()
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Hide") {
                        hideAction()
                    }
                    Spacer()
                    Button("Done") {
                        doneAction()
                    }
                }
            }
    }
}

// MARK: - custom View extensions
extension View {
    func hideDoneToolbar(_ arg1: @escaping () -> (), _ arg2: @escaping () -> ()) -> some View {
        modifier(KeyboardToolbar(hideAction: arg1, doneAction: arg2))
    }
}
