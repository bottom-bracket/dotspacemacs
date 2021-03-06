;;; ~/.doom.d/bindings/+spacemacs.el -*- lexical-binding: t; -*-
;;; Spacemacs Keybindings

(map!
 ;; Comma for shortcut to local-leader
 ;; :n "," (λ! (push (cons t ?m) unread-command-events)
 ;;            (push (cons t 32) unread-command-events))

 ;; Use C-a as the window operations prefix for when I accidentally think I'm in tmux
 :n "C-a" (λ! (push (cons t ?w) unread-command-events)
              (push (cons t 32) unread-command-events))


 (:after magit
   (:map with-editor-mode-map
     ;; Use gk and gj for these
     ;; :desc "Previous comment" "C-S-k" #'log-edit-previous-comment
     ;; :desc "Next comment" "C-S-j" #'log-edit-next-comment
     (:localleader
       :desc "Commit" :n "c" #'with-editor-finish
       :desc "Abort commit" :n "a" #'with-editor-cancel)))

 ;; Keep old search prefix until I'm used to "s"

 (:leader
   (:prefix "f"
     :desc "Save file (Spacemacs)" :n "s" #'save-buffer
     :desc "Find file (Spacemacs)" :n "f" #'find-file)
   ;; (:prefix "b"
   ;;   :desc "Switch buffer (Spacemacs)" :n "b" #'switch-to-buffer)
   (:prefix "w"
     :desc "Vertical split (Spacemacs)" :n "|" #'evil-window-vsplit
     :desc "Horizontal split (Spacemacs)" :n "_" #'evil-window-split
     :desc "New frame (Spacemacs)" :n "F" #'make-frame
     :desc "Next frame (Spacemacs)" :n "o" #'other-frame
     :desc "Delete window (Spacemacs)" :n "d" #'evil-quit

     ;; Displaced by other-frame keybinding
     :desc "Window enlargen" :n "O" #'doom/window-enlargen)
   (:prefix "p"
     :desc "Find project file (Spacemacs)" :n "f" #'projectile-find-file))

   ;; (:after helm-files
   ;;   :map (helm-find-files-map helm-read-file-map)
   ;;   "S-<return>" #'helm-ff-run-switch-other-window
   ;;   "C-l" #'helm-execute-persistent-action
   ;;   "C-w" #'helm-find-files-up-one-level)
 )



;;; spacemacs.el ends here
