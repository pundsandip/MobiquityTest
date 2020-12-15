//
//  CityViewController.swift
//  MobiquityTest
//
//  Created by Sandip Pund on 15/12/20.
//  Copyright © 2020 Sandip Pund. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {
    var model: WeatherInfo?
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblRain: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWind: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    func setData() {
        guard let model = self.model else { return }
        lblCityName.text = model.name
        lblDescription.text = model.weather.first?.weatherDescription ?? ""
        lblTemp.text = "\(model.main.temp)"
        lblRain.text = "\(model.clouds.all)%"
        lblHumidity.text = "\(String(describing: model.main.humidity ?? 0))%"
        lblWind.text = "\(model.wind.speed)"
    }

}
