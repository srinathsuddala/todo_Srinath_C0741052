

import UIKit

class TaskDetailsViewController: UIViewController {

    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBOutlet weak var selectCategoryButton: UIButton!
    @IBOutlet weak var taskDescriptionTextView: UITextView!
    var selectedCategory: Category?
    var selectedTask: Task?
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
        
        taskDescriptionTextView.layer.borderColor = UIColor.black.cgColor
        taskDescriptionTextView.layer.borderWidth = 1.0
        taskDescriptionTextView.layer.cornerRadius = 5.0
        
        selectCategoryButton.layer.borderColor = UIColor.black.cgColor
        selectCategoryButton.layer.borderWidth = 1.0
        selectCategoryButton.layer.cornerRadius = 5.0
        
        showSelectedTaskDetails()
        // Do any additional setup after loading the view.
    }
    
    func showSelectedTaskDetails() {
        guard let task = selectedTask else { return }
        taskTitleTextField.text = task.title
        taskDescriptionTextView.text = task.desc
        if let category = task.category {
            selectCategoryButton.setTitle(category.title, for: UIControl.State())
        } else {
            selectCategoryButton.setTitle("Select Category", for: UIControl.State())
        }
    }
    
    @objc func saveTapped() {
        guard let title = taskTitleTextField.text, let desc = taskDescriptionTextView.text else { return }
        let task = selectedTask == nil ? Task(context: appdelegate.persistentContainer.viewContext) : selectedTask!
        task.title = title
        task.desc = desc
        task.category = selectedCategory
        if selectedTask == nil {
            appdelegate.persistentContainer.viewContext.insert(task)
        }
        try? appdelegate.persistentContainer.viewContext.save()
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}