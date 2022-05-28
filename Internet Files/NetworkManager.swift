//
//  NetworkManager.swift
//  Internet Files
//
//  Created by Daniel Martínez on 27/05/22.
//

import Foundation
import UIKit

protocol NetworkManagerDelegate {
  func didRetrieveFile()
}

enum Files: String {
  case excel = "localidades.xlsx"
  case pdf = "Articles.pdf"
  case image = "geo_vertical.jpg"
}

class NetworkManager {
  var delegate: NetworkManagerDelegate?
  
  func fetch(file: Files) {
    guard let url = URL(string: "http://janzelaznog.com/DDAM/iOS/vim/\(file.rawValue)") else { return }
    URLSession.shared
      .dataTask(with: url) { data, response, error in
        guard error == nil,
              let data = data else { return }
        do {
          
        } catch {
          
        }
      }
  }
}
