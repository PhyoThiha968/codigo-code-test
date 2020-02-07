//
//  Exts.swift
//  codetest
//
//  Created by Phyo Thiha on 07/02/2020.
//  Copyright © 2020 Phyo Thiha. All rights reserved.
//

import Foundation

extension Data {
   
   func seralizeData<T>(for object: T.Type) -> T? where T:Codable{
       let decoder = JSONDecoder()
       do {
           let data = try decoder.decode(object, from: self)
           return data
       }catch {
           return nil
       }
   }
}

public extension Data {
   var html2AttributedString: NSAttributedString? {
       do {
           return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
       } catch {
           print("error:", error)
           return  nil
       }
   }
   var html2String: String {
       return html2AttributedString?.string ?? ""
   }
}
