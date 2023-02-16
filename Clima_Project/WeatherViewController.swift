//
//  WeatherViewController.swift
//  Clima_Project
//
//  Created by Aleksandra Asichka on 2023-02-15.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionalImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.delegate = self
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        searchTextField.endEditing(true)
        guard let city = searchTextField.text else {
            return
        }
        print(city)
    }
}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        guard let city = searchTextField.text else {
            return false
        }
        print(city)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != "" {
            return true
        } else {
            searchTextField.placeholder = "Type some"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let city = searchTextField.text else {
            return
        }
        weatherManager.fetchWeather(cityName: city)
        searchTextField.text = ""
    }
}
