//
//  CovidDataService.swift
//  Covid Watch
//
//  Created by Abraham Estrada on 4/20/21.
//

import Foundation
import SwiftyJSON

struct CovidDataService {
    
    private static let covidURL = "https://covid-api.mmediagroup.fr/v1/cases"
    private static let vaccineURL = "https://covid-api.mmediagroup.fr/v1/vaccines"
    
    static func fetchCovidData(completion: @escaping(JSON?, Error?) -> Void) {
        if let url = URL(string: covidURL) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let covidData = try JSON(data: data)
                        completion(covidData, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
            }
            task.resume()
        }
    }
    
    static func fetchVaccineData(completion: @escaping(JSON?, Error?) -> Void) {
        if let url = URL(string: vaccineURL) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    do {
                        let vaccineData = try JSON(data: data)
                        completion(vaccineData, nil)
                    } catch {
                        completion(nil, error)
                    }
                }
            }
            task.resume()
        }
    }
}
