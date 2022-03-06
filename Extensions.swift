//
//  Extensions.swift
//  Spades
//
//  Created by Robert Short on 10/9/21.
//

import SwiftUI


extension String {
    
    func load() -> UIImage {
        
        do {
            guard let url = URL(string: self) else { return UIImage() }
            let data: Data = try Data(contentsOf: url)
            return UIImage(data: data) ?? UIImage()
        } catch {
            //
        }
        
        return UIImage()
    }
}
