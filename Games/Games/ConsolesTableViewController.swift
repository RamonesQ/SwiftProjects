//
//  ConsolesTableViewController.swift
//  Games
//
//  Created by Ramon Queiroz dos Santos on 12/09/22.
//

import UIKit

class ConsolesTableViewController: UITableViewController {
	
	var consolesManager = ConsolesManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
		 loadConsoles()
    }
	
	func loadConsoles(){
		consolesManager.loadConsoles(with: context)
		tableView.reloadData()
	}
	
	
	@IBAction func addConsole(_ sender: Any) {
		showAlert(with: nil)
	}
	
	func showAlert(with console: Console?){
		let title = console == nil ? "Adicionar" : "Editar"
		let alert = UIAlertController(title: title + " plataforma", message: nil, preferredStyle: .alert)
		alert.addTextField() { (textField) in
			textField.placeholder = "Nome da plataforma"
			if let name = console?.name {
				textField.text = name
			}
		}
		alert.addAction(UIAlertAction(title: title, style: .default, handler: { (action) in
			let console = console ?? Console(context: self.context)
			console.name = alert.textFields?.first?.text
			do {
				try self.context.save()
				self.loadConsoles()
			} catch  {
				print(error.localizedDescription)
			}
		}))
		alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
		present(alert, animated: true)
	}
	
	
	
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		 return consolesManager.consoles.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

		 let console = consolesManager.consoles[indexPath.row]
		 cell.textLabel?.text = console.name
        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.



    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
