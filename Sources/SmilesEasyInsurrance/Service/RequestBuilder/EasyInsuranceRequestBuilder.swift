//
//  File.swift
//  
//
//  Created by Habib Rehman on 22/01/2024.
//

import Foundation
import NetworkingLayer
import SmilesUtilities

// if you wish you can have multiple services like this in a project
enum EasyInsuranceRequestBuilder {
    // organise all the end points here for clarity
    
    case getInsuranceDetail(request: EasyInsuranceRequestModel)
    
    // gave a default timeout but can be different for each.
    var requestTimeOut: Int {
        return 20
    }
    
    //specify the type of HTTP request
    var httpMethod: SmilesHTTPMethod {
        switch self {
        case .getInsuranceDetail:
            return .POST
        }
    }
    
    // compose the NetworkRequest
    func createRequest(endPoint: EasyInsuranceEndpoints) -> NetworkRequest {
        var headers: [String: String] = [:]

        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        headers["CUSTOM_HEADER"] = "pre_prod"
        
        return NetworkRequest(url: getURL(from: AppCommonMethods.serviceBaseUrl, for: endPoint), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }
    
    // encodable request body for POST
    var requestBody: Encodable? {
        switch self {
        case .getInsuranceDetail(let request):
            return request
        }
    }
    
    // compose urls for each request
    func getURL(from baseUrl: String, for endPoint: EasyInsuranceEndpoints) -> String {
        let endPoint = endPoint.url
        switch self {
        case .getInsuranceDetail:
            return "\(baseUrl)\(endPoint)"
        }
    }
}

