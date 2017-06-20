/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Hourly {
	
    //Selected Variables:
    
    //-- General
    public var winddir16Point : String?
    
    //-- Metric
    public var tempC : Int?
	public var windspeedKmph : Int?
	public var swellHeight_m : Double?
    public var waterTemp_C : Int?
    
    //-- Imperial
    public var tempF : Int?
    public var windspeedMiles : Int?
    public var swellHeight_ft : Double?
    public var waterTemp_F : Int?
	
    //Not Selected
    public var time : Int?
    public var winddirDegree : Int?
    public var weatherCode : Int?
	public var weatherIconUrl : Array<WeatherIconUrl>?
	public var weatherDesc : Array<WeatherDesc>?
	public var precipMM : Double?
	public var humidity : Int?
	public var visibility : Int?
	public var pressure : Int?
	public var cloudcover : Int?
	public var heatIndexC : Int?
	public var heatIndexF : Int?
	public var dewPointC : Int?
	public var dewPointF : Int?
	public var windChillC : Int?
	public var windChillF : Int?
	public var windGustMiles : Int?
	public var windGustKmph : Int?
	public var feelsLikeC : Int?
	public var feelsLikeF : Int?
	public var sigHeight_m : Double?
	
	public var swellDir : Int?
	public var swellDir16Point : String?
	public var swellPeriod_secs : Double?
	

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let hourly_list = Hourly.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Hourly Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Hourly]
    {
        var models:[Hourly] = []
        for item in array
        {
            models.append(DetailWeather(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let hourly = Hourly(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Hourly Instance.
*/
	required public init?(dictionary: NSDictionary) {

		time = dictionary["time"] as? Int
		tempC = dictionary["tempC"] as? Int
		tempF = dictionary["tempF"] as? Int
		windspeedMiles = dictionary["windspeedMiles"] as? Int
		windspeedKmph = dictionary["windspeedKmph"] as? Int
		winddirDegree = dictionary["winddirDegree"] as? Int
		winddir16Point = dictionary["winddir16Point"] as? String
		weatherCode = dictionary["weatherCode"] as? Int
		if (dictionary["weatherIconUrl"] != nil) { weatherIconUrl = WeatherIconUrl.modelsFromDictionaryArray(dictionary["weatherIconUrl"] as! NSArray) }
		if (dictionary["weatherDesc"] != nil) { weatherDesc = WeatherDesc.modelsFromDictionaryArray(dictionary["weatherDesc"] as! NSArray) }
		precipMM = dictionary["precipMM"] as? Double
		humidity = dictionary["humidity"] as? Int
		visibility = dictionary["visibility"] as? Int
		pressure = dictionary["pressure"] as? Int
		cloudcover = dictionary["cloudcover"] as? Int
		heatIndexC = dictionary["HeatIndexC"] as? Int
		heatIndexF = dictionary["HeatIndexF"] as? Int
		dewPointC = dictionary["DewPointC"] as? Int
		dewPointF = dictionary["DewPointF"] as? Int
		windChillC = dictionary["WindChillC"] as? Int
		windChillF = dictionary["WindChillF"] as? Int
		windGustMiles = dictionary["WindGustMiles"] as? Int
		windGustKmph = dictionary["WindGustKmph"] as? Int
		feelsLikeC = dictionary["FeelsLikeC"] as? Int
		feelsLikeF = dictionary["FeelsLikeF"] as? Int
		sigHeight_m = dictionary["sigHeight_m"] as? Double
		swellHeight_m = dictionary["swellHeight_m"] as? Double
		swellHeight_ft = dictionary["swellHeight_ft"] as? Double
		swellDir = dictionary["swellDir"] as? Int
		swellDir16Point = dictionary["swellDir16Point"] as? String
		swellPeriod_secs = dictionary["swellPeriod_secs"] as? Double
		waterTemp_C = dictionary["waterTemp_C"] as? Int
		waterTemp_F = dictionary["waterTemp_F"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.time, forKey: "time")
		dictionary.setValue(self.tempC, forKey: "tempC")
		dictionary.setValue(self.tempF, forKey: "tempF")
		dictionary.setValue(self.windspeedMiles, forKey: "windspeedMiles")
		dictionary.setValue(self.windspeedKmph, forKey: "windspeedKmph")
		dictionary.setValue(self.winddirDegree, forKey: "winddirDegree")
		dictionary.setValue(self.winddir16Point, forKey: "winddir16Point")
		dictionary.setValue(self.weatherCode, forKey: "weatherCode")
		dictionary.setValue(self.precipMM, forKey: "precipMM")
		dictionary.setValue(self.humidity, forKey: "humidity")
		dictionary.setValue(self.visibility, forKey: "visibility")
		dictionary.setValue(self.pressure, forKey: "pressure")
		dictionary.setValue(self.cloudcover, forKey: "cloudcover")
		dictionary.setValue(self.heatIndexC, forKey: "HeatIndexC")
		dictionary.setValue(self.heatIndexF, forKey: "HeatIndexF")
		dictionary.setValue(self.dewPointC, forKey: "DewPointC")
		dictionary.setValue(self.dewPointF, forKey: "DewPointF")
		dictionary.setValue(self.windChillC, forKey: "WindChillC")
		dictionary.setValue(self.windChillF, forKey: "WindChillF")
		dictionary.setValue(self.windGustMiles, forKey: "WindGustMiles")
		dictionary.setValue(self.windGustKmph, forKey: "WindGustKmph")
		dictionary.setValue(self.feelsLikeC, forKey: "FeelsLikeC")
		dictionary.setValue(self.feelsLikeF, forKey: "FeelsLikeF")
		dictionary.setValue(self.sigHeight_m, forKey: "sigHeight_m")
		dictionary.setValue(self.swellHeight_m, forKey: "swellHeight_m")
		dictionary.setValue(self.swellHeight_ft, forKey: "swellHeight_ft")
		dictionary.setValue(self.swellDir, forKey: "swellDir")
		dictionary.setValue(self.swellDir16Point, forKey: "swellDir16Point")
		dictionary.setValue(self.swellPeriod_secs, forKey: "swellPeriod_secs")
		dictionary.setValue(self.waterTemp_C, forKey: "waterTemp_C")
		dictionary.setValue(self.waterTemp_F, forKey: "waterTemp_F")

		return dictionary
	}

}
