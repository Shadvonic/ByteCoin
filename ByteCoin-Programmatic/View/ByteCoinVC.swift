//
//  ByteCoinVC.swift
//  ByteCoin-Programmatic
//
//  Created by Marc Moxey on 6/22/23.
//

import UIKit

class ByteCoinVC: UIViewController {
    
    let titleLabel = UILabel()
    
    let coinView = UIView()
    let stackView = UIStackView()
    let imageView = UIImageView()
    let bitcoinLabel = UILabel()
    let currencyLabel = UILabel()
    
    var currencyPicker = UIPickerView()
    
    var model = CoinManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Background Color")
        configureUI()

     
    }
    
    
    func configureUI() {
        configureStackView()
        configurePickerView()
    }
    

    
    
    func configureStackView() {

        let  padding: CGFloat =  25
        let  margin: CGFloat  = 10
        
        view.addSubview(coinView)
        view.addSubview(stackView)
        view.addSubview(imageView)
        view.addSubview(bitcoinLabel)
        view.addSubview(currencyLabel)
        view.addSubview(titleLabel)
        
        
        
        
        // Stack View
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leadingAnchor),
            stackView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margin),
    
        ])
        
        // Title Label
        titleLabel.text = "ByteCoin"
        titleLabel.textAlignment = .center
        titleLabel.tintColor = UIColor(named: "Title Color")
        titleLabel.font = .systemFont(ofSize: 50)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 92),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -92),
            titleLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -25)
        ])
        

        // Coin View
        coinView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            coinView.topAnchor.constraint(equalTo: stackView.topAnchor),
            coinView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            coinView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            coinView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        
        
        ])


        // Image View
        imageView.image = UIImage(systemName: "bitcoinsign.circle.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(named: "Icon Color")
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: coinView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: coinView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: bitcoinLabel.leadingAnchor, constant: -margin),
            imageView.bottomAnchor.constraint(equalTo: coinView.bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 80)
        ])


        // Bitcoin Label
        bitcoinLabel.text = "..."
        bitcoinLabel.textAlignment = .right
        bitcoinLabel.font = .systemFont(ofSize: 25)
        bitcoinLabel.textColor = .white
        bitcoinLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            bitcoinLabel.topAnchor.constraint(equalTo: coinView.topAnchor, constant: padding),
            bitcoinLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: margin),
            bitcoinLabel.trailingAnchor.constraint(equalTo: currencyLabel.leadingAnchor, constant: -margin),
            bitcoinLabel.bottomAnchor.constraint(equalTo: coinView.bottomAnchor, constant: -padding),
            bitcoinLabel.widthAnchor.constraint(equalToConstant: 213)
        ])




        // Currency Label
        currencyLabel.text = "USD"
        currencyLabel.textAlignment = .right
        currencyLabel.font = .systemFont(ofSize: 25)
        currencyLabel.textColor = .white
        currencyLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: coinView.topAnchor, constant: padding),
            currencyLabel.leadingAnchor.constraint(equalTo: bitcoinLabel.trailingAnchor, constant: margin),
            currencyLabel.trailingAnchor.constraint(equalTo: coinView.trailingAnchor),
            currencyLabel.bottomAnchor.constraint(equalTo: coinView.bottomAnchor, constant: -padding)

        ])
    }
    
    
    func configurePickerView() {
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        model.delegate = self
        
        view.addSubview(currencyPicker)
        
        currencyPicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currencyPicker.topAnchor.constraint(equalTo: coinView.bottomAnchor, constant: 423),
            currencyPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currencyPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currencyPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
     
        
    }

}

// MARK: - UIPickerViewDelegate
extension ByteCoinVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return  model.currencyArray[row]
      
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurr = model.currencyArray[row]
        model.getCoinPrice(for: selectedCurr)
     
       
    }
}

// MARK: - CoinManagerDelegate
extension ByteCoinVC: CoinManagerDelegate {
    func didUpdateLastPrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
 
    
    
}
