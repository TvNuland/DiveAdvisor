/* 
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Request {
	public var str : String?
	public var timestamp : Int?
	public var loc : Loc?
	public var mode : String?
	public var dist : Int?
	public var api : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let request_list = Request.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Request Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Request]
    {
        var models:[Request] = []
        for item in array
        {
            models.append(Request(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let request = Request(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Request Instance.
*/
	required public init?(dictionary: NSDictionary) {

		str = dictionary["str"] as? String
		timestamp = dictionary["timestamp"] as? Int
		if (dictionary["loc"] != nil) { loc = Loc(dictionary: dictionary["loc"] as! NSDictionary) }
		mode = dictionary["mode"] as? String
		dist = dictionary["dist"] as? Int
		api = dictionary["api"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.str, forKey: "str")
		dictionary.setValue(self.timestamp, forKey: "timestamp")
		dictionary.setValue(self.loc?.dictionaryRepresentation(), forKey: "loc")
		dictionary.setValue(self.mode, forKey: "mode")
		dictionary.setValue(self.dist, forKey: "dist")
		dictionary.setValue(self.api, forKey: "api")

		return dictionary
	}

}