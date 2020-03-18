;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Philip Heringlake"
      user-mail-address "p.heringlake@mailbox.com")
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "monospace" :size 14))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;;(setq display-line-numbers-type relative)
(setq show-trailing-whitespace t
      delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files"
)
(setq auto-save-default t
      auto-save-timeout 10
      auto-save-interval 180)
(setq auto-save-file-name-transforms
  `((".*" "~/.emacs-saves/" t)))
(use-package! popup-kill-ring)
(use-package! evil-collection
;    :after
;    (setq evil-want-keybinding nil)
    :config
    (evil-collection-init)
  )
(load! "bindings/spacemacs.el")
(map! :map org-mode-map
     :localleader
     :desc "Reference" "l r" #'org-ref-helm-insert-ref-link
;     (:prefix "o"
;       :desc "Tags" "t" 'org-set-tags
;       (:prefix ("p" . "Properties")
;         :desc "Set" "s" 'org-set-property
;         :desc "Delete" "d" 'org-delete-property
;         :desc "Actions" "a" 'org-property-action
;         )
;       )
     (:prefix ("i" . "Insert")
       :desc "Link/Image" "l" #'org-insert-link
       :desc "Reference" "r" #'org-ref-helm-insert-ref-link
       :desc "Item" "o" #'org-insert-item
       :desc "Footnote" "f" #'org-footnote-action
       :desc "Table" "t" #'org-table-create-or-convert-from-region
       :desc "Screenshot" "s" #'org-screenshot-take
       (:prefix ("h" . "Headings")
         :desc "Normal" "h" #'org-insert-heading
         :desc "Todo" "t" #'org-insert-todo-heading
         (:prefix ("s" . "Subheadings")
           :desc "Normal" "s" #'org-insert-subheading
           :desc "Todo" "t" #'org-insert-todo-subheading
           )
       )
))
(defun insert-todays-date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d-%m-%Y")
            (format-time-string "%Y-%m-%d"))))
(global-set-key (kbd "C-c d") 'insert-todays-date)
(use-package! company-tabnine
  )
(add-to-list 'company-backends #'company-tabnine)
(set-company-backend! 'org-mode
    'company-tabnine ;all purpose machine learning autocompleter
    'company-files          ; files & directory
         'company-keywords       ; keywords
         'company-capf
         'company-ispell
         'company-yasnippet)
(setq +lsp-company-backend '(company-lsp :with company-tabnine :separate))
;; Trigger completion immediately.
(setq company-idle-delay 0)
;; Number the candidates (use M-1, M-2 etc to select completions).
(setq company-show-numbers t)
(after! latex
(add-to-list
  'TeX-command-list
  '("latexmk_shellesc"
    "latexmk -shell-escape -bibtex -f -pdf %f"
    TeX-run-command
    nil                              ; ask for confirmation
    t                                ; active in all modes
    :help "Latexmk as for org"))

(setq LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)")))
)
(add-hook 'eshell-mode-hook #'hide-mode-line-mode)
(add-hook 'term-mode-hook #'hide-mode-line-mode)
(add-hook 'org-capture-mode-hook 'evil-insert-state)
(use-package! helm-org-rifle)
(setq org-directory "/home/philip/Documents/org/"
      org-archive-location (concat org-directory "archive/%s::")
      +org-capture-journal-file (concat org-directory "tagebuechlein.org.gpg"))
(after! org
  (setq org-log-done 'time))
(after! org
(add-hook 'org-mode-hook 'turn-on-org-cdlatex))
(after! org
  (setq org-export-with-toc nil))
(require 'ox-extra)
(ox-extras-activate '(latex-header-blocks ignore-headlines))
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(setq org-confirm-babel-evaluate nil
      org-use-speed-commands t
      org-catch-invisible-edits 'show)
(after! org
(setq org-capture-templates
    (append
     '(("w" "PhD work templates")
       ("wa"               ; key
        "Article"         ; name
        entry             ; type
        (file+headline "PhD.org.gpg" "Article")  ; target
        "* %^{Title} %(org-set-tags)  :article: \n:PROPERTIES:\n:Created: %U\n:Linked: %a\n:END:\n%i\nBrief description:\n%?"  ; template
        :prepend t        ; properties
        :empty-lines 1    ; properties
        :created t        ; properties
        )
       ("wt" "TODO template" entry
        (file+headline "PhD.org.gpg" "Capture")
        ( file "tpl_todo.txt" ) :empty-lines-before 1)
       ("wl" "Logbook entry" entry (file+datetree "phd_journal.org.gpg") "** %U - %^{Activity}  :LOG:")
       ("ww" "Link" entry (file+headline "PhD.org.gpg" "Links") "* %? %^L %^g \n%T" :prepend t)
       ("wn" "Note" entry (file+headline "PhD.org.gpg" "Notes")
        "* NOTE %?\n%U" :empty-lines 1)
       ("wN" "Note with Clipboard" entry (file+headline "PhD.org.gpg" "Notes")
        "* NOTE %?\n%U\n   %c" :empty-lines 1)
       ;; MEETING  (m) Meeting template
       ("wm" "MEETING   (m) Meeting" entry (file+headline "PhD.org.gpg" "Unsorted Meetings")
        "* %^{Meeting Title}
SCHEDULED: %^T
:PROPERTIES:
:Attend:   Philip Heringlake,
:Location:
:Agenda:
:Note:
:END:
:LOGBOOK:
- State \"MEETING\"    from \"\"           %U
:END:
%?" :empty-lines 1)
       ("bd" "Note" entry (file+headline "~/Documents/PhD-cloudless/Doctoriales.org" "notes")
        "* NOTE %?\n%U" :empty-lines 1)
       ("bw" "Link" entry (file+headline "~/Documents/PhD-cloudless/Doctoriales.org" "Notes") "* %? %^L %^g \n%T" :prepend t)
       ("wa" "Appointment (sync)" entry (file  "gcal-work.org" ) "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
       ("p" "Personal templates")
       ("pt" "TODO entry" entry
        (file+headline "personal.org" "Capture")
        ( file "tpl_todo.txt" ) :empty-lines-before 1)
       ("pl" "Logbook entry" entry (file+datetree "tagebuechlein.org.gpg") "** %U - %^{Activity}  :LOG:")
       ("pw" "Link" entry (file+headline "personal.org.gpg" "Links") "* %? %^L %^g \n%T" :prepend t)
       ("pn" "Note" entry (file+headline "personal.org.gpg" "Notes")
        "* NOTE %?\n%U" :empty-lines 1)
       ("pN" "Note with Clipboard" entry (file+headline "personal.org.gpg" "Notes")
        "* NOTE %?\n%U\n   %c" :empty-lines 1)
       ("pa" "Appointment (sync)" entry (file  "gcal.org" ) "* %?\n\n%^T\n\n:PROPERTIES:\n\n:END:\n\n")
       ("c" "Cooking Templates")
       ("cw" "Recipe from web" entry (file+headline "Kochbuch.org" "Unkategorisiert") "%(org-chef-get-recipe-from-url)" :empty-lines 1)
       ("cm" "Manual Recipe" entry (file+headline "Kochbuch.org" "Unkategorisiert")
        "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")
       ("d" "Drill")
       ("b" "Business")
       ("df" "French Vocabulary" entry
        (file+headline "drill/french.org" "Vocabulary")
        "* %^{The word} :drill:\n %t\n %^{Extended word (may be empty)} \n** Answer \n%^{The definition}"))
     org-capture-templates)))
(after! org
  (setq org-agenda-custom-commands
        '(("c" "Simple agenda view"
           ((agenda "")
            (alltodo ""))))))
(after! org-gcal
  (setq org-gcal-client-id "778561039072-m4jsg3lmr9eoihk79uouuucf9tug9agp.apps.googleusercontent.com"
        org-gcal-client-secret "UjB-Q-S09K2uZjHcoRIyPvNd"
        org-gcal-file-alist '(("naehmlich@gmail.com" .  "~/Documents/org/gcal.org")
                              ("rhcgeikr7l3umo3vk69rbn9nos@group.calendar.google.com" . "~/Documents/org/gcal-work.org")))
                              )
(setq org-log-into-drawer t)
(setq org-log-redeadline (quote note))
(setq org-log-reschedule (quote note))
(setq org-log-repeat (quote note))
(setq org-brain-path "~/Documents/org/brain")
(setq org-brain-visualize-default-choices 'all)
(setq org-brain-title-max-length 12)
(setq org-brain-include-file-entries nil
      org-brain-file-entries-use-title nil)
(require 'ob-async)
(add-to-list 'load-path "~/programs/julia")
(add-to-list 'exec-path "~/programs/julia")
(add-hook 'julia-mode-hook 'julia-repl-mode)
(after! emacs-jupyter
(setq inferior-julia-program-name "/home/philip/programs/julia/julia")
(add-hook 'ob-async-pre-execute-src-block-hook
          '(lambda ()
             (setq inferior-julia-program-name "/home/philip/programs/julia/julia")))
(setq ob-async-no-async-languages-alist '( "jupyter-python" "jupyter-julia" "julia" "python"))
(org-babel-jupyter-override-src-block "python")
;(setq jupyter-pop-up-frame t)
)
(defun jupyter-repl-font-lock-override (_ignore beg end &optional verbose)
  `(jit-lock-bounds ,beg . ,end))

(advice-add #'jupyter-repl-font-lock-fontify-region :override #'jupyter-repl-font-lock-override)
(setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block
(setq org-babel-default-header-args '((:eval . "never-export") (:results . "replace")))
(add-to-list 'org-latex-classes
             '("koma-article" "\\documentclass{scrartcl}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(add-to-list 'org-latex-classes
             '("mimosis"
               "\\documentclass{mimosis}
[NO-DEFAULT-PACKAGES]
[PACKAGES]
[EXTRA]"
               ("\\chapter{%s}" . "\\addchap{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
(setq org-latex-logfiles-extensions (quote ("lof" "lot" "tex" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "pygtex" "pygstyle")))
(setq org-latex-create-formula-image-program 'imagemagick)
(add-to-list 'org-latex-packages-alist '("" "minted" "xcolor"))
(setq org-latex-listings 'minted)
(setq org-latex-minted-options
  '(("bgcolor" "lightgray") ("linenos" "true") ("style" "tango")))
(setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))
(use-package! org-ref
    :after org
    :init
    ; code to run before loading org-ref
    :config
    ; code to run after loading org-ref
  ;; bibtex
  ;; somehow does not work
  ;;  ;; adjust note style
  ;; (defun my/org-ref-notes-function (candidates)
  ;;   (let ((key (helm-marked-candidates)))
  ;;     (funcall org-ref-notes-function (car key))))
  ;; '(helm-delete-action-from-source "Edit notes" helm-source-bibtex)
  ;; '(helm-add-action-to-source "Edit notes (org-ref)" 'my/org-ref-notes-function helm-source-bibtex 10)

  ;; does not work either
  ;; Tell org-ref to let helm-bibtex find notes for it
  (setq org-ref-notes-function
        (lambda (thekey)
	        (let ((bibtex-completion-bibliography (org-ref-find-bibliography)))
	          (bibtex-completion-edit-notes
	           (list (car (org-ref-get-bibtex-key-and-file thekey)))))))

  (setq org-ref-default-bibliography '("~/Documents/PhD/Literaturebib/library_org.bib")
        org-ref-pdf-directory "~/Documents/PhD/Literature/pdfs/"
        org-ref-bibliography-notes "~/Documents/PhD/Literaturebib/notes.org"
        org-ref-notes-directory "~/Documents/PhD/Literaturebib/notes/"
        reftex-default-bibliography '("~/Documents/PhD/Literaturebib/library_org.bib")
        ;;bibtex-completion-notes "~/Documents/PhD/Literature.bib/notes"
        bibtex-completion-notes-path "~/Documents/PhD/Literaturebib/notes.org"
        bibtex-completion-bibliography "~/Documents/PhD/Literaturebib/library_org.bib"
        bibtex-completion-library-path "~/Documents/PhD/Literature/pdfs")

  (setq bibtex-completion-find-additional-pdfs t)
  (setq org-ref-completion-library 'org-ref-ivy-cite)
  (setq org-ref-show-broken-links t)
  (setq org-latex-prefer-user-labels t)
    )
(use-package! org-noter
  :after (:any org pdf-view)
  :config
   (defun my/org-custom-id-get (&optional pom create prefix)
     "Get the CUSTOM_ID property of the entry at point-or-marker POM.
   If POM is nil, refer to the entry at point. If the entry does
   not have an CUSTOM_ID, the function returns nil. However, when
   CREATE is non nil, create a CUSTOM_ID if none is present
   already. PREFIX will be passed through to `org-id-new'. In any
   case, the CUSTOM_ID of the entry is returned."
     (interactive)
     (org-with-point-at pom
       (let ((id (org-entry-get nil "CUSTOM_ID")))
         (cond
          ((and id (stringp id) (string-match "\\S-" id))
           id)
          (create
           (setq id (org-id-new (concat prefix "h")))
           (org-entry-put pom "CUSTOM_ID" id)
           (org-id-add-location id (buffer-file-name (buffer-base-buffer)))
           id)))))
   (setq org-noter-always-create-frame nil)
   (defun make-noter-from-custom-id (&optional pom create prefix)
     "Get the CUSTOM_ID property of the entry at point-or-marker POM.
   If POM is nil, refer to the entry at point. If the entry does
   not have an CUSTOM_ID, the function returns nil. However, when
   CREATE is non nil, create a CUSTOM_ID if none is present
   already. PREFIX will be passed through to `org-id-new'. In any
   case, the CUSTOM_ID of the entry is returned."
     (interactive)
       (let ((id (org-entry-get (point) "Custom_ID" )))
         (setq pdfpath (concat "../Literature/pdfs/"  id ".pdf"))
           (org-entry-put (point) "NOTER_DOCUMENT" pdfpath)
           ))
  (setq
   ;; The WM can handle splits
   org-noter-notes-window-location 'other-frame
   ;; Please stop opening frames
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   org-noter-hide-other nil
   org-noter-notes-search-path "~/Documents/PhD/Literature.bib/notes"
   )
  )
(use-package! cdlatex
    :after (:any org-mode LaTeX-mode)
    :hook
    ((LaTeX-mode . turn-on-cdlatex)
     (org-mode . turn-on-org-cdlatex)))

(use-package! company-math
    :after (:any org-mode TeX-mode)
    :config
    (set-company-backend! 'org-mode 'company-math-symbols-latex)
    (set-company-backend! 'TeX-mode 'company-math-symbols-latex)
    (set-company-backend! 'org-mode 'company-latex-commands)
    (set-company-backend! 'TeX-mode 'company-latex-commands)
    (setq company-tooltip-align-annotations t)
    (setq company-math-allow-latex-symbols-in-faces t))
;; (add-to-list 'load-path "~/programs/beancount/editors/emacs")
  ;; (require 'beancount)
  (after! beancount
  (add-to-list 'auto-mode-alist '("\\.beancount\\'" . beancount-mode))  ;; Automatically open .beancount files in beancount-mode.
  (add-to-list 'auto-mode-alist '("\\.beancount$" . beancount-mode))
  (add-hook 'beancount-mode-hook 'outline-minor-mode))
(use-package! lsp-python-ms
  :ensure t
  :config
(setq lsp-pyls-server-command '("mspyls"))
  )
