//
//  CoinManager.swift
//  ByteCoin-Programmatic
//
//  Created by Marc Moxey on 6/22/23.
//

import Foundation

protocol CoinManagerDelegate {
    // pass in the rate(last price) of bitcoin from api request
    func didUpdateLastPrice(price: String, currency: String)
}


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "7CAAA0CE-CDCA-430B-9473-40A6FEB73991"
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
    func getCoinPrice(for currency: String) {
//      print(currency)
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
  
        //1.  create a url
        if let url = URL(string: urlString) {
            
            //2.  Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            // goes to url and grab data
            let task =  session.dataTask(with: url) { data, response, error in
                
                if let _ = error {
//                    self.delegate?.didFailWithError(error: error!)
                    print("Unable to complete your request. Please check your internet connection")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("Invalid response from the server. Please try again.")
                    return
                }
                
                guard let data = data else {
                    print( "The data received from the server was invalid. Please try again.")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let coinData = try decoder.decode(CoinModel.self, from: data)
                    
                    
                    // propties
                    let rate = coinData.rate
                    let priceStr = String(format: "%.2f", rate)
                    self.delegate?.didUpdateLastPrice(price: priceStr, currency: currency)
//                  print(rate)
            
                   
                } catch {
       
                    print("The data received from the server was invalid. Please try again.")
                
                }
               
            }
            
            //4. Start task
            task.resume()
            
        }
    }
    
}
