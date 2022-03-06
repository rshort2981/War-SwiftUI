//
//  Model.swift
//  Spades
//
//  Created by Robert Short on 10/9/21.
//

import Foundation

struct Welcome: Codable {
    let success: Bool?
    let deckID: String
    let cards: [Card]?
    let remaining: Int
    let shuffled: Bool?

    enum CodingKeys: String, CodingKey {
        case success
        case deckID = "deck_id"
        case cards, remaining, shuffled
    }
}

struct Card: Codable, Identifiable {
    let id = UUID()
    let code: String?
    let image: String
    let value, suit: String
}

