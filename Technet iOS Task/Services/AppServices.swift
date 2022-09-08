//
//  AccountServices.swift
//  Technet iOS Task
//
//  Created by Tom Holmes on 07/09/2022.
//

import Foundation

struct AppServices {
    
    let passwordInvalidMessage = "Password must be at least 8 characters and include 1 uppercase letter, 1 lowercase letter and 1 special character"
    let emailInvalidMessage = "Please provide a valid email address"
    let invalidLoginMessage = "Please provide a valid email address and password"
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
      var returnValue = true
      let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
      
      do {
          let regex = try NSRegularExpression(pattern: emailRegEx)
          let nsString = emailAddressString as NSString
          let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
          
          if results.count == 0 {
              returnValue = false
          }
          
      } catch let error as NSError {
          print("invalid regex: \(error.localizedDescription)")
          returnValue = false
      }
      
      return returnValue
  }
    
    func isValidPassword(passwordString: String) -> Bool {
        var returnValue = true
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        
        do {
            let regex = try NSRegularExpression(pattern: passwordRegEx)
            let nsString = passwordString as NSString
            let results = regex.matches(in: passwordString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return returnValue
                                                                            
    }
    
    func convertDateFromISODateString(isoDate: String) -> Date {
        var appendedIsoDate = isoDate
        appendedIsoDate.append("+0000")
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: appendedIsoDate)!
        return date
    }
    
}
