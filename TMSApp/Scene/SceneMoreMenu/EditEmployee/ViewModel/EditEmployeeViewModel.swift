//
//  EditEmployeeViewModel.swift
//  TMSApp
//
//  Created by Nontawat Kanboon on 7/8/21.
//

import Foundation
import UIKit
import Combine

protocol EditEmployeeProtocolInput {
    func getJobPosition()
    func createEmployee(empFname: String,
                        empLname:String,
                        empBirthday: String,
                        empTel1: String,
                        empAvatar: String,
                        attachFiles: [String],
                        empEmail: String,
                        jobPositionName: String
    )
}

protocol EditEmployeeProtocolOutput: class {
    var didGetJobPositionSuccess: (() -> Void)? { get set }
    
    func getListPosition() -> [JobPositionItems]?
}

protocol EditEmployeeProtocol: EditEmployeeProtocolInput, EditEmployeeProtocolOutput {
    var input: EditEmployeeProtocolInput { get }
    var output: EditEmployeeProtocolOutput { get }
}

class EditEmployeeViewModel: EditEmployeeProtocol, EditEmployeeProtocolOutput {
    var input: EditEmployeeProtocolInput { return self }
    var output: EditEmployeeProtocolOutput { return self }
    
    // MARK: - Properties
    private var editEmployeeViewController: EditEmployeeViewController
    // MARK: - UseCase
    private var postEmployeeUseCase: PostEmployeeUseCase
    private var getJobPositionUseCase: GetJobPositionUseCase
    private var anyCancellable: Set<AnyCancellable> = Set<AnyCancellable>()
    
    init(
        editEmployeeViewController: EditEmployeeViewController,
        postEmployeeUseCase: PostEmployeeUseCase = PostEmployeeUseCaseImpl(),
        getJobPositionUseCase: GetJobPositionUseCase = GetJobPositionUseCaseImpl()
    ) {
        self.editEmployeeViewController = editEmployeeViewController
        self.postEmployeeUseCase = postEmployeeUseCase
        self.getJobPositionUseCase = getJobPositionUseCase
    }
    
    // MARK - Data-binding OutPut
    var didGetJobPositionSuccess: (() -> Void)?
    
    fileprivate var listJobPosition: [JobPositionItems]? = []
    
    func getJobPosition() {
        listJobPosition?.removeAll()
        editEmployeeViewController.startLoding()
        
        self.getJobPositionUseCase.execute().sink { completion in
            debugPrint("getJobPosition \(completion)")
            self.editEmployeeViewController.stopLoding()
        } receiveValue: { resp in
            if let items = resp {
                self.listJobPosition = items
                self.didGetJobPositionSuccess?()
            }
        }.store(in: &self.anyCancellable)
    }
    
    func getListPosition() -> [JobPositionItems]? {
        return self.listJobPosition
    }
    
    func createEmployee(empFname: String, empLname: String, empBirthday: String, empTel1: String, empAvatar: String, attachFiles: [String],    empEmail: String, jobPositionName: String) {
        var request = PostEmployeeRequest()
        request.compId = 1
        if let items = self.listJobPosition?.filter({ $0.jobPositionName == jobPositionName }).first {
            request.jobPositionId = items.jobPositionId
        }
        
        request.empFname = empFname
        request.empLname = empLname
        request.empBirthday = empBirthday
        request.empTel1 = empTel1
        request.empEmail = empEmail
        
        //avatarImage
        var requestAvatarImage = EmpAvatarImage()
        requestAvatarImage.url = empAvatar
        request.empAvatar = requestAvatarImage
        
        //attachFiles
        var requestAttachFiles: [AttachFilesImage] = []
        for item in attachFiles {
            var requestAttachFilesImage = AttachFilesImage()
            requestAttachFilesImage.filePath = item
            requestAttachFilesImage.del = 0
            requestAttachFiles.append(requestAttachFilesImage)
        }
        
        request.attachFiles = requestAttachFiles
        
        editEmployeeViewController.startLoding()
        self.postEmployeeUseCase.execute(request: request).sink { completion in
            debugPrint("postEmployee \(completion)")
            self.editEmployeeViewController.stopLoding()
        } receiveValue: { resp in
            if let items = resp {
                if items.success == true {
                    self.editEmployeeViewController.navigationController?.popViewController(animated: true)
                }
            }
        }.store(in: &self.anyCancellable)
    }
}
