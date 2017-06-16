//
//  DiveAdvisorService.swift
//  DiveAdvisor
//
//  Created by Achid Farooq on 14-06-17.
//  Copyright © 2017 ben smith. All rights reserved.
//

import Foundation
import Alamofire

class DAServiceClass {
    static func diveSearchByCoords() {
        let url = DAUrlCreator.createDAURLWithComponents(term: .bySearchByCoordDist(-8.348, 116.0563, 250))
        print(url!)
        Alamofire.request(url!).responseString { response in
            if let error = response.result.error {
                print(error)
            }
            if let value = response.result.value {
                print(value)
            }
        }
    }
}
