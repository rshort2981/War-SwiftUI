//
//  ViewModel.swift
//  Spades
//
//  Created by Robert Short on 10/9/21.
//

import Foundation
import SwiftUI

class CardModel: ObservableObject {

    @Published var welcome = [Welcome]()
    @Published var cardsResults = [Card]()
    
    @Published var deckId = ""
    
    @Published var cardOne: String = ""
    @Published var cardTwo: String = ""
    
    @Published var score1: Int = 0
    @Published var score2: Int = 0
    
    @Published var tie: String = ""
    
    @Published var count: Int  = 0
    @Published var win: String = ""
    
    func getCards() {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1") else { return }
        
        downloadData(fromURL: url) { (returnedData) in
            if let data =  returnedData {
                guard let decodedResponse = try? JSONDecoder().decode(Welcome.self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.welcome.append(decodedResponse)
                }
            } else {
                print("No data returned.")
            }
            
        }
    }
    
    func drawCards() {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/\(getDeckId(id: deckId))/draw/?count=2") else { return }
        
        downloadData(fromURL: url) { (returnedData) in
            if let data =  returnedData {
                guard let decodedResponse = try? JSONDecoder().decode(Welcome.self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.cardsResults = decodedResponse.cards ?? []
                }
            } else {
                print("No data returned.")
                //print(url)
            }
            
        }
        
        //print(url)
    }
    
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data.")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
        }.resume()
    }
    
    @discardableResult func getDeckId(id: String) -> String {
        self.deckId = id
        return self.deckId
    }
    
    func royalCheck(cardString1: String, cardString2: String) {
        var card1: Int
        var card2: Int
        
        switch cardString1 {
        case "2":
            card1 = 2
        case "3":
            card1 = 3
        case "4":
            card1 = 4
        case "5":
            card1 = 5
        case "6":
            card1 = 6
        case "7":
            card1 = 7
        case "8":
            card1 = 8
        case "9":
            card1 = 9
        case "10":
            card1 = 10
        case "JACK":
            card1 = 11
        case "QUEEN":
            card1 = 12
        case "KING":
            card1 = 13
        case "ACE":
            card1 = 14
        default:
            card1 = 0
        }
        
        switch cardString2 {
        case "2":
            card2 = 2
        case "3":
            card2 = 3
        case "4":
            card2 = 4
        case "5":
            card2 = 5
        case "6":
            card2 = 6
        case "7":
            card2 = 7
        case "8":
            card2 = 8
        case "9":
            card2 = 9
        case "10":
            card2 = 10
        case "JACK":
            card2 = 11
        case "QUEEN":
            card2 = 12
        case "KING":
            card2 = 13
        case "ACE":
            card2 = 14
        default:
            card2 = 0
        }
        
        if card1 > card2 {
            self.score1 += 1
        } else if card1 < card2 {
            self.score2 += 1
        }
        
        if card1 == card2 {
            self.tie = "TIE"
        } else {
            self.tie = ""
        }
    }
    
    func winCheck() {
        self.count += 1
        
        if self.count == 27 && self.score1 > self.score2 {
            self.win = "You Win"
        } else if self.count == 27 && self.score1 < self.score2 {
            self.win = "CPU Wins"
        } else if self.count == 27 && self.score1 == self.score2 {
            self.win = "Tied."
        } else {
            self.win = ""
        }
    }
    
    
    func playAgain() -> some View {
        if self.count == 27 {
            return Button(action: {
                self.cardsResults.removeAll()
                self.welcome.removeAll()
                self.getCards()
                self.score1 = 0
                self.score2 = 0
                self.count = 0
                self.win = ""
                

                for result in self.welcome {
                    self.getDeckId(id: result.deckID)
                }

                
            }, label: {
                Text("Play Again?")
            })
        }
        
        return Button(action: {
            //
        }, label: {
            Text("")
        })
    }

}
