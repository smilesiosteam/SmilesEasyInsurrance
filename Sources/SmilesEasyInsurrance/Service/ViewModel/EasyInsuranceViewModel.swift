//
//  File.swift
//  
//
//  Created by Habib Rehman on 23/01/2024.
//

import Foundation
import Combine
import SmilesUtilities
import SmilesSharedServices
import NetworkingLayer

final class EasyInsuranceViewModel {
    
    // MARK: - Properties
    private let insuranceUseCase: EasyInsuranceCaseProtocol
    private var statusSubject = PassthroughSubject<State, Never>()
    var offersListingPublisher: AnyPublisher<State, Never> {
        statusSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(insuranceUsecase: EasyInsuranceCaseProtocol) {
        self.insuranceUseCase = insuranceUsecase
    }
    
}

//MARK: - SERVICES -
extension EasyInsuranceViewModel {
    
    func getInsuranceData(categoryId: Int) {
        insuranceUseCase.getInsuranceData(categoryId: categoryId)
            .sink { [weak self] state in
                switch state {
                case .fetchInsuranceTypeDidSucceed(let response):
                    self?.statusSubject.send(.fetchInsuranceTypeDidSucceed(response: response))
                case .fetchInsuranceTypeDidfail(let error):
                    self?.statusSubject.send(.fetchInsuranceTypeDidfail(error: error))
                default: break
                }
            }.store(in: &cancellables)
    }
    
    func getFAQsDetails(faqId: Int) {
        insuranceUseCase.getFAQs(faqsId: faqId)
            .sink { [weak self] state in
                switch state {
                case .fetchFAQsDidSucceed(let response):
                    self?.statusSubject.send(.fetchFAQsDidSucceed(response: response))
                case .fetchFAQsDidFail(let error):
                    self?.statusSubject.send(.fetchFAQsDidFail(error: error))
                default: break
                }
            }.store(in: &cancellables)
    }
    
}

// MARK: - STATE -
extension EasyInsuranceViewModel {
    enum State {
        ///Insurance type Output
        case fetchInsuranceTypeDidSucceed(response: EasyInsuranceResponseModel)
        case fetchInsuranceTypeDidfail(error: String)
        ///FAQs type Output
        case fetchFAQsDidSucceed(response: FAQsDetailsResponse)
        case fetchFAQsDidFail(error: String)
    }
}

