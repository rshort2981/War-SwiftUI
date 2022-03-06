//
//  CardView.swift
//  Spades
//
//  Created by Robert Short on 10/9/21.
//

import SwiftUI

struct CardView: View {
    
    @ObservedObject var cards: CardModel = CardModel()
    @State var fade = false
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .frame(width: 100, height: 100)
            
            Spacer()
            
            HStack {
                ForEach(cards.cardsResults, id: \.id) { card in
                    VStack {
                        Image(uiImage: card.image.load())
                            .resizable()
                            .frame(width: 150, height: 200)
                            .opacity(fade ? 1 : 0)
                            .onReceive(cards.$cardOne, perform: { card in
                                cards.royalCheck(cardString1: cards.cardsResults[0].value, cardString2: cards.cardsResults[1].value)
                            })
                            .onAppear {
                                //DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                                withAnimation(.easeInOut(duration: 1.5)) {
                                        self.fade = true
                                    }
                                //})
                            }
                    }
                }
            }
            
            Text(cards.tie)
            
            Text(cards.win)
            
            cards.playAgain()
            
            Spacer()
            
            Button(action: {
                cards.drawCards()
                cards.winCheck()
                self.fade.toggle()
            }, label: {
                Text("Deal")
                    .padding()
                    .background(Color(#colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)))
                    .foregroundColor(.white)
                    .font(.title2)
                    .cornerRadius(10)
            })
            
            HStack {
                Text("You: \(cards.score1)")
                Spacer()
                Text("\(cards.score2) :CPU")
            }
            .padding()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
