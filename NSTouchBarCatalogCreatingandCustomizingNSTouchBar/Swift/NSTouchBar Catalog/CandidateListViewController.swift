/*
 Copyright (C) 2017 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 View controller responsible for showing NSCandidateListTouchBarItem in an NSTouchBar instance, used for picking contacts as a use case.
 */

import Cocoa
import Contacts

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBar.CustomizationIdentifier {
    static let candidateListBar = NSTouchBar.CustomizationIdentifier("com.TouchBarCatalog.candidateListBar")
}

@available(OSX 10.12.2, *)
fileprivate extension NSTouchBarItem.Identifier {
    static let candidateList = NSTouchBarItem.Identifier("com.TouchBarCatalog.TouchBarItem.candidateList")
}

// MARK: -

@available(OSX 10.12.2, *)
class CandidateListViewController: NSViewController {
    
    var candidateListItem: NSCandidateListTouchBarItem<CNContact>!
    
    @IBOutlet weak var textField: NSTextField!
    
    // MARK: View Controller Life Cycle
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        // We want to use our candidate item, instead of NSTextField's.
        textField.isAutomaticTextCompletionEnabled = false
    }
    
    // MARK: NSTouchBarProvider
    
    override func makeTouchBar() -> NSTouchBar? {
        let touchBar = NSTouchBar()
        touchBar.delegate = self
        touchBar.customizationIdentifier = .candidateListBar
        touchBar.defaultItemIdentifiers = [.candidateList, .otherItemsProxy]
        touchBar.customizationAllowedItemIdentifiers = [.candidateList]
        
        return touchBar
    }
    
    func candidateName(from contact: CNContact) -> String {
        if !contact.givenName.isEmpty {
            if !contact.familyName.isEmpty {
                return contact.givenName + " " + contact.familyName
            } else {
                return contact.givenName
            }
        } else {
            return contact.familyName
        }
    }
    
    func candidateEmail(from contact: CNContact) -> String {
        if !contact.emailAddresses.isEmpty {
            return contact.emailAddresses[0].value as String
        } else {
            return ""
        }
    }
    
    func candidates(matching name: String) -> [CNContact] {
        let keysToFetch = [CNContactGivenNameKey as CNKeyDescriptor,
                           CNContactFamilyNameKey as CNKeyDescriptor,
                           CNContactEmailAddressesKey as CNKeyDescriptor]
        do {
            let contacts =
                try CNContactStore().unifiedContacts(matching: CNContact.predicateForContacts(matchingName: name),
                                                     keysToFetch: keysToFetch)
            return contacts
        } catch {
            print("Caught an error but not handle it at \(#function): \(error)")
        }
        
        return []
    }
    
    private lazy var runContactsPermissionAlert: Void = {
        // Run this alert only once.
        let alert = NSAlert()
        alert.messageText = NSLocalizedString("Access to Contacts is not allowed", comment:"")
        alert.informativeText =
            NSLocalizedString("Unable to search Contacts. Check System Settings, \"Privacy\" and give this application access.",
                              comment: "")
        alert.runModal()
    }()
    
    override func controlTextDidChange(_ notification: Notification) {
        guard let textField = notification.object as? NSTextField else { return }
        
        var candidates: [CNContact] = []
        
        let range: NSRange
        if let text = view.window?.fieldEditor(false, for: textField) {
            range = text.selectedRange
        } else {
            range = NSRange(location: 0, length: 0)
        }
        
        if !textField.stringValue.isEmpty {
            let authorizeStatus = CNContactStore.authorizationStatus(for: .contacts)
            
            if authorizeStatus == .notDetermined {
                CNContactStore().requestAccess(for: .contacts) { granted, _ in
                    if granted {
                        candidates = self.candidates(matching: textField.stringValue)
                    }
                }
            } else if authorizeStatus == .denied {
                _ = runContactsPermissionAlert
            } else if authorizeStatus == .authorized {
                candidates = self.candidates(matching: textField.stringValue)
            }
        }
        
        candidateListItem.setCandidates(candidates, forSelectedRange: range, in: nil)
    }
}

// MARK: - NSTouchBarDelegate

@available(OSX 10.12.2, *)
extension CandidateListViewController: NSTouchBarDelegate {
    
    // This gets called while the NSTouchBar is being constructed, for each NSTouchBarItem to be created.
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        guard identifier == .candidateList else { return nil }
        
        candidateListItem = NSCandidateListTouchBarItem<CNContact>(identifier: identifier)
        candidateListItem.delegate = self
        candidateListItem.customizationLabel = NSLocalizedString("Candidate List", comment:"")
        
        candidateListItem.attributedStringForCandidate = { [unowned self] (candidate, index) -> NSAttributedString in
            return NSAttributedString(string: self.candidateName(from: candidate) + "\r" + self.candidateEmail(from: candidate))
        }
        
        return candidateListItem
    }
}

// MARK: - NSCandidateListTouchBarItemDelegate

@available(OSX 10.12.2, *)
extension CandidateListViewController: NSCandidateListTouchBarItemDelegate {
    func candidateListTouchBarItem(_ anItem: NSCandidateListTouchBarItem<AnyObject>, endSelectingCandidateAt index: Int) {
        guard anItem == candidateListItem && anItem.candidates.count > index else { return }
        
        let contact = candidateListItem.candidates[index]
        textField.stringValue = candidateName(from: contact) + " <" + candidateEmail(from: contact) + ">"
    }
}

