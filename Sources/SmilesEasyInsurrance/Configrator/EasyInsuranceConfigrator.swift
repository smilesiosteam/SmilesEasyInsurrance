//
//  File.swift
//  
//
//  Created by Habib Rehman on 22/01/2024.
//

import Foundation
import UIKit
import Combine
import NetworkingLayer
import SmilesUtilities

public struct EasyInsuranceDependance {
    public var title: String
    public var image: String
    
    
    public init(title: String, image: String) {
        self.title = title
        self.image = image
    }
}


public struct EasyInsuranceFAQsDependance {
    public var question: String
    public var answer: String
    
    
    public init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
}
