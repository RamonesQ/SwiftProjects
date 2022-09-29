//
//  ResultViewController.swift
//  MasterQuiz
//
//  Created by Ramon Queiroz dos Santos on 05/09/22.
//

import UIKit

class ResultViewController: UIViewController {
	
	
	@IBOutlet weak var lbAnsewerd: UILabel!
	@IBOutlet weak var lbCorrect: UILabel!
	@IBOutlet weak var lbWrong: UILabel!
	@IBOutlet weak var lbScore: UILabel!
	
	var totalCorrectAnswers: Int = 0
	var totalAnswers: Int = 0
	
    override func viewDidLoad() {
        super.viewDidLoad()

		 lbAnsewerd.text = "Perguntas respondias: \(totalAnswers)"
		 lbCorrect.text = "Respostas corretas: \(totalCorrectAnswers)"
		 lbWrong.text = "Respostas incorretas: \(totalAnswers - totalCorrectAnswers)"
		 let score = (totalCorrectAnswers*100)/totalAnswers
		 lbScore.text = "\(score)%"
    }
    
	@IBAction func close(_ sender: Any) {
		dismiss(animated: true)
	}
	
}
