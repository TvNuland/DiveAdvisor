//
//  weatherServiceClass.swift
//  DiveAdvisor
//
//  Created by Paul Geurts on 16/06/2017.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation
import Alamofire

class weatherServiceClass {
    
    static func getWeatherByCoords(lat: Double, lng: Double, radius: Double) {
        let url = weatherURLCreator.createWeatherURL(lat: lat, lng: lng, radius: radius)
        print(url!)
        
        Alamofire.request(url!).validate().responseJSON { (response) in
            switch response.result {
            case .success:
                print("Validation Successful")
                if let jsonDict = response.result.value as? NSDictionary {
                    //post data to ViewController via "weatherReceivedNotification"
                    let weather = WeatherBaseObject.init(dictionary: jsonDict)
                    
//                    weather?.data?.weather?[0].hourly?[0]
                    if let weatherDayArray = weather?.data?.weather,
                        let todaysHourlyWeather = weatherDayArray[0].hourly,
                        let todaysHourAverageWeather = todaysHourlyWeather[0] as? Hourly{
                        NotificationCenter.default.post(name: Notification.Name(rawValue: notificationIDs.passWeatherDetails),
                                                        object: self,
                                                        userInfo: ["results" :  todaysHourAverageWeather])
                    }

                    //weather?.data?.weather?[0].hourly?[0]
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
