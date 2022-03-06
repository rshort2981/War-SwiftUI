//
//  ContentView.swift
//  Spades
//
//  Created by Robert Short on 10/4/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var cards:CardModel = CardModel()
    @State var goToView = false
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                Image("logo")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Spacer()
                
                ForEach(cards.welcome, id: \.deckID) { result in
                    Button(action: {
                        cards.getDeckId(id: result.deckID)
                        self.goToView.toggle()
                    }, label: {
                        Text("Start")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(15)
                    }).fullScreenCover(isPresented: $goToView) {
                        CardView(cards: cards)
                    }

                }
                
                Spacer()
            }
            .onAppear(perform: cards.getCards)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
