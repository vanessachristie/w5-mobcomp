//
//  ContentView.swift
//  W5_FlagAseanGuess
//
//  Created by MacBook Pro on 14/10/23.
//wddw

import SwiftUI

struct ContentView: View {
    @State private var asean: [String] = ["Indonesia", "Singapore", "Malaysia", "Laos", "Philipines", "Cambodia", "Myanmar", "Thailand", "Brunei", "Vietnam"]
    
    @State private var currentRound = 0
    @State private var correctGuesses = 0
    @State private var wrongGuesses = 0
    @State private var showAlert = false
    private let gradient = Gradient(colors: [Color(red: 230/255, green: 168/255, blue: 215/255), Color(red: 173/255, green: 216/255, blue: 230/255)])
    var body: some View {
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
                           .ignoresSafeArea()
            
            VStack {
                Text("Pilih Bendera dari Negara: ")
                    .foregroundStyle(.black)
                
                if currentRound < asean.count {
                    Text(asean[currentRound])
                        .foregroundStyle(.black)
                    
                    HStack {
                        Spacer()
                        VStack {
                            ForEach(0..<5) { number in
                                Button(action: {
                                    flagButtonTapped(asean[number])
                                }) {
                                    Image(asean[number])
                                        .resizable()
                                        .frame(width: 105, height: 65)
                                }
                            }
                        }
                        Spacer()
                        VStack {
                            ForEach(5..<10) { number in
                                Button(action: {
                                    flagButtonTapped(asean[number])
                                }) {
                                    Image(asean[number])
                                        .resizable()
                                        .frame(width: 105, height: 65)
                                }
                            }
                        }
                        Spacer()
                    }
                } else {
                    Button(action: {
                        startNewGame()
                    }) {
                        Text("Play Again")
                    }
                    .padding()
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Game Over"),
                  message: Text("Correct Guesses: \(correctGuesses)\nWrong Guesses: \(wrongGuesses)"),
                  dismissButton: .default(Text("OK")) {
                  
                  })
        }
        .onAppear {
            // Shuffle the ASEAN array for the first round
            asean.shuffle()
        }
    }
    
    private func flagButtonTapped(_ selectedCountry: String) {
        if currentRound < asean.count {
            if selectedCountry == asean[currentRound] {
                correctGuesses += 1
            } else {
                wrongGuesses += 1
            }
            
            currentRound += 1
            
            if currentRound >= asean.count {
                showAlert = true
            }
        }
    }
    
    private func startNewGame() {
        currentRound = 0
        correctGuesses = 0
        wrongGuesses = 0
        showAlert = false
        asean.shuffle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
