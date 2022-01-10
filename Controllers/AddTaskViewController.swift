//
//  AddTaskViewController.swift
//  TODOLISTWITHRxSwiftApp
//
//  Created by IwasakIYuta on 2022/01/10.
//

import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
    
    //Taskを観察可能
    private let taskSubject = PublishSubject<Task>()
    
    //購読できるようにする
    var taskSubjectObservable: Observable<Task> {
        taskSubject.asObserver()
    }
    
    
    
    @IBOutlet weak var prioritySegmentController: UISegmentedControl!
    
    @IBOutlet weak var taskTitleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func save() {
        guard let priority = Priority(rawValue: prioritySegmentController.selectedSegmentIndex),
        let title = taskTitleTextField.text else { return }
        //
        let task = Task(title: title, priority: priority)
        
        taskSubject.onNext(task)
        
        dismiss(animated: true)
        
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
