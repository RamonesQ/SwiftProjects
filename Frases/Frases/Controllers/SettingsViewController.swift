//
//  SettingsViewController.swift
//  Frases
//
//  Created by Ramon Queiroz dos Santos on 09/09/22.
//

import UIKit

class SettingsViewController: UIViewController {
	
	@IBOutlet weak var slTimeInterval: UISlider!
	@IBOutlet weak var swAutorefresh: UISwitch!
	@IBOutlet weak var scColorScheme: UISegmentedControl!
	@IBOutlet weak var lbTimeInterval: UILabel!
	
	let config = Configuration.shared

    override func viewDidLoad() {
        super.viewDidLoad()
		 NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Refresh"), object: nil, queue: nil) { (notification) in
			 self.formatView()
		 }
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		formatView()
	}
	
	func formatView() {
		swAutorefresh.setOn(config.autorefresh, animated: false)
		slTimeInterval.setValue(Float(config.timeInterval), animated: false)
		scColorScheme.selectedSegmentIndex = config.colorScheme
		changeTimeIntervalLabel(with: config.timeInterval)
	}
	func changeTimeIntervalLabel(with value: Double) {
		lbTimeInterval.text = "Mudar após \(Int(value)) segundos"
	}
	
	@IBAction func changeAutorefresh(_ sender: UISwitch) {
		config.autorefresh = sender.isOn
	}
	
	@IBAction func changeTimeInterval(_ sender: UISlider) {
		let value = Double(sender.value)
		changeTimeIntervalLabel(with: value)
		config.timeInterval = value
	}
	@IBAction func changeColorScheme(_ sender: UISegmentedControl) {
		config.colorScheme = sender.selectedSegmentIndex
	}
	
	
}
