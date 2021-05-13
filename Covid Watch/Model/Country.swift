//
//  Country.swift
//  Covid Watch
//
//  Created by Abraham Estrada on 4/21/21.
//

import Foundation
import SwiftyJSON

struct Country {
    var name: String
    var icon: String
    var population: String
    var confirmed: String
    var recovered: String
    var deaths: String
    var percentInfected: String
    var administered: String
    var fullyVaccinated: String
    var partiallyVaccinated: String
    var percentVaccinated: String
    
    init(named: String, covidData: JSON, vaccineData: JSON) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        name = named
        if name == "United States" {
            icon = COUNTRIESEMOJIS["United States"]!
            population = numberFormatter.string(from: NSNumber(value: covidData["US"]["All"]["population"].intValue))!
            confirmed = numberFormatter.string(from: NSNumber(value: covidData["US"]["All"]["confirmed"].intValue))!
            recovered = numberFormatter.string(from: NSNumber(value: covidData["US"]["All"]["recovered"].intValue))!
            deaths = numberFormatter.string(from: NSNumber(value: covidData["US"]["All"]["deaths"].intValue))!
            percentInfected = Country.intToPercentString(number: covidData["US"]["All"]["confirmed"].intValue, isWhatPercentOf: covidData["US"]["All"]["population"].intValue)
            administered = numberFormatter.string(from: NSNumber(value: vaccineData["US"]["All"]["administered"].intValue))!
            fullyVaccinated = numberFormatter.string(from: NSNumber(value: vaccineData["US"]["All"]["people_vaccinated"].intValue))!
            partiallyVaccinated = numberFormatter.string(from: NSNumber(value: vaccineData["US"]["All"]["people_partially_vaccinated"].intValue))!
            percentVaccinated = Country.intToPercentString(number: vaccineData["US"]["All"]["people_vaccinated"].intValue, isWhatPercentOf: covidData["US"]["All"]["population"].intValue)
        } else {
            icon = COUNTRIESEMOJIS[named]!
            population = numberFormatter.string(from: NSNumber(value: covidData[named]["All"]["population"].intValue))!
            confirmed = numberFormatter.string(from: NSNumber(value: covidData[named]["All"]["confirmed"].intValue))!
            recovered = numberFormatter.string(from: NSNumber(value: covidData[named]["All"]["recovered"].intValue))!
            deaths = numberFormatter.string(from: NSNumber(value: covidData[named]["All"]["deaths"].intValue))!
            percentInfected = Country.intToPercentString(number: covidData[named]["All"]["confirmed"].intValue, isWhatPercentOf: covidData[named]["All"]["population"].intValue)
            administered = numberFormatter.string(from: NSNumber(value: vaccineData[named]["All"]["administered"].intValue))!
            fullyVaccinated = numberFormatter.string(from: NSNumber(value: vaccineData[named]["All"]["people_vaccinated"].intValue))!
            partiallyVaccinated = numberFormatter.string(from: NSNumber(value: vaccineData[named]["All"]["people_partially_vaccinated"].intValue))!
            percentVaccinated = Country.intToPercentString(number: vaccineData[named]["All"]["people_vaccinated"].intValue, isWhatPercentOf: covidData[named]["All"]["population"].intValue)
        }
    }
}
