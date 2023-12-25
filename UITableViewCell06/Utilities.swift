//
//  Utilities.swift
//  UITableViewCell06
//
//  Created by Nick Rodriguez on 24/12/2023.
//

import Foundation


func createRow01() -> [String:String]{
    let jsonString = """
    {
        "independentVarName": "Step Count",
        "forDepVarName": "Sleep Time",
        "correlationValue": "-0.26590927274740994",
        "correlationObservationCount": "6",
        "definition": "The count of your daily steps",
        "noun": "daily step count"
    }
    """
    if let dictionary = parseJsonToDictionary(jsonString: jsonString) {
        return(dictionary)
    }
    return [String:String]()
}
func createRow02() -> [String:String]{
    let jsonString = """
    {
    "independentVarName": "Heart Rate Avg",
    "forDepVarName": "Sleep Time",
    "correlationValue": "-0.12429475505654487",
    "correlationObservationCount": "6",
    "definition": "The avearge of heart rates recoreded across all your devices",
    "noun": "daily average heart rate"
    }
    """
    if let dictionary = parseJsonToDictionary(jsonString: jsonString) {
        return(dictionary)
    }
    return [String:String]()
}
func parseJsonToDictionary(jsonString: String) -> [String: String]? {
    guard let jsonData = jsonString.data(using: .utf8) else { return nil }

    do {
        if let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
            var stringDict = [String: String]()
            for (key, value) in jsonDict {
                stringDict[key] = "\(value)"
            }
            return stringDict
        }
    } catch {
        print("Error parsing JSON: \(error)")
    }

    return nil
}
