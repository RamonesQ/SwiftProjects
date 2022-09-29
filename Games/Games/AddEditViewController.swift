//
//  AddEditViewController.swift
//  Games
//
//  Created by Ramon Queiroz dos Santos on 12/09/22.
//

import UIKit

class AddEditViewController: UIViewController {

	
	@IBOutlet weak var tfTitle: UITextField!
	@IBOutlet weak var tfConsole: UITextField!
	@IBOutlet weak var dpReleaseDate: UIDatePicker!
	@IBOutlet weak var btAddEdit: UIButton!
	@IBOutlet weak var btCover: UIButton!
	@IBOutlet weak var ivCover: UIImageView!
	
	var game: Game!
	lazy var pickerView: UIPickerView = {
		let pickerView = UIPickerView()
		pickerView.delegate = self
		pickerView.dataSource = self
		return pickerView
	}()

	
    override func viewDidLoad() {
        super.viewDidLoad()
		 
		 if game != nil {
			 title = "Editar jogo"
			 btAddEdit.setTitle(("ALTERAR"), for: .normal)
			 tfTitle.text = game.title
			 if let console = game.console, let index = consolesManager.consoles.firstIndex(of: console){
				 tfConsole.text = console.name
				 pickerView.selectRow(index, inComponent: 0, animated: false)
			 }
			 ivCover.image = game.console as? UIImage
			 if let releaseDate = game.releaseDate{
				 dpReleaseDate.date = releaseDate
			 }
			 if game.cover != nil {
				 btCover.setTitle(nil, for: .normal)
			 }
		 }
		
		 prepareConsoleTextField()
    }
	
	func prepareConsoleTextField(){
		let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
		let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
		let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
		let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		toolbar.items = [btCancel, btFlexibleSpace, btDone]
		tfConsole.inputView = pickerView
		tfConsole.inputAccessoryView = toolbar
	}
	
	@objc func cancel(){
		tfConsole.resignFirstResponder()
	}
	
	@objc func done(){
		
		tfConsole.text = consolesManager.consoles[pickerView.selectedRow(inComponent: 0)].name
		
		cancel()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		consolesManager.loadConsoles(with: context)
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
	@IBAction func addEditCover(_ sender: UIButton) {
		let alert = UIAlertController(title: "Selecionar poster", message: "De onde?", preferredStyle: .actionSheet)
		if UIImagePickerController.isSourceTypeAvailable(.camera){
			let cameraAction = UIAlertAction(title: "Câmera", style: .default) { (action: UIAlertAction) in
				self.selectPicutre(sourceType: .camera)
			}
			alert.addAction(cameraAction)
		}
		let libraryAction = UIAlertAction(title: "Biblioteca", style: .default) { (action: UIAlertAction) in
			self.selectPicutre(sourceType: .photoLibrary)
		  }
		alert.addAction(libraryAction)
		let photosAction = UIAlertAction(title: "Album", style: .default) { (action: UIAlertAction) in
			self.selectPicutre(sourceType: .savedPhotosAlbum)
		  }
		alert.addAction(photosAction)
		let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
		alert.addAction(cancelAction)
		present(alert, animated: true)
	}
	
	func selectPicutre(sourceType: UIImagePickerController.SourceType) {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
//		imagePicker.navigationBar.tintColor
		present(imagePicker, animated: true)
	}
	
	
	@IBAction func addEditame(_ sender: UIButton) {
		if game == nil {
			game = Game(context: context)
		}
		game.title = tfTitle.text
		game.releaseDate = dpReleaseDate.date
		if !tfConsole.text!.isEmpty {
			let console = consolesManager.consoles[pickerView.selectedRow(inComponent: 0)]
			game.console = console
		}
		game.cover = ivCover.image
		do {
			try context.save()
		} catch  {
			print(error.localizedDescription)
		}
		navigationController?.popViewController(animated: true)
	}
	
}

extension AddEditViewController: UIPickerViewDelegate, UIPickerViewDataSource{
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return consolesManager.consoles.count
	}
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		let console = consolesManager.consoles[row]
		return console.name
	}
	
}

extension AddEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
		ivCover.image = image
		btCover.setTitle(nil, for: .normal)
		dismiss(animated: true)
	}
}
