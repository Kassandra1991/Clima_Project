//
//  WeatherViewController.swift
//  Clima_Project
//
//  Created by Aleksandra Asichka on 2023-02-15.
//

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - UI
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionalImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        temperatureLabel.text = "33"
        cityLabel.text = "Vilnius"
        conditionalImageView.image = UIImage(systemName: "sun.min")
    }
}
