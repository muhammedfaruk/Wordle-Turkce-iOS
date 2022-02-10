//
//  Dictionary+ext.swift
//  Wordle ios
//
//  Created by Muhammed Faruk Söğüt on 9.02.2022.
//

import Foundation

extension Dictionary where Value: Any {
    public func mergeOnto(target: [Key: Value]?) -> [Key: Value] {
        guard let target = target else { return self }
        return self.merging(target) { current, _ in current }
    }
}


//MARK: String extension
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

