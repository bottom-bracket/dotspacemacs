;;; ~/.dotfiles/.doom.d/mu4e-config.el -*- lexical-binding: t; -*-
(use-package! mu4e-multi
  :config
  (setq mu4e-multi-account-alist
        '((""
           (user-mail-address .  "P.Heringlake@mailbox.org")
           (user-full-name  .   "Philip Heringlake")
           (mu4e-reply-to-address . "P.Heringlake@mailbox.org")
           (mu4e-sent-folder .  "/mailbox/Sent")
           (mu4e-drafts-folder . "/mailbox/Drafts")
           (mu4e-trash-folder .  "/mailbox/Trash")
           (mu4e-refile-folder . "/mailbox/Archive"))
          ("work"
           (user-mail-address .  "philip.heringlake@neel.cnrs.fr")
           (user-full-name . "Philip Heringlake")
           (mu4e-reply-to-address . "philip.heringlake@neel.cnrs.fr")
           (mu4e-sent-folder .  "/neel/Sent")
           (mu4e-drafts-folder . "/neel/Drafts")
           (mu4e-trash-folder .  "/neel/Trash")
           (mu4e-refile-folder . "/neel/Archive"))))
  )
(after! mu4e
  (setq mu4e-mu-binary "/bin/mu")
  (setq mu4e-maildir "~/.mail")
  (setq mu4e-drafts-folder "/drafts")
  ;;set attachment downloads directory
  (setq mu4e-attachment-dir  "~/Downloads/Mail_Attachments")
  ;; don't save message to Sent Messages
  ;; (setq mu4e-sent-messages-behavior 'delete)
  ;; setup some handy shortcuts
  ;; you can quickly switch to your Inbox -- press ``ji''
  ;; then, when you want archive some messages, move them to
  ;; the 'All Mail' folder by pressing ``ma''.

  (setq mu4e-maildir-shortcuts
        '( ("/mailbox/INBOX"      . ?i)
           ("/mailbox/Sent"       . ?s)
           ("/mailbox/Trash"      . ?t)
           ("/mailbox/Archive"    . ?a)
           ("/mailbox/Starred"    . ?p)

           ("/neel/INBOX"          . ?w)
           ("/neel/Sent"           . ?f)
           ("/neel/Archive"        . ?o)
           ))
  ;;
  ;; allow for updating mail using 'U' in the main view:
  (setq mu4e-get-mail-command "mbsync -a"
        mu4e-update-interval 300
        mu4e-view-show-images t
        mu4e-show-images t
        mu4e-view-show-addresses t
        mu4e-use-fancy-chars t
        mu4e-html2text-command "w3m -T text/html"
        mu4e-headers-auto-update t
        mu4e-compose-signature (concat
                                ""
                                ""))
 )
;;smptmail

(use-package! smtpmail
  :config
(setq message-send-mail-function 'smtpmail-send-it
     smtpmail-stream-type 'ssl
     smtpmail-default-smtp-server "smtp.mailbox.org"
     smtpmail-smtp-server "smtp.mailbox.org"
     smtpmail-smtp-service 465
     smtpmail-debug-info t ))


(defvar my-mu4e-account-alist
  '(("mailbox"
     ;; about me
     (user-mail-address      "P.Heringlake@mailbox.org")
     (user-full-name         "Philip Heringlake")
     ;; smtp
         (smtpmail-stream-type 'ssl)
         (smtpmail-starttls-credentials '(("smtp.mailbox.org" 465 nil nil)))
     (smtpmail-default-smtp-server "smtp.mailbox.org")
     (smtpmail-smtp-server "smtp.mailbox.org")
     (smtpmail-smtp-service 465))
    ("neel"
     ;; about me
     (user-mail-address      "philip.heringlake@neel.cnrs.fr")
         (user-full-name         "Philip Heringlake")
         ;;(mu4e-compose-signature "")
     ;; smtp
         (smtpmail-stream-type 'ssl)
     (smtpmail-auth-credentials '(("smtps.grenoble.cnrs.fr" 465 "philip.heringlake@neel.cnrs.fr" nil)))
         (smtpmail-default-smtp-server "smtps.grenoble.cnrs.fr")
         (smtpmail-smtp-service 465)
)))

;; Found here - http://www.djcbsoftware.nl/code/mu/mu4e/Multiple-accounts.html
(defun my-mu4e-set-account ()
  "Set the account for composing a message."
  (let* ((account
          (if mu4e-compose-parent-message
              (let ((maildir (mu4e-message-field mu4e-compose-parent-message :maildir)))
                (string-match "/\\(.*?\\)/" maildir)
                (match-string 1 maildir))
            (completing-read (format "Compose with account: (%s) "
                                     (mapconcat #'(lambda (var) (car var))
                                                my-mu4e-account-alist "/"))
                             (mapcar #'(lambda (var) (car var)) my-mu4e-account-alist)
                             nil t nil nil (car my-mu4e-account-alist))))
         (account-vars (cdr (assoc account my-mu4e-account-alist))))
    (if account-vars
        (mapc #'(lambda (var)
                  (set (car var) (cadr var)))
              account-vars)
      (error "No email account found"))))

(add-hook 'mu4e-compose-pre-hook 'my-mu4e-set-account)

;;; Use Dired for attachments
;; make the `gnus-dired-mail-buffers' function also work on
;; message-mode derived modes, such as mu4e-compose-mode
(defun gnus-dired-mail-buffers ()
  "Return a list of active message buffers."
  (let (buffers)
    (save-current-buffer
      (dolist (buffer (buffer-list t))
    (set-buffer buffer)
    (when (and (derived-mode-p 'message-mode)
        (null message-sent-message-via))
      (push (buffer-name buffer) buffers))))
    (nreverse buffers)))

(setq gnus-dired-mail-mode 'mu4e-user-agent)
(add-hook 'dired-mode-hook 'turn-on-gnus-dired-mode)



;;hotkey to load mu4e
;; (global-set-key [f1]  'mu4e)

;;visual changes
;; (custom-set-faces
;;  '(mu4e-title-face ((t (:foreground "#8be9fd"))))
;;  '(mu4e-link-face  ((t (:forefround "#8be9fd"))))
;; )


;; don't save message to Sent Messages, IMAP takes care of this
; (setq mu4e-sent-messages-behavior 'delete)

;; ;; spell check
;; (add-hook 'mu4e-compose-mode-hook
;;         (defun my-do-compose-stuff ()
;;            "My settings for message composition."
;;            (set-fill-column 72)
;;            (flyspell-mode)))
