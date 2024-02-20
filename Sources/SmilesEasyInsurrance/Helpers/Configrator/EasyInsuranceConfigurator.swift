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


struct EasyInsuranceConfigurator {
    
    enum ConfiguratorType {
        case easyInsuranceVC(dependance: EasyInsuranceDependance)
    }
    
    static func create(type: ConfiguratorType) -> UIViewController {
        switch type {
        case .easyInsuranceVC(let dependance):
            getEasyInsuranceDetails(dependance: dependance)
        }
    }
    
    private static func getEasyInsuranceDetails(dependance: EasyInsuranceDependance) -> EasyInsuranceVC {
        
        let insuranceUsecase = EasyInsuranceUseCase(services: service)
        let viewModel = EasyInsuranceViewModel(insuranceUsecase: insuranceUsecase)
        let viewController = EasyInsuranceVC(dependance: dependance, viewModel: viewModel)
        viewController.hidesBottomBarWhenPushed = true
        return viewController
        
    }
    
    
    static var service: EasyInsuranceServiceHandler {
        return .init(repository: repository)
    }
    
    private static var network: Requestable {
        NetworkingLayerRequestable(requestTimeOut: 60)
    }
    
    private static var repository: EasyInsuranceServiceable {
        EasyInsuranceRepository(networkRequest: network)
    }
    
    
    
}
