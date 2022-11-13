//
//  ViewController.swift
//  ourtodolist
//
//  Created by Fizza Usman on 10/22/22.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource {
    
    private let table: UITableView = {
        let table = UITableView()
//register a table view cell - this is every single row with an entry
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    var fileURL: URL!
    var items = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target:self, action: #selector(didTapAdd))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(didTapMove))
        
        
        let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        fileURL = baseURL.appendingPathComponent("notes.txt")
        load()
        
    }
    
    @objc private func didTapAdd() {
        let alert = UIAlertController(title:"New Item",message: "Enter new task",
                                      preferredStyle: .alert)
        
        //we want alert to have 2 buttons - one for cancelling and one for adding item to todolist
        alert.addTextField{field in field.placeholder = "Enter item..."
    }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self] (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    
                    //make sure that it occurs in the main thread because you are updating the UI enclosures
                DispatchQueue.main.async {
                    
                    var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                    currentItems.append(text)
                    UserDefaults.standard.setValue(currentItems, forKey: "items")
                    self?.items.append(text)
                    self?.table.reloadData()
                    }
            }
            }
        }))
            //present alert with an animation
        present(alert, animated:true)
        save()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //the table's frame (x,y,height,width) = entirety of the view
        table.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // no of rows in section is 0 for now
        return items.count
    }
    
    //function creates and returns a cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
    //return the type of editing style this row can undertake
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath:IndexPath) -> UITableViewCell.EditingStyle{
        return .delete
    }
    

    //we will need this to make cell go away, actual deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            //we are gonna tell table view we are about to update stuff in it
        
            tableView.beginUpdates()
            //set delete with fade animation

            //When we delete a row we also want to update "items"
                 items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        save()
        }
}
     

    @objc private func didTapMove(){
        //if table is editing we want to stop the editing
        if table.isEditing {
            table.isEditing = false
        }
        else{
            table.isEditing = true
        }
        print(items)
    }

    //table can move row at index path
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    //table  move row at index path
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //move the objects in the array that are being moved visually
        items.swapAt(sourceIndexPath.row,destinationIndexPath.row)
        //you can print items here to see how array is changed when you move stuff around
        //print(items)
       save()
    }
    
    func save(){
        //UserDefaults.standard.set(items, forKey: "notes")
        let a = NSArray(array: items)
        do {
            try a.write(to: fileURL)
        } catch {
            print(" error writing file ")
        }
    }
    
    func load(){
        if let loadedData:[String] = NSArray(contentsOf:fileURL) as? [String]{
            items = loadedData
            table.reloadData()
    }
        

    }
}

