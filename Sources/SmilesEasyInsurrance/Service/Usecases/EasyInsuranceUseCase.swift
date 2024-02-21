//
//  File.swift
//  
//
//  Created by Abdul Rehman Amjad on 20/02/2024.
//

import Foundation
import Combine
import SmilesSharedServices
import SmilesUtilities

protocol EasyInsuranceCaseProtocol {
    func getInsuranceData(categoryId: Int) -> AnyPublisher<EasyInsuranceUseCase.State, Never>
}

final class EasyInsuranceUseCase: EasyInsuranceCaseProtocol {
    
    private let services: EasyInsuranceServiceHandlerProtocol
    private var cancellables = Set<AnyCancellable>()
    private let faqsViewModel = FAQsViewModel()
    private var faqsUseCaseInput: PassthroughSubject<FAQsViewModel.Input, Never> = .init()
    
    init(services: EasyInsuranceServiceHandlerProtocol) {
        self.services = services
    }
    
    func getInsuranceData(categoryId: Int) -> AnyPublisher<State, Never> {
        
        return Future<State, Never> { [weak self] promise in
            guard let self else { return }
            services.getInsuranceDetail(categoryId: categoryId)
                .sink { completion in
                    if case .failure(let error) = completion {
                        promise(.success(.fetchInsuranceTypeDidfail(error: error.localizedDescription)))
                    }
                } receiveValue: { response in
                    promise(.success(.fetchInsuranceTypeDidSucceed(response: response)))
                }
                .store(in: &cancellables)
            
        }
        .eraseToAnyPublisher()
        
    }
    
}

// MARK: - STATE -
extension EasyInsuranceUseCase {
    enum State {
        case fetchInsuranceTypeDidSucceed(response: EasyInsuranceResponseModel)
        case fetchInsuranceTypeDidfail(error: String)
    }
}
