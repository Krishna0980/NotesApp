//
//  File.swift
//  NotesApp
//
//  Created by Krishna Bhatt on 15/07/21.
//
import UIKit

class File: UIViewController {

    var arrayitem = [UIBarButtonItem]()
    private var filearray = Array<String>()
    private let mytableview = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "My Files"
              view.addSubview(mytableview)
              
              let additem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addbuttontapped))
              arrayitem.append(additem)
              let btn2 = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(logoutbutton))
              arrayitem.append(btn2)
              navigationItem.setLeftBarButtonItems(arrayitem, animated: true)
              setuptableview()
    }
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          
          fetchFiles()
      }
      override func viewDidLayoutSubviews() {
          super.viewDidLayoutSubviews()
          mytableview.frame=view.bounds
         
      }
      
     @objc private func addbuttontapped()
     {
      let vc = NewNote()
      navigationController?.pushViewController(vc, animated: true)
     }
      @objc private func logoutbutton()
      {
           let vc1 = ViewController()
       navigationController?.pushViewController(vc1, animated: true)
      }

      private func fetchFiles()
      {
          let path = getDocDir()
          
          do{
              let items = try FileManager.default.contentsOfDirectory(at: path,includingPropertiesForKeys: nil)
              
              filearray.removeAll()
              
              for item in items
              {
                 filearray.append(item.lastPathComponent)
              
              }
          }
          catch{
              print(error.localizedDescription)
          }
          
          mytableview.reloadData()
      }
      
      private func getDocDir() -> URL{
          let  paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
          
          print("Doc Dir: \(paths[0])")
          return paths[0]
      }
}

extension File : UITableViewDataSource,UITableViewDelegate{
    private func setuptableview(){
        mytableview.dataSource = self
        mytableview.delegate = self
        mytableview.register(UITableViewCell.self, forCellReuseIdentifier: "filecell")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filecell", for : indexPath)
        cell.textLabel!.text = filearray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(filearray[indexPath.row])
        
        let vc = NewNote()
        vc.openFile = filearray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if  editingStyle == .delete
        {
            let alert = UIAlertController(title: "Delete!", message: "Are you sure you want to delete \(filearray[indexPath.row])", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel))
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive,handler: { _ in
                let path = self.getDocDir()
                let filepath = path.appendingPathComponent(self.filearray[indexPath.row])
                do
                {
                    print(filepath)
                    try
                        
                            FileManager.default.removeItem(at: filepath)
                            self.filearray.remove(at: indexPath.row)
                            self.mytableview.deleteRows(at: [indexPath], with: .fade)
                            self.mytableview.reloadData()
                        }catch
                        {
                            print(error.localizedDescription)
                        }
            }))
            
            present(alert, animated: true)
            
        }
    }
}
