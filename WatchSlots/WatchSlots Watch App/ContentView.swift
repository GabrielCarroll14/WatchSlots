//  ContentView.swift
//  WatchSlots Watch App
//
//  Created by Gabriel Carroll on 01/02/2024.
//

// Import swiftUI
import SwiftUI

// Settings page
struct Settings: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    // Discord QR
                    Image("discordqrcode")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    // Tell the user to join the discord server
                    Text("Join the Discord!")
                        .padding()
                    
                    // Description on how the game logic works
                    Text("Your score will be x3 by your betamount if you get all three symbols, x1 if you get two. If you get none, your betamount will be minused from your balance.")
                    
                }
            }
        }
    }
}

// Create the visual structure of the code
struct ContentView: View {
    
    // Create the different variebles
    @State private var balance = 100
    @State private var betAmount = 1
    
    let symbols = ["💎", "🍒", "🍀", "🔔", "🎰"]
    
    @State private var spin1 = ""
    @State private var spin2 = ""
    @State private var spin3 = ""
    
    // Spin function (this is called when the play button is presses)
    func spin() {
        
        // Randomise the symbols
        spin1 = symbols.randomElement()!
        spin2 = symbols.randomElement()!
        spin3 = symbols.randomElement()!
        
        // Check for a winning combination
        if spin1 == spin2 && spin2 == spin3 {
            // Update balance x three for a winning scenario
            balance = balance + betAmount * 3
        }
        
        // Check for a scemi win scenario
        else if spin1 == spin2 || spin2 == spin3 || spin1 == spin3 {
            // update the balance for a scemi winning scenario
            balance = balance + betAmount
        }
        
        // losing scenario
        else {
            // Update the balance for a losing sceanrio
            balance = balance - betAmount
        }
    }
    
    // Create the reset func so it resets all vars to default when the reset button is pressed
    func reset() {
        
        balance = 100
        betAmount = 1
        
        spin1 = ""
        spin2 = ""
        spin3 = ""
    }
    
    // Create the body of the code
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                    // Results of the spin
                    Text("\(spin1) \(spin2) \(spin3)")
                        .font(.largeTitle)
                    
                    // Label that displayes balance
                    Label("Balance: £\(balance)", systemImage: "")
                    
                    // The play button which calles the play function
                    Button("Play") {
                        spin()
                    }
                    .disabled(balance < 0) // This disables the play button when the users balance is at zero
                    .disabled(betAmount > balance) // Disable the button if the bet amount is over the balance
                    
                    // The reset button which calls the reset func
                    Button("Reset") {
                        reset()
                    }
                    
                    // Create the text field for the user to input a bet amount
                    TextField("Bet amount", value: $betAmount, formatter: NumberFormatter())
                    
                    // Settings page
                    NavigationLink(destination: Settings()) { Text("Settings") }
                    
                }
            }
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
