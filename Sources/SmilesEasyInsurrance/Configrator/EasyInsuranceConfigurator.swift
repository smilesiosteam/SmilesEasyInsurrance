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
    public var categoryId: Int
    
    public init(categoryId: Int) {
        self.categoryId = categoryId
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


public enum EasyInsuranceConfigurator {
    
    public static func getEasyInsuranceDetails(dependance: EasyInsuranceDependance,
                                            navigationDelegate: EasyInsuranceNavigationProtocol) -> EasyInsuranceVC {
        
        let viewModel = EasyInsuranceViewModel()
        let viewController = EasyInsuranceVC.create()
        viewController.viewModel = viewModel
        viewController.navigationdelegate = navigationDelegate
        return viewController
    }
    
    
    static var service: EasyInsuranceServiceHandler {
        return .init(repository: repository)
    }
    
    static var network: Requestable {
        NetworkingLayerRequestable(requestTimeOut: 60)
    }
    
    static var repository: EasyInsuranceServiceable {
        EasyInsuranceRepository(networkRequest: network)
    }
    
    
    
}
