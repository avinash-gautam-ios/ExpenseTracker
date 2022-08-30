//
//  Theme.swift
//  ExpenseTracker
//
//  Created by Avinash on 23/08/22.
//

import UIKit


enum Theme {
    
    enum Image {
        static let circleFilled = UIImage(named: "circle_filled")!
        static let circleUnfilled = UIImage(named: "circle_unfilled")!
    }
    
    enum Font {
        static let headerFont = UIFont.boldSystemFont(ofSize: 18)
        static let titleFont = UIFont.boldSystemFont(ofSize: 16)
        static let descriptionFont = UIFont.systemFont(ofSize: 14)
    }
    
    enum Color {
        static let headerColor = UIColor.black
        static let titleColor = UIColor.black
        static let descriptionColor = UIColor.systemGray
        static let incomeAmountColor = UIColor.systemGreen
        static let expenseAmountColor = UIColor.systemRed
        static let buttonColor = UIColor.systemBlue
        static let clearButton = UIColor.clear
    }
    
    enum BackgroundColor {
        static let viewBackgroundColor = UIColor.systemBackground
        static let cellBackgroundColor = UIColor.tertiarySystemBackground
    }
    
    enum Padding {
        static let padding0: CGFloat = 0
        static let padding5: CGFloat = 5
        static let padding10: CGFloat = 10
        static let padding20: CGFloat = 20
    }
    
    enum CornerRadius {
        static let `default`: CGFloat = 4
    }
    
    enum Multiplier {
        static let heightWidthMultiplier: CGFloat = 0.65
    }
    
    enum IconSize {
        static let small: CGFloat = 10
        static let medium: CGFloat = 30
        static let large: CGFloat = 50
        static let xxl: CGFloat = 100
    }    
}
