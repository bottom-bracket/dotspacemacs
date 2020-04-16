;;; ~/.dotfiles/.doom.d/mu4e-config.el -*- lexical-binding: t; -*-

  (setq mu4e-mu-binary "/bin/mu")
  (setq mu4e-maildir (expand-file-name "~/.mail"))
  ;; allow for updating mail using 'U' in the main view:
  (setq mu4e-get-mail-command "mbsync -a"
        mu4e-update-interval 300
        mu4e-view-prefer-html t
        ;; inline images
        mu4e-view-show-images t
        ;; show full addresses in header
        mu4e-view-show-addresses t
        mu4e-use-fancy-chars t
        ;; mu4e-html2text-command "w3m -T text/html"
        mu4e-headers-auto-update t
        mu4e-compose-signature-auto-include nil
        mu4e-compose-format-flowed t
        mu4e-compose-signature (concat "" "")
        )
  ;; use imagemagick, if available
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))

  ;; to view selected message in the browser, no signin, just html mail
  (add-to-list 'mu4e-view-actions
               '("ViewInBrowser" . mu4e-action-view-in-browser) t)
  ;;
  ;; don't save message to Sent Messages, IMAP takes care of this
  (setq mu4e-sent-messages-behavior 'delete)
  (setq mu4e-drafts-folder "/drafts")
  ;;
  ;;set attachment downloads directory
  (setq mu4e-attachment-dir  "~/Downloads/Mail_Attachments")
  ;;
  ;; Eye candy!?
  ;; from https://www.reddit.com/r/emacs/comments/bfsck6/mu4e_for_dummies/elgoumx
  (add-hook 'mu4e-headers-mode-hook
            (defun my/mu4e-change-headers ()
	            (interactive)
	            (setq mu4e-headers-fields
	                  `((:human-date . 25) ;; alternatively, use :date
		                  (:flags . 6)
		                  (:from . 22)
		                  (:thread-subject . ,(- (window-body-width) 70)) ;; alternatively, use :subject
		                  (:size . 7)))))

  ;; spell check
  (add-hook 'mu4e-compose-mode-hook
            (defun my-do-compose-stuff ()
              "My settings for message composition."
              (visual-line-mode)
              (org-mu4e-compose-org-mode)
              (use-hard-newlines -1)
              (flyspell-mode)))

  (setq message-kill-buffer-on-exit t)
  (setq mu4e-compose-dont-reply-to-self t)


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


  ;;rename files when moving
  ;;NEEDED FOR MBSYNC
  (setq mu4e-change-filenames-when-moving t)



  ;; mu4e-context
  (setq mu4e-context-policy 'pick-first)
  (setq mu4e-compose-context-policy 'always-ask)
  (setq mu4e-contexts
        (list
         (make-mu4e-context
          :name "mailbox" ;;for acc1-gmail
          :enter-func (lambda () (mu4e-message "Entering context mailbox"))
          :leave-func (lambda () (mu4e-message "Leaving context mailbox"))
          :match-func (lambda (msg)
                        (when msg
                          (mu4e-message-contact-field-matches
                           msg '(:from :to :cc :bcc) "*@mailbox.org")))
          :vars '((user-mail-address .  "P.Heringlake@mailbox.org")
                  (user-full-name  .   "Philip Heringlake")
                  (mu4e-sent-folder .  "/mailbox/Sent")
                  (mu4e-drafts-folder . "/mailbox/Drafts")
                  (mu4e-trash-folder .  "/mailbox/Trash")
                  (mu4e-refile-folder . "/mailbox/Archive")
	                (mu4e-compose-signature . (concat "Formal Signature\n" "Emacs 25, org-mode 9, mu4e 1.0\n"))
	                (mu4e-compose-format-flowed . t)
	                ;; (smtpmail-queue-dir . "~/.mail/mailbox/queue/cur")
	                (message-send-mail-function . smtpmail-send-it)
	                (smtpmail-smtp-user . "philip.heringlake")
                  (smtpmail-starttls-credentials '(("smtp.mailbox.org" 465 nil nil)))
	                (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
                  (smtpmail-default-smtp-server "smtp.mailbox.org")
                  (smtpmail-smtp-server "smtp.mailbox.org")
	                (smtpmail-smtp-service . 465)
	                (smtpmail-debug-info . t)
	                (smtpmail-debug-verbose . t)
	                (mu4e-maildir-shortcuts . ( ("/mailbox/INBOX"            . ?i)
					                                    ;; ("/mailbox/[acc1].Sent Mail" . ?s)
					                                    ;; ("/mailbox/[acc1].Bin"       . ?t)
					                                    ;; ("/mailbox/[acc1].All Mail"  . ?a)
					                                    ;; ("/mailbox/[acc1].Starred"   . ?r)
					                                    ;; ("/mailbox/[acc1].drafts"    . ?d)
					                                    ))))
         (make-mu4e-context
          :name "neel"
          :enter-func (lambda () (mu4e-message "Entering context neel"))
          :leave-func (lambda () (mu4e-message "Leaving context neel"))
          :match-func (lambda (msg)
		                    (when msg
		                      (mu4e-message-contact-field-matches
		                       msg '(:from :to :cc :bcc) "philip.heringlake@neel.cnrs.fr")))
          :vars '((user-mail-address      "philip.heringlake@neel.cnrs.fr")
                  (user-full-name         "Philip Heringlake")
	                (mu4e-sent-folder . "/neel/Sent")
	                (mu4e-drafts-folder . "/neel/Drafts")
	                (mu4e-trash-folder . "/neel/Trash")
	                (mu4e-compose-signature . (concat "Informal Signature\n" "Emacs is awesome!\n"))
	                (mu4e-compose-format-flowed . t)
	                ;; (smtpmail-queue-dir . "~/.mail/neel/queue/cur")
	                (message-send-mail-function . smtpmail-send-it)
	                (smtpmail-smtp-user . "philip.heringlake")
                  (smtpmail-stream-type 'ssl)
                  ;; (smtpmail-auth-credentials '(("smtps.grenoble.cnrs.fr" 465 "philip.heringlake@neel.cnrs.fr" nil)))
                  (smtpmail-default-smtp-server "smtps.grenoble.cnrs.fr")
                  (smtpmail-smtp-service 465)
	                ;; (smtpmail-starttls-credentials . (("smtp.gmail.com" 587 nil nil)))
	                (smtpmail-auth-credentials . (expand-file-name "~/.authinfo.gpg"))
	                (smtpmail-smtp-server . "smtp.grenoble.cnrs.fr")
	                (smtpmail-smtp-service . 465)
	                (smtpmail-debug-info . t)
	                (smtpmail-debug-verbose . t)
	                (mu4e-maildir-shortcuts . ( ("/neel/INBOX"            . ?i)
					                                    ;; ("/acc2-gmail/[acc2].Sent Mail" . ?s)
					                                    ;; ("/acc2-gmail/[acc2].Trash"     . ?t)
					                                    ;; ("/acc2-gmail/[acc2].All Mail"  . ?a)
					                                    ;; ("/acc2-gmail/[acc2].Starred"   . ?r)
					                                    ;; ("/acc2-gmail/[acc2].drafts"    . ?d)
					                                    ))))))




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



  ;; ;; spell check
  ;; (add-hook 'mu4e-compose-mode-hook
  ;;         (defun my-do-compose-stuff ()
  ;;            "My settings for message composition."
  ;;            (set-fill-column 72)
  ;;            (flyspell-mode)))
