//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by Raein Teymouri on 5/25/18.
//  Copyright © 2018 Raein Teymouri. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {

    var categoryArray = [Category]()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = self.categoryArray[indexPath.row]
            print(self.categoryArray[indexPath.row])
        }
        

    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var categoryField = UITextField()
        let alertController = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (input) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = categoryField.text!
            self.categoryArray.append(newCategory)
            self.saveCategories()
            
        }
        alertController.addAction(action)
        alertController.addTextField { (textField) in
            textField.placeholder = "enter category here"
            categoryField = textField
        }
        present(alertController, animated: true, completion: nil)
    }
    
    func saveCategories (){
        
        do {
            try self.context.save()
        }
        catch {
            print("Error while saving category")
        }
        self.tableView.reloadData()
    }
    func loadCategories (with request: NSFetchRequest<Category> = Category.fetchRequest()){
        
        do {
            categoryArray = try self.context.fetch(request)
        }
        catch {
            print("Error while fetching category from coredata")
        }
    }
}
