/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Hourly {
	
	public var tempC : String?
	public var tempF : String?
	public var windspeedMiles : String?
	public var windspeedKmph : String?
	public var winddir16Point : String?
    public var swellHeight_m : String?
    public var swellHeight_ft : String?
    public var waterTemp_C : String?
    public var waterTemp_F : String?
    
    public var weatherIconUrl : Array<WeatherIconUrl>?
    public var time : String?
    public var winddirDegree : String?
	public var weatherCode : String?
	public var weatherDesc : Array<WeatherDesc>?
	public var precipMM : String?
	public var humidity : String?
	public var visibility : String?
	public var pressure : String?
	public var cloudcover : String?
	public var heatIndexC : String?
	public var heatIndexF : String?
	public var dewPointC : String?
	public var dewPointF : String?
	public var windChillC : String?
	public var windChillF : String?
	public var windGustMiles : String?
	public var windGustKmph : String?
	public var feelsLikeC : String?
	public var feelsLikeF : String?
	public var sigHeight_m : String?
	public var swellDir : String?
	public var swellDir16Point : String?
	public var swellPeriod_secs : String?
	

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
            models.append(Hourly(dictionary: item as! NSDictionary)!)
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

		time = dictionary["time"] as? String
		tempC = dictionary["tempC"] as? String
		tempF = dictionary["tempF"] as? String
		windspeedMiles = dictionary["windspeedMiles"] as? String
		windspeedKmph = dictionary["windspeedKmph"] as? String
		winddirDegree = dictionary["winddirDegree"] as? String
		winddir16Point = dictionary["winddir16Point"] as? String
		weatherCode = dictionary["weatherCode"] as? String
		if (dictionary["weatherIconUrl"] != nil) { weatherIconUrl = WeatherIconUrl.modelsFromDictionaryArray(array: dictionary["weatherIconUrl"] as! NSArray) }
		if (dictionary["weatherDesc"] != nil) { weatherDesc = WeatherDesc.modelsFromDictionaryArray(array: dictionary["weatherDesc"] as! NSArray) }
		precipMM = dictionary["precipMM"] as? String
		humidity = dictionary["humidity"] as? String
		visibility = dictionary["visibility"] as? String
		pressure = dictionary["pressure"] as? String
		cloudcover = dictionary["cloudcover"] as? String
		heatIndexC = dictionary["HeatIndexC"] as? String
		heatIndexF = dictionary["HeatIndexF"] as? String
		dewPointC = dictionary["DewPointC"] as? String
		dewPointF = dictionary["DewPointF"] as? String
		windChillC = dictionary["WindChillC"] as? String
		windChillF = dictionary["WindChillF"] as? String
		windGustMiles = dictionary["WindGustMiles"] as? String
		windGustKmph = dictionary["WindGustKmph"] as? String
		feelsLikeC = dictionary["FeelsLikeC"] as? String
		feelsLikeF = dictionary["FeelsLikeF"] as? String
		sigHeight_m = dictionary["sigHeight_m"] as? String
		swellHeight_m = dictionary["swellHeight_m"] as? String
		swellHeight_ft = dictionary["swellHeight_ft"] as? String
		swellDir = dictionary["swellDir"] as? String
		swellDir16Point = dictionary["swellDir16Point"] as? String
		swellPeriod_secs = dictionary["swellPeriod_secs"] as? String
		waterTemp_C = dictionary["waterTemp_C"] as? String
		waterTemp_F = dictionary["waterTemp_F"] as? String
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
