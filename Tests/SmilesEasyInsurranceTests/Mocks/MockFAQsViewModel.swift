//
//  File.swift
//  
//
//  Created by Ahmed Naguib on 08/03/2024.
//

import Foundation
import SmilesSharedServices
import Combine

class MockFAQsViewModel: FAQsViewModelProtocol {
    var getInsuranceDetail: Result<FAQsViewModel.Output, Never> = .success(.fetchFAQsDidFail(error: .badURL("sss")))
    
    
    func transform(input: AnyPublisher<FAQsViewModel.Input, Never>) -> AnyPublisher<FAQsViewModel.Output, Never> {
        Result.Publisher(getInsuranceDetail)
            .eraseToAnyPublisher()
        
    }
    
}
