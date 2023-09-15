//
//  StringExtension.swift
//  MarvelApp
//
//  Created by Tobi on 15/09/2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
