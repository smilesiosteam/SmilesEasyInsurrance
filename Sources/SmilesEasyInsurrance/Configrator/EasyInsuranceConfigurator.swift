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


public enum EasyInsuranceConfigurator {
    
    public static func getEasyInsuranceDetails(dependance: EasyInsuranceDependance,
                                            navigationDelegate: EasyInsuranceNavigationProtocol) -> EasyInsuranceVC {
        
        let viewModel = EasyInsuranceViewModel()
        let viewController = EasyInsuranceVC.create()
        viewController.viewModel = viewModel
//        viewController.delegate = navigationDelegate
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
