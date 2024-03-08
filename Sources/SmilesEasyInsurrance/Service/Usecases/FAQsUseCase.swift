//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 20/02/2024.
//

import Foundation
import Combine
import NetworkingLayer
import SmilesUtilities
import SmilesSharedServices

protocol FAQsUseCaseProtocol {
    func getFAQsDetails(faqId: Int, baseUrl: String) -> Future<FAQsUseCase.State, Never>
}

final class FAQsUseCase: FAQsUseCaseProtocol {
    
    public var fAQsUseCaseInput: PassthroughSubject<FAQsViewModel.Input, Never> = .init()
    private let fAQsViewModel: FAQsViewModelProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(fAQsViewModel: FAQsViewModelProtocol = FAQsViewModel()) {
        self.fAQsViewModel = fAQsViewModel
    }
    
    func getFAQsDetails(faqId: Int, baseUrl: String) -> Future<FAQsUseCase.State, Never> {
        return Future<State, Never> { [weak self] promise in
            guard let self else {
                return
            }
            fAQsUseCaseInput = PassthroughSubject<FAQsViewModel.Input, Never>()
            let output = fAQsViewModel.transform(input: fAQsUseCaseInput.eraseToAnyPublisher())
            self.fAQsUseCaseInput.send(.getFAQsDetails(faqId: faqId, baseUrl: baseUrl))
            output.sink { event in
                switch event {
                case .fetchFAQsDidSucceed(response: let response):
                    debugPrint(response)
                    promise(.success(.fetchFAQsDidSucceed(response: response)))
                case .fetchFAQsDidFail(error: let error):
                    print(error.localizedDescription)
                    promise(.success(.fetchFAQsDidFail(error: error)))
                }
            }.store(in: &cancellables)
        }
        
    }
    
}


extension FAQsUseCase {
    
    enum State: Equatable {
        // Implement the Equatable conformance
        static func == (lhs: FAQsUseCase.State, rhs: FAQsUseCase.State) -> Bool {
            switch (lhs, rhs) {
            case let (.fetchFAQsDidSucceed(lhsResponse), .fetchFAQsDidSucceed(rhsResponse)):
                // Compare the associated values of fetchFAQsDidSucceed case
                return lhsResponse == rhsResponse
            case let (.fetchFAQsDidFail(lhsError), .fetchFAQsDidFail(rhsError)):
                // Compare the associated values of fetchFAQsDidFail case
                return lhsError.localizedDescription == rhsError.localizedDescription
            default:
                // If the cases are different, enums are not equal
                return false
            }
        }
        
        case fetchFAQsDidSucceed(response: FAQsDetailsResponse)
        case fetchFAQsDidFail(error: Error)
    }
}
