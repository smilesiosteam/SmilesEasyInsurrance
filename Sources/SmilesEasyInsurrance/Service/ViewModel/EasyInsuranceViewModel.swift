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
    private let sectionsUseCase: SectionsUseCaseProtocol
    private let faqsUseCase: FAQsUseCaseProtocol
    private var statusSubject = PassthroughSubject<State, Never>()
    var offersListingPublisher: AnyPublisher<State, Never> {
        statusSubject.eraseToAnyPublisher()
    }
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(insuranceUsecase: EasyInsuranceCaseProtocol, sectionsUseCase: SectionsUseCaseProtocol, faqsUseCase: FAQsUseCaseProtocol) {
        self.insuranceUseCase = insuranceUsecase
        self.sectionsUseCase = sectionsUseCase
        self.faqsUseCase = faqsUseCase
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
                }
            }.store(in: &cancellables)
    }
    
    func getFAQsDetails(faqId: Int) {
        faqsUseCase.getFAQsDetails(faqId: faqId, baseUrl: AppCommonMethods.serviceBaseUrl)
            .sink { [weak self] state in
                switch state {
                case .fetchFAQsDidSucceed(response: let response):
                    self?.statusSubject.send(.fetchFAQsDidSucceed(response: response))
                case .fetchFAQsDidFail(error: let error):
                    self?.statusSubject.send(.fetchFAQsDidFail(error: error.localizedDescription))
                }
            }
            .store(in: &cancellables)
    }
    
    func getSections(categoryId: Int) {
        self.sectionsUseCase.getSections(categoryID: categoryId)
            .sink { [weak self] state in
                switch state {
                case .sectionsDidSucceed(response: let response):
                    self?.statusSubject.send(.fetchSectionsDidSucceed(response: response))
                case .sectionsDidFail(error: let error):
                    self?.statusSubject.send(.fetchSectionsDidFail(error: error))
                }
            }
            .store(in: &cancellables)
        
    }
    
}

// MARK: - STATE -
extension EasyInsuranceViewModel {
    enum State {
        ///Insurance type Output
        case fetchInsuranceTypeDidSucceed(response: EasyInsuranceResponseModel)
        case fetchInsuranceTypeDidfail(error: String)
        ///Insurance type Output
        case fetchSectionsDidSucceed(response: GetSectionsResponseModel)
        case fetchSectionsDidFail(error: String)
        ///FAQs type Output
        case fetchFAQsDidSucceed(response: FAQsDetailsResponse)
        case fetchFAQsDidFail(error: String)
    }
}

