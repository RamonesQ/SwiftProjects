//
//  CarsTableViewController.swift
//  Carangas
//
//  Created by Eric Brito on 21/10/17.
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class CarsTableViewController: UITableViewController {
	
	var cars: [Car] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		Rest.loadCars { cars in
			self.cars = cars
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
			
		} onError: { error in
			switch error {
			case .invalidJson:
				print("erro no Jason")
			case .url:
				print("erro na url")
			case .taskError(error: let error):
				print("erro: \(error) na task")
			case .noResponse:
				print("me ignorou")
			case .noData:
				print("sem dados")
			case .responseStatusCode(code: let code):
				print("Codigo: \(code) recebido")
			}
		}
		
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "viewSegue"{
			let vc = segue.destination as! CarViewController
			vc.car = cars[tableView.indexPathForSelectedRow!.row]
		}
	}
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		 return cars.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		 
		 let car = cars[indexPath.row]
		 cell.textLabel?.text = car.name
		 cell.detailTextLabel?.text = car.brand

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			  
			  let car = cars[indexPath.row]
			  Rest.delete(car: car) { (success) in
				  if success {
					  self.cars.remove(at: indexPath.row)
					  DispatchQueue.main.async {
						  tableView.deleteRows(at: [indexPath], with: .fade)
					  }
				  }
			  }
        }
    }

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
