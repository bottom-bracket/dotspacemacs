 ;; Some functionality uses this to identify you, e.g. GPG configuration, email
 ;; clients, file templates and snippets.
 (setq user-full-name "Philip Heringlake"
       user-mail-address "p.heringlake@mailbox.com")
 ;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
 ;; are the three important ones:
 ;;
 ;; + `doom-font'
 ;; + `dnction. This is the default:
(setq doom-theme 'doom-henna)
;; (setq doom-font (font-spec :family "Fira Code" :size 13 :weight 'normal))

(setq doom-font (font-spec :family "Fira Code" :size 14)
      doom-big-font (font-spec :family "Fira Code" :size 24)
      doom-variable-pitch-font (font-spec :family "Overpass" :size 16))
;; (custom-set-faces! '(variable-pitch :family "Minion Pro" :height 2.2))
;; (setq doom-variable-pitch-font (font-spec :family "Times New Roman" :weight 'normal))
 ;; If you use `org' and don't want your org files in the default location below,
 ;; change `org-directory'. It must be set before org loads!
 (setq org-directory "~/Documents/org/")
 ;; This determines the style of line numbers in effect. If set to `nil', line
 ;; numbers are disabled. For relative line numbers, set this to `relative'.
 ;;(setq display-line-numbers-type relative)
(setq display-line-number-width 4)
(setq display-line-numbers-type 'relative)
 (setq show-trailing-whitespace t
      delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files"
      window-combination-resize t
)
(delete-selection-mode 1)                         ; Replace selection when inserting text
(display-time-mode 1)                             ; Enable time in the mode-line
(display-battery-mode 1)                          ; On laptops it's nice to know how much power you have
(global-subword-mode 1)                           ; Iterate through CamelCase words
(use-package! popup-kill-ring)
(add-hook 'text-mode-hook #'auto-fill-mode)
;; (add-hook 'text-mode-hook #'refill-mode)
(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)
(after! ivy
  (ivy-set-actions
   'ivy-switch-buffer
   '(("-" evil-window-split "split horizontally")
     ("|" evil-window-vsplit "split vertically")))
  (ivy-set-actions
   'counsel-find-file
   '(("-" evil-window-split "split horizontally")
     ("|" evil-window-vsplit "split vertically"))))
(server-start)
(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
(doom-themes-treemacs-config)
(use-package! theme-magic)
(add-hook 'doom-load-theme-hook 'theme-magic-from-emacs)
(use-package! evil-collection
;    :after
;    (setq evil-want-keybinding nil)
    :config
    (evil-collection-init)
  )

(use-package! evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))
(map! :map org-mode-map
     :localleader
     :desc "Reference" "l r" #'org-ref-helm-insert-ref-link
     :desc "Toggle Link display" "L" #'org-toggle-link-display
     :desc "Toggle LaTeX fragment" "X" #'org-latex-preview
     :desc "Copy Email html to clipboard" "M" #'export-org-email
     :desc "Screenshot" "S" #'org-screenshot-take
     ;; :desc "Toggle Sidebar Tree" "m" #'org-sidebar-tree-toggle
     :desc "Org-Ref" "R" #'org-ref
;     (:prefix "o"
;       :desc "Tags" "t" 'org-set-tags
;       (:prefix ("p" . "Properties")
;         :desc "Set" "s" 'org-set-property
;         :desc "Delete" "d" 'org-delete-property
;         :desc "Actions" "a" 'org-property-action
;         )
;       )
     (:prefix ("j" . "Jupyter")
       :desc "Open Scratch Buffer" "s" #'org-babel-jupyter-scratch-buffer
       :desc "Restart Kernel Execute Block" "r" #'jupyter-org-restart-kernel-execute-block)
     (:prefix ("H" . "Headings")
         :desc "Normal Heading" "h" #'org-insert-heading
         :desc "Todo Heading" "H" #'org-insert-todo-heading
         :desc "Normal Subheading" "s" #'org-insert-subheading
         :desc "Todo Subheading" "S" #'org-insert-todo-subheading)
     )
;; (map! :map jupyter-org-interaction-mode-map
;;      :nv "gb" #'jupyter-eval-line-or-region)
(map! :after jupyter-org-client
      :map jupyter-org-interaction-mode-map
      :nv "gr" (cmd! (jupyter-org--call-with-src-block-client #'jupyter-eval-line-or-region))
      :desc "jupyter: hydra/body" ; dispatcher for everything else
        :nv "gb" #'jupyter-org-hydra/body
      )
(map! :map org-sidebar-tree-map
      "S-<return>" #'org-sidebar-tree-jump
      "S-RET" #'org-sidebar-tree-jump)
(use-package! helm-files
  :bind
  (:map helm-find-files-map
   ("C-h" . helm-find-files-up-one-level)
   ("C-l" . helm-execute-persistent-action))
)
(map! :leader
      (:prefix ("y" . "Useful Hydra Menus")
        :desc "Spelling" "s" #'hydra-spelling/body))
;; (map!
;;  (:prefix "z"
;;    :desc "evil/vimish-fold-toggle" "g" #'vimish-fold-toggle))
(map! :leader
     (:prefix "o"
       :desc "Ipython REPL" "i" #'+python/open-ipython-repl))
(map! :map python-mode-map
      :localleader
      (:prefix ("j" . "Jupyter Commands")
      :desc "Run new REPL" "r" #'jupyter-run-repl
      :desc "Associate Buffer to Jupyter REPL" "a" #'jupyter-repl-associate-buffer
      ))
(map! (:after python
   (:map python-mode-map
     :localleader
     :desc "Blacken buffer" "b" #'blacken-buffer)))
;; in my setup it is prior and next that are define the Page Up/Down buttons
(map!
 "<prior>" nil
 "<next>" nil
 "<PageDown>" nil
 "<PageUp>" nil)
(map! :leader
      :desc "Raise Popup Buffer" "w m r" #'+popup/raise
      )
(map! :leader
     (:desc "Smartparens Mode" "t k" #'smartparens-mode))
;; (map! :after smartparens-mode
;;       :ni "TAB" #'sp-up-sexp ;exit parentheses
;;       :ni "<tab>" #'sp-up-sexp ;exit parentheses
;;       )
(map! :leader
      (:desc "Agenda on Project .orgs" "o k" #'org-project-agenda))
;; (map! helm-map)
(after! (pdf-tools org-noter)
  (map! :map pdf-view-mode-map
        :n "i" #'org-noter-insert-note))
(after! (org-noter)
  (map! :map pdf-view-mode-map
        :n "i" #'org-noter-insert-note
        :n "M-p" #'org-noter-create-skeleton)
  )

;; :localleader
     ;; (:prefix ("s" . "Sync"))
     ;; :desc "Sync current note" "sc" #'org-noter-sync-current-note
     ;; :desc "Sync next note" "sn" #'org-noter-sync-next-note
     ;; :desc "Sync previous note" "sN" #'org-noter-sync-prev-note
     ;; :desc "Sync current page/chapter" "sp" #'org-noter-sync-current-page-or-chapter
     ;; :desc "Insert note" "I" #'org-noter-insert-note
     ;; :desc "Insert precise note" "p" #'org-noter-insert-precise-note
     ;; :desc "Kill noter session" "q" #'org-noter-kill-session)
(map! :leader
"o_" #'ranger)
(map! :n "j" #'evil-next-visual-line)
(map! :n "k" #'evil-previous-visual-line)
(map! :leader
      "sB" #'google-translate-at-point)
(map! :map ivy-minibuffer-map
      :g "TAB" #'ivy-partial-or-done)
(map! (:after company
( :map company-active-map
        "<tab>" nil
        "TAB" nil
        "C-SPC" 'company-complete-common-or-cycle)))
(defun org-get-target-headline (&optional targets prompt)
  "Prompt for a location in an org file and jump to it.

This is for promping for refile targets when doing captures.
Targets are selected from `org-refile-targets'. If TARGETS is
given it temporarily overrides `org-refile-targets'. PROMPT will
replace the default prompt message.

If CAPTURE-LOC is is given, capture to that location instead of
prompting."
  (let ((org-refile-targets (or targets org-refile-targets))
        (prompt (or prompt "Capture Location")))
    (if org-capture-overriding-marker
        (org-goto-marker-or-bmk org-capture-overriding-marker)
      (org-refile t nil nil prompt)))
  )

(defun org-ask-location ()
  (let* ((org-refile-targets '((nil :maxlevel . 9)))
         (hd (condition-case nil
                 (car (org-refile-get-location "Headline" nil t))
               (error (car org-refile-history)))))
    (goto-char (point-min))
    (outline-next-heading)
    (if (re-search-forward
         (format org-complex-heading-regexp-format (regexp-quote hd))
        nil t)
      (goto-char (point-at-bol))
      (goto-char (point-max))
      (or (bolp) (insert "\n"))
      (insert "* " hd "\n")))
    (end-of-line))
;; (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
(after! org
  (setq org-refile-use-outline-path nil))                  ; Show full paths for refiling
(defun insert-todays-date (arg)
  (interactive "P")
  (insert (if arg
              (format-time-string "%d-%m-%Y")
            (format-time-string "%Y-%m-%d"))))
(global-set-key (kbd "C-c d") 'insert-todays-date)
;; Show the current function name in the header line
(which-function-mode)
(setq-default header-line-format
              '((which-function-mode ("" which-func-format " "))))
(setq mode-line-misc-info
            ;; We remove Which Function Mode from the mode line, because it's mostly
            ;; invisible here anyway.
            (assq-delete-all 'which-function-mode mode-line-misc-info))
(defcustom org-html-image-base64-max-size #x40000
  "Export embedded base64 encoded images up to this size."
  :type 'number
  :group 'org-export-html)

(defun file-to-base64-string (file &optional image prefix postfix)
  "Transform binary file FILE into a base64-string prepending PREFIX and appending POSTFIX.
Puts \"data:image/%s;base64,\" with %s replaced by the image type before the actual image data if IMAGE is non-nil."
  (concat prefix
      (with-temp-buffer
        (set-buffer-multibyte nil)
        (insert-file-contents file nil nil nil t)
        (base64-encode-region (point-min) (point-max) 'no-line-break)
        (when image
          (goto-char (point-min))
          (insert (format "data:image/%s;base64," (image-type-from-file-name file))))
        (buffer-string))
      postfix))

(defun orgTZA-html-base64-encode-p (file)
  "Check whether FILE should be exported base64-encoded.
The return value is actually FILE with \"file://\" removed if it is a prefix of FILE."
  (when (and (stringp file)
             (string-match "\\`file://" file))
    (setq file (substring file (match-end 0))))
  (and
   (file-readable-p file)
   (let ((size (nth 7 (file-attributes file))))
     (<= size org-html-image-base64-max-size))
   file))

(defun orgTZA-html--format-image (source attributes info)
  "Return \"img\" tag with given SOURCE and ATTRIBUTES.
SOURCE is a string specifying the location of the image.
ATTRIBUTES is a plist, as returned by
`org-export-read-attribute'.  INFO is a plist used as
a communication channel."
  (if (string= "svg" (file-name-extension source))
      (org-html--svg-image source attributes info)
    (let* ((file (orgTZA-html-base64-encode-p source))
           (data (if file (file-to-base64-string file t)
                   source)))
      (org-html-close-tag
       "img"
       (org-html--make-attribute-string
        (org-combine-plists
         (list :src data
               :alt (if (string-match-p "^ltxpng/" source)
                        (org-html-encode-plain-text
                         (org-find-text-property-in-string 'org-latex-src source))
                      (file-name-nondirectory source)))
         attributes))
       info))))

(advice-add 'org-html--format-image :override #'orgTZA-html--format-image)

(defun export-org-email ()
  "Export the current org email and copy it to the clipboard"
  (interactive)
  (let ((org-export-show-temporary-export-buffer nil)
        (org-html-head (org-email-html-head)))
    (org-html-export-as-html)
    (with-current-buffer "*Org HTML Export*"
      (kill-new (buffer-string)))
    (message "HTML copied to clipboard")))

(defun org-email-html-head ()
  "Create the header with CSS for use with email"
  (concat
   "<style type=\"text/css\">\n"
   "<!--/*--><![CDATA[/*><!--*/\n"
   (with-temp-buffer
     (insert-file-contents
      "~/Documents/org/setupfiles/org-html-themes/styles/email/css/email.css")
     (buffer-string))
   "/*]]>*/-->\n"
   "</style>\n"))
(after! (:and flyspell abbrev)
  (setq flyspell-abbrev-p t))
(use-package abbrev
  :init
  (setq-default abbrev-mode t)
  ;; a hook funtion that sets the abbrev-table to org-mode-abbrev-table
  ;; whenever the major mode is a text mode
  (defun my/set-text-mode-abbrev-table ()
    (if (derived-mode-p 'text-mode)
        (setq local-abbrev-table org-mode-abbrev-table)))
  :commands abbrev-mode
  :hook
  (abbrev-mode . my/set-text-mode-abbrev-table)
  :config
  ;; (setq abbrev-file-name (expand-file-name "abbrev.el" doom-private-dir))
  (setq abbrev-file-name "~/.dotfiles/abbrev_defs.el")
  (setq save-abbrevs 'silently))
(defhydra hydra-spelling (:color blue)
  "
  ^
  ^Spelling^          ^Errors^            ^Checker^
  ^────────^──────────^──────^────────────^───────^───────
  _q_ quit            _p_ previous        _c_ correction
  ^^                  _n_ next            _d_ dictionary
  ^^                  _f_ check           _m_ mode
  ^^                  ^^                  ^^
  "
  ("q" nil)
  ("p" flyspell-correct-previous :color pink)
  ("n" flyspell-correct-next :color pink)
  ("c" ispell)
  ("d" ispell-change-dictionary)
  ("f" flyspell-buffer)
  ("m" flyspell-mode))
(defun org-project-agenda ()
  (interactive)
  (let ((org-agenda-files (doom-files-in (or (doom-project-root) default-directory) :match "\\.org$" :full t)))
    (call-interactively #'org-agenda)))
(defun my-phd-env-switch ()
(interactive)
  (setq org-roam-directory  "~/Documents/Research/zettel/")
  (setq org-id-extra-files (doom-files-in "~/Documents/Research" :match "\\.org$" :full t))
  (setq org-attach-id-dir  "~/Documents/Research/.org_attach/")
  (setq org-roam-encrypt-files nil))

(defun my-personal-env-switch ()
(interactive)
  (setq org-roam-directory  "~/Documents/org/zettel/")
  (setq org-id-extra-files nil)
  (setq org-attach-id-dir  "~/Documents/org/.org_attach/")
  (setq org-roam-encrypt-files t))
(defun reb-query-replace (to-string)
      "Replace current RE from point with `query-replace-regexp'."
      (interactive
       (progn (barf-if-buffer-read-only)
              (list (query-replace-read-to (reb-target-binding reb-regexp)
                                           "Query replace"  t))))
      (with-current-buffer reb-target-buffer
        (query-replace-regexp (reb-target-binding reb-regexp) to-string)))
(require 'cl-lib)
;  "List of Punctuation Marks that you want to count."
(defvar punctuation-marks '(","
                            "."
                            "'"
                            "&"
                            "\"")
  )

(defun count-raw-word-list (raw-word-list)
  (cl-loop with result = nil
           for elt in raw-word-list
           do (cl-incf (cdr (or (assoc elt result)
                             (first (push (cons elt 0) result)))))
           finally return (sort result
                                (lambda (a b) (string< (car a) (car b))))))

(defun word-stats ()
  (interactive)
  (let* ((words (split-string
                 (downcase (buffer-string))
                 (format "[ %s\f\t\n\r\v]+"
                         (mapconcat #'identity punctuation-marks ""))
                 t))
         (punctuation-marks (cl-remove-if-not
                             (lambda (elt) (member elt punctuation-marks))
                             (split-string (buffer-string) "" t )))
         (raw-word-list (append punctuation-marks words))
         (word-list (count-raw-word-list raw-word-list)))
    (with-current-buffer (get-buffer-create "*word-statistics*")
      (erase-buffer)
      (insert "| word | occurences |
               |-----------+------------|\n")

      (dolist (elt word-list)
        (insert (format "| '%s' | %d |\n" (car elt) (cdr elt))))

      (org-mode)
      (indent-region (point-min) (point-max))
      (goto-char 100)
      (org-cycle)
      (goto-char 79)
      (org-table-sort-lines nil ?N)))
  (pop-to-buffer "*word-statistics*"))
;; (use-package! company-tabnine
;;   )

(after! (:any company)
;; (setq-default company-backends
;;                 `((company-capf         ; `completion-at-point-functions'
;;                    :separate company-yasnippet
;;                    :separate company-keywords
;;                    :separate company-files)
;;                   company-ispell
;;                   company-dabbrev-code
;;                   company-files))

  (set-company-backend! 'text-mode
      '(:separate company-capf
        :separate company-ispell
        :separate company-yasnippet
        :separate company-files
     ))

(setq company-idle-delay 0.05)
(setq company-tooltip-idle-delay 0.05)
(setq company-box-doc-delay 1.2)
;; reduce prefix length (for lsp)
(setq company-minimum-prefix-length 2)
;; Number the candidates (use M-1, M-2 etc to select completions).
(setq company-show-numbers t)
(setq company-tooltip-align-annotations t)
)


(after! (:any org org-roam)
  (set-company-backend! 'org-mode
      '(
        :separate company-capf
        :separate company-ispell
        :separate company-org-roam
                  company-dabbrev
        :separate company-yasnippet
        :separate company-files
     )))
(use-package! company-math
:after TeX-mode
:config
(set-company-backend! 'TeX-mode
    '(:separate company-capf
    :separate company-auctex
    :separate company-math-symbols-latex))
(setq company-math-allow-latex-symbols-in-faces t))
(setq evil-escape-unordered-key-sequence t)
(after! helm
(setq helm-ff-auto-update-initial-value 1)
(setq helm-mode-fuzzy-match t)
(setq helm-completion-in-region-fuzzy-match t)
)
(after! ivy (setq ivy-read-action-function #'ivy-hydra-read-action))
(after! latex
(add-to-list
  'TeX-command-list
  '("latexmk_shellesc"
    "latexmk %(-PDF)%S%(mode) -shell-escape %(file-line-error) %(extraopts) %t"
    TeX-run-latexmk
    nil                              ; ask for confirmation
    t                                ; active in all modes
    :help "Latexmk as for org"))

;; (setq LaTeX-command-style '(("" "%(PDF)%(latex) -shell-escape %S%(PDFout)")))
)
(after! latex
  (add-hook 'LaTex-mode-hook 'turn-on-cdlatex))

(after! cdlatex
(map! :map cdlatex-mode-map
    :i "TAB" #'cdlatex-tab)
 (setq cdlatex-command-alist '(("ang"         "Insert \\ang{}"
                               "\\ang{?}" cdlatex-position-cursor nil t t)
                              ("si"          "Insert \\SI{}{}"
                               "\\SI{?}{}" cdlatex-position-cursor nil t t)
                              ("sl"          "Insert \\SIlist{}{}"
                               "\\SIlist{?}{}" cdlatex-position-cursor nil t t)
                              ("sr"          "Insert \\SIrange{}{}{}"
                               "\\SIrange{?}{}{}" cdlatex-position-cursor nil t t)
                              ("num"         "Insert \\num{}"
                               "\\num{?}" cdlatex-position-cursor nil t t)
                              ("nl"          "Insert \\numlist{}"
                               "\\numlist{?}" cdlatex-position-cursor nil t t)
                              ("nr"          "Insert \\numrange{}{}"
                               "\\numrange{?}{}" cdlatex-position-cursor nil t t)))
)
;; Latex viewers
;(after! latex
(setq +latex-viewers '(pdf-tools okular))
; )
;; Use pdf-tools to open PDF files
(setq TeX-view-program-selection '((output-pdf "PDF Tools"))
      TeX-source-correlate-start-server t)

;; Update PDF buffers after successful LaTeX runs
(add-hook 'TeX-after-compilation-finished-functions
          #'TeX-revert-document-buffer)
(add-hook 'eshell-mode-hook #'hide-mode-line-mode)
(add-hook 'term-mode-hook #'hide-mode-line-mode)
(add-hook 'org-capture-mode-hook 'evil-insert-state)
(use-package! helm-org-rifle)
(after! org
(setq org-archive-location (concat org-directory "archive/%s::")
      +org-capture-journal-file (concat org-directory "tagebuechlein.org.gpg")))
(after! org
  (setq org-log-done 'time))
(after! (:all org cdlatex)
(add-hook 'org-mode-hook 'turn-on-org-cdlatex))
(after! evil-org
  (remove-hook 'org-tab-first-hook #'+org-cycle-only-current-subtree-h))
(setq org-goto-interface 'outline-path-completion
      org-goto-max-level 10)
(setq org-image-actual-width '(400))
(after! org
  (set-popup-rule! "^\\*Org Src*" :side 'right :size 0.5))
(after! org
(setq org-superstar-prettify-item-bullets t))
(custom-set-faces!
  '(outline-1 :weight extra-bold :height 1.6 :underline t)
  '(outline-2 :weight bold :height 1.5)
  '(outline-3 :weight bold :height 1.4)
  '(outline-4 :weight semi-bold :height 1.4)
  '(outline-5 :weight semi-bold :height 1.3)
  '(outline-6 :weight semi-bold :height 1.2)
  '(outline-7 :weight semi-bold :height 1.2)
  '(outline-8 :weight semi-bold :height 1.1)
  '(outline-9 :weight semi-bold :height 1.1)
  '(outline-10 :weight semi-bold :height 1.1))
(load "~/.dotfiles/.doom.d/lisp/org-macros.el")
(add-hook 'org-mode-hook #'mixed-pitch-mode)
(after! org
    (setq org-pretty-entities-include-sub-superscripts nil)
)
(add-hook! org-mode +org-pretty-mode)
(use-package! org-preview-html)
(after! org
  (setq org-export-with-toc nil
        org-export-in-background t ))
  (require 'ox-extra)
  (ox-extras-activate '(latex-header-blocks ignore-headlines))
  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
(setq org-confirm-babel-evaluate nil
      org-use-speed-commands t
      org-catch-invisible-edits 'show)
(defvar org-heading-contraction-max-words 3
  "Maximum number of words in a heading")
(defvar org-heading-contraction-max-length 35
  "Maximum length of resulting string")
(defvar org-heading-contraction-stripped-words
  '("the" "on" "in" "off" "a" "for" "by" "of" "and" "is" "to")
  "Unnecesary words to be removed from a heading")

(defun org-heading-contraction (heading-string)
  "Get a contracted form of HEADING-STRING that is onlu contains alphanumeric charachters.
Strips 'joining' words in `org-heading-contraction-stripped-words',
and then limits the result to the first `org-heading-contraction-max-words' words.
If the total length is > `org-heading-contraction-max-length' then individual words are
truncated to fit within the limit"
  (let ((heading-words
         (-filter (lambda (word)
                    (not (member word org-heading-contraction-stripped-words)))
                  (split-string
                   (->> heading-string
                        s-downcase
                        (replace-regexp-in-string "\\[\\[[^]]+\\]\\[\\([^]]+\\)\\]\\]" "\\1") ; get description from org-link
                        (replace-regexp-in-string "[-/ ]+" " ") ; replace seperator-type chars with space
                        (replace-regexp-in-string "[^a-z0-9 ]" "") ; strip chars which need %-encoding in a uri
                        ) " "))))
    (when (> (length heading-words)
             org-heading-contraction-max-words)
      (setq heading-words
            (subseq heading-words 0 org-heading-contraction-max-words)))

    (when (> (+ (-sum (mapcar #'length heading-words))
                (1- (length heading-words)))
             org-heading-contraction-max-length)
      ;; trucate each word to a max word length determined by
      ;;   max length = \floor{ \frac{total length - chars for seperators - \sum_{word \leq average length} length(word) }{num(words) > average length} }
      (setq heading-words (let* ((total-length-budget (- org-heading-contraction-max-length  ; how many non-separator chars we can use
                                                         (1- (length heading-words))))
                                 (word-length-budget (/ total-length-budget                  ; max length of each word to keep within budget
                                                        org-heading-contraction-max-words))
                                 (num-overlong (-count (lambda (word)                             ; how many words exceed that budget
                                                         (> (length word) word-length-budget))
                                                       heading-words))
                                 (total-short-length (-sum (mapcar (lambda (word)                 ; total length of words under that budget
                                                                     (if (<= (length word) word-length-budget)
                                                                         (length word) 0))
                                                                   heading-words)))
                                 (max-length (/ (- total-length-budget total-short-length)   ; max(max-length) that we can have to fit within the budget
                                                num-overlong)))
                            (mapcar (lambda (word)
                                      (if (<= (length word) max-length)
                                          word
                                        (substring word 0 max-length)))
                                    heading-words))))
    (string-join heading-words "-")))
(define-minor-mode unpackaged/org-export-html-with-useful-ids-mode
  "Attempt to export Org as HTML with useful link IDs.
Instead of random IDs like \"#orga1b2c3\", use heading titles,
made unique when necessary."
  :global t
  (if unpackaged/org-export-html-with-useful-ids-mode
      (advice-add #'org-export-get-reference :override #'unpackaged/org-export-get-reference)
    (advice-remove #'org-export-get-reference #'unpackaged/org-export-get-reference)))

(defun unpackaged/org-export-get-reference (datum info)
  "Like `org-export-get-reference', except uses heading titles instead of random numbers."
  (let ((cache (plist-get info :internal-references)))
    (or (car (rassq datum cache))
        (let* ((crossrefs (plist-get info :crossrefs))
               (cells (org-export-search-cells datum))
               ;; Preserve any pre-existing association between
               ;; a search cell and a reference, i.e., when some
               ;; previously published document referenced a location
               ;; within current file (see
               ;; `org-publish-resolve-external-link').
               ;;
               ;; However, there is no guarantee that search cells are
               ;; unique, e.g., there might be duplicate custom ID or
               ;; two headings with the same title in the file.
               ;;
               ;; As a consequence, before re-using any reference to
               ;; an element or object, we check that it doesn't refer
               ;; to a previous element or object.
               (new (or (cl-some
                         (lambda (cell)
                           (let ((stored (cdr (assoc cell crossrefs))))
                             (when stored
                               (let ((old (org-export-format-reference stored)))
                                 (and (not (assoc old cache)) stored)))))
                         cells)
                        (when (org-element-property :raw-value datum)
                          ;; Heading with a title
                          (unpackaged/org-export-new-title-reference datum cache))
                        ;; NOTE: This probably breaks some Org Export
                        ;; feature, but if it does what I need, fine.
                        (org-export-format-reference
                         (org-export-new-reference cache))))
               (reference-string new))
          ;; Cache contains both data already associated to
          ;; a reference and in-use internal references, so as to make
          ;; unique references.
          (dolist (cell cells) (push (cons cell new) cache))
          ;; Retain a direct association between reference string and
          ;; DATUM since (1) not every object or element can be given
          ;; a search cell (2) it permits quick lookup.
          (push (cons reference-string datum) cache)
          (plist-put info :internal-references cache)
          reference-string))))

(defun unpackaged/org-export-new-title-reference (datum cache)
  "Return new reference for DATUM that is unique in CACHE."
  (cl-macrolet ((inc-suffixf (place)
                             `(progn
                                (string-match (rx bos
                                                  (minimal-match (group (1+ anything)))
                                                  (optional "--" (group (1+ digit)))
                                                  eos)
                                              ,place)
                                ;; HACK: `s1' instead of a gensym.
                                (-let* (((s1 suffix) (list (match-string 1 ,place)
                                                           (match-string 2 ,place)))
                                        (suffix (if suffix
                                                    (string-to-number suffix)
                                                  0)))
                                  (setf ,place (format "%s--%s" s1 (cl-incf suffix)))))))
    (let* ((title (org-element-property :raw-value datum))
           ;; get ascii-only form of title without needing percent-encoding
           (ref (org-heading-contraction (substring-no-properties title)))
           (parent (org-element-property :parent datum)))
      (while (--any (equal ref (car it))
                    cache)
        ;; Title not unique: make it so.
        (if parent
            ;; Append ancestor title.
            (setf title (concat (org-element-property :raw-value parent)
                                "--" title)
                  ;; get ascii-only form of title without needing percent-encoding
                  ref (org-heading-contraction (substring-no-properties title))
                  parent (org-element-property :parent parent))
          ;; No more ancestors: add and increment a number.
          (inc-suffixf ref)))
      ref)))

(add-hook 'org-load-hook #'unpackaged/org-export-html-with-useful-ids-mode)
(after! org
  (setq org-capture-templates
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
          ("wf" "Link file in index" entry
           (file+function "~/Documents/Research/index.org" org-ask-location)
           "** %A \n:PROPERTIES:\n:Created: %U \n:FromDate: %^u \n:Linked: %f\n:END: \n %^g %?"
           :empty-lines 1
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
           (file+headline "personal.org.gpg" "Capture")
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
        ))
(use-package! org-super-agenda
  :commands (org-super-agenda-mode))
(defvar my-org-agenda-files-personal '("~/Documents/org/PhD.org.gpg" "~/Documents/Research/index.org"  "~/Documents/org/personal.org.gpg" "~/Documents/org/gcal.org" ))
(defvar my-org-agenda-files-professional '("~/Documents/org/PhD.org.gpg" "~/Documents/Research/index.org" ))
;; (setq org-agenda-files (append my-org-agenda-files-personal (doom-files-in "~/Documents/Research" :match "\\.org$" :full t)))
(setq org-agenda-files my-org-agenda-files-personal)

;; (after! org
;;   (setq
;;         org-agenda-files my-org-agenda-files-personal
;;         ))
(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
           ((agenda "")
            (alltodo "")))
        ("o" "Overview"
         ((agenda "" ((org-agenda-span 'day)
                      (org-super-agenda-groups
                       '((:name "Today"
                                :time-grid t
                                :date today
                                :todo "TODAY"
                                :scheduled today
                                :order 1)))))
          (alltodo "" ((org-agenda-overriding-header "")
                       (org-super-agenda-groups
                        '((:name "Next to do"
                                 :todo "NEXT"
                                 :order 1)
                          (:name "Important"
                                 :tag "Important"
                                 :priority "A"
                                 :order 6)
                          (:name "Due Today"
                                 :deadline today
                                 :order 2)
                          (:name "Due Soon"
                                 :deadline future
                                 :order 8)
                          (:name "Overdue"
                                 :deadline past
                                 :face error
                                 :order 7)
                          (:name "Research"
                                 :tag "Research"
                                 :order 10)
                          (:name "Issues"
                                 :tag "Issue"
                                 :order 12)
                          (:name "Emacs"
                                 :tag "Emacs"
                                 :order 13)
                          (:name "Projects"
                                 :tag "Project"
                                 :order 14)
                          (:name "To read"
                                 :tag "Read"
                                 :order 30)
                          (:name "Waiting"
                                 :todo "WAITING"
                                 :order 20)
                          (:name "Trivial"
                                 :priority<= "E"
                                 :tag ("Trivial" "Unimportant")
                                 :todo ("SOMEDAY" )
                                 :order 90)
                          (:discard (:tag ("Routine" "Daily")))))))))))
(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-tags-column 100 ;; from testing this seems to be a good value
      org-agenda-compact-blocks t)
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
(after! org-download
  (setq org-download-image-dir "./img/"
        org-download-heading-lvl 0
        org-download-method 'directory))
  (setq org-brain-path "~/Documents/org/brain")
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12)
  (setq org-brain-include-file-entries nil
        org-brain-file-entries-use-title nil)
(after! org-roam
  (setq org-roam-directory "~/Documents/org/zettel/")
  (setq org-roam-encrypt-files t)
  (setq org-roam-link-title-format "R:%s")
  )
(setq org-roam-capture-templates
      '(("d" "default" plain (function org-roam-capture--get-point)
         "- tags :: %?\n- source :: \n"
         :file-name "${slug}-%<%Y%m%d%H%M%S>"
         :head "#+TITLE: ${title}\n"
         :unnarrowed t)))
(setq org-roam-capture-ref-templates
      '(("r" "ref" plain #'org-roam-capture--get-point
         "- tags :: ${tags}\n\n %?"
         :file-name "${slug}-%<%Y%m%d%H%M%S>"
         :head
         "#+TITLE: ${title}\n#+ROAM_KEY: ${ref}\n"
         :unnarrowed t)))
(use-package! org-roam-server)
(add-to-list 'org-structure-template-alist '("j" . "src jupyter-python"))
;; (add-hook! org-mode
;;            #'(lambda ()
;;                (push '("#+begin_src" . "λ") prettify-symbols-alist)
;;                (push '("#+end_src" . "λ") prettify-symbols-alist)
;;                (push '("#+begin_example" . "⁈") prettify-symbols-alist)
;;                (push '("#+end_example" . "⁈") prettify-symbols-alist)
;;                (push '("#+begin_quote" . "“") prettify-symbols-alist)
;;                (push '("#+end_quote" . "”") prettify-symbols-alist)
;;                (push '("#+begin_export" . "->") prettify-symbols-alist)
;;                (push '("#+end_export" . "<-") prettify-symbols-alist)
;;                (push '("jupyter-python" . "") prettify-symbols-alist)
;;                (push '("#+RESULTS:" . "=") prettify-symbols-alist)
;;                (push '(":results" . "=") prettify-symbols-alist)
;;                (push '(":dir" . "") prettify-symbols-alist)
;;                (push '(":session" . "@") prettify-symbols-alist)
;;                (setq line-spacing 4)
;;                (prettify-symbols-mode)))
  (require 'ob-async)
;; (add-to-list 'org-src-lang-modes '("mathematica" . wolfram))
;; (add-hook! org-mode
;;   (jupyter-org-interaction-mode))
(after! ob-jupyter
  (require 'jupyter-org-client)
  (jupyter-org-interaction-mode 1))
  (add-to-list 'load-path "~/programs/julia")
  (add-to-list 'exec-path "~/programs/julia")
  (add-hook 'julia-mode-hook 'julia-repl-mode)
  (setq inferior-julia-program-name "/home/philip/programs/julia/julia")
  (add-hook 'ob-async-pre-execute-src-block-hook
            '(lambda ()
               (setq inferior-julia-program-name "/home/philip/programs/julia/julia")))
  (setq ob-async-no-async-languages-alist '( "jupyter-python" "jupyter-julia" "julia" "python"))
  (setq jupyter-pop-up-frame nil)
  (setq jupyter-eval-use-overlays t)
  (setq org-babel-default-header-args:jupyter-python '((:async . "yes")
                                                       (:kernel . "python3")))
(defun jupyter-repl-font-lock-override (_ignore beg end &optional verbose)
  `(jit-lock-bounds ,beg . ,end))

(advice-add #'jupyter-repl-font-lock-fontify-region :override #'jupyter-repl-font-lock-override)
(defadvice! fixed-zmq-start-process (orig-fn &rest args)
  :around #'zmq-start-process
  (letf! (defun make-process (&rest plist)
           (plist-put! plist :coding (plist-get plist :coding-system))
           (plist-delete! plist :coding-system)
           (apply make-process plist))
    (apply orig-fn args)))
  (setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block
  (setq org-babel-default-header-args '((:eval . "never-export")
                                        (:results . "replace")
                                        ))
(org-babel-lob-ingest "~/Documents/org/scripts.org")
(cl-defmacro lsp-org-babel-enable (lang)
    "Support LANG in org source code block."
    (setq centaur-lsp 'lsp-mode)
    (cl-check-type lang stringp)
    (let* ((edit-pre (intern (format "org-babel-edit-prep:%s" lang)))
           (intern-pre (intern (format "lsp--%s" (symbol-name edit-pre)))))
      `(progn
         (defun ,intern-pre (info)
           (let ((file-name (->> info caddr (alist-get :file))))
             (unless file-name
               (setq file-name (make-temp-file "babel-lsp-")))
             (setq buffer-file-name file-name)
              (lsp-deferred)))
         (put ',intern-pre 'function-documentation
              (format "Enable lsp-mode in the buffer of org source block (%s)."
                      (upcase ,lang)))
         (if (fboundp ',edit-pre)
             (advice-add ',edit-pre :after ',intern-pre)
           (progn
             (defun ,edit-pre (info)
               (,intern-pre info))
             (put ',edit-pre 'function-documentation
                  (format "Prepare local buffer environment for org source block (%s)."
                          (upcase ,lang))))))))
  (defvar org-babel-lang-list
    '("python" "ipython" "bash" "sh"))
  (dolist (lang org-babel-lang-list)
    (eval `(lsp-org-babel-enable ,lang)))
(after! ox (require 'ox-koma-letter))
     (add-to-list 'org-latex-classes
                  '("koma-article" "\\documentclass{scrartcl}"
                    ("\\section{%s}" . "\\section*{%s}")
                    ("\\subsection{%s}" . "\\subsection*{%s}")
                    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                    ("\\paragraph{%s}" . "\\paragraph*{%s}")
                    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  ;; Mimore class is a latex class for writing articles.
  (add-to-list 'org-latex-classes
               '("mimore"
                 "\\documentclass{mimore}
 [NO-DEFAULT-PACKAGES]
 [PACKAGES]
 [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

  ;; Mimosis is a class I used to write my Ph.D. thesis.
  (add-to-list 'org-latex-classes
               '("mimosis"
                 "\\documentclass{mimosis}
 [NO-DEFAULT-PACKAGES]
 [PACKAGES]
 [EXTRA]
\\newcommand{\\mboxparagraph}[1]{\\paragraph{#1}\\mbox{}\\\\}
\\newcommand{\\mboxsubparagraph}[1]{\\subparagraph{#1}\\mbox{}\\\\}"
                 ("\\chapter{%s}" . "\\chapter*{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\mboxparagraph{%s}" . "\\mboxparagraph*{%s}")
                 ("\\mboxsubparagraph{%s}" . "\\mboxsubparagraph*{%s}")))

  ;; Elsarticle is Elsevier class for publications.
  (add-to-list 'org-latex-classes
               '("elsarticle"
                 "\\documentclass{elsarticle}
 [NO-DEFAULT-PACKAGES]
 [PACKAGES]
 [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
   (setq org-latex-logfiles-extensions (quote ("lof" "lot" "bcf" "run.xml" "xdv" "synctex.gz" "aux" "idx" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "pygtex" "pygstyle")))
(setq org-latex-default-packages-alist
  '(("AUTO" "inputenc"  t ("pdflatex"))
    ("T1"   "fontenc"   t ("pdflatex"))
    (""     "graphicx"  t)
    ;; (""     "grffile"   t) ; still in standard org packages but it became useless with new texlive
    (""     "longtable" nil)
    (""     "wrapfig"   nil)
    (""     "rotating"  nil)
    ("normalem" "ulem"  t)
    (""     "amsmath"   t)
    (""     "textcomp"  t)
    (""     "amssymb"   t)
    (""     "capt-of"   nil)
    (""     "hyperref"  nil)))
(setq org-latex-packages-alist '(
                                 ("" "minted" t)
                                 ("" "xcolor" t)
                                 ("binary-units=true" "siunitx" t)
                                 ("" "nicefrac" t)))
(setq org-latex-listings 'minted)
(setq org-latex-minted-options
  '(("bgcolor" "lightgray")
    ("linenos" "true")
    ("style" "tango")
    ("frame" "lines")
    ("fontsize" "\\scriptsize")
    ("linenos" "")
    ("breakanywhere" "true")
    ("breakautoindent" "true")
    ("breaklines" "true")
    ("autogobble" "true")
    ("obeytabs" "true")
    ("python3" "true")
    ("breakbefore" "\\\\\\.+")
    ("breakafter" "\\,")
    ("breaksymbol" "\\tiny\\ensuremath{\\hookrightarrow}")
    ("breakanywheresymbolpre" "\\,\\footnotesize\\ensuremath{{}_{\\rfloor}}")
    ("breakbeforesymbolpre" "\\,\\footnotesize\\ensuremath{{}_{\\rfloor}}")
    ("breakaftersymbolpre" "\\,\\footnotesize\\ensuremath{{}_{\\rfloor}}")
    ))
;; (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))
(setq org-latex-pdf-process (list "latexmk -pdflatex='%latex -shell-escape -interaction nonstopmode' -bibtex -f -pdf -output-directory=%o %f"))
(setq org-latex-text-markup-alist '((bold . "\\textbf{%s}")
           (code . protectedtexttt)
           (italic . "\\emph{%s}")
           (strike-through . "\\sout{%s}")
           (underline . "\\uline{%s}")
           (verbatim . verb)))
  (setq org-latex-prefer-user-labels t)
(setq org-beamer-theme "[progressbar=foot]metropolis")

(setq org-beamer-frame-level 2)
(use-package! ox-pandoc)
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

  (setq org-ref-default-bibliography '("~/Documents/PhD/Literaturebib/library_zotero.bib")
        ;; org-ref-pdf-directory "~/Documents/PhD/Literature/pdfs/"
        ;; org-ref-bibliography-notes "~/Documents/PhD/Literaturebib/notes.org"
        org-ref-notes-directory "~/Documents/Research/zettel/biblio/"
        reftex-default-bibliography '("~/Documents/PhD/Literaturebib/library_zotero.bib")
        bibtex-completion-notes-path "~/Documents/Research/zettel/biblio/"
        bibtex-completion-bibliography "~/Documents/PhD/Literaturebib/library_zotero.bib"
        ;; bibtex-completion-library-path "~/Documents/PhD/Literature/pdfs"
        bibtex-completion-library-path "~/Zotero/storage/"
        org-ref-note-title-format "* TODO %y - %t\n :PROPERTIES:\n  :Custom_ID: %k\n  :NOTER_DOCUMENT: %F\n :ROAM_KEY: cite:%k\n  :AUTHOR: %9a\n  :JOURNAL: %j\n  :YEAR: %y\n  :VOLUME: %v\n  :PAGES: %p\n  :DOI: %D\n  :URL: %U\n :END:\n\n"
        )
  (setq bibtex-completion-pdf-field "file") ;; if non nil looks for pdf file field in bibtex entry and openes that pdf
  ;; (setq bibtex-completion-find-additional-pdfs t)
  (setq org-ref-completion-library 'org-ref-ivy-cite)
  (setq org-ref-show-broken-links t)

  ;; (defun org-ref-open-pdf-at-point-in-emacs ()
  ;;   "Open the pdf for bibtex key under point if it exists."
  ;;   (interactive)
  ;;   (let* ((results (org-ref-get-bibtex-key-and-file))
  ;;          (key (car results))
  ;;          (pdf-file (funcall org-ref-get-pdf-filename-function key)))
  ;;     (if (file-exists-p pdf-file)
  ;;         (find-file-other-window pdf-file)
  ;;       (message "no pdf found for %s" key))))

;; for use with zotero
    (defun my/org-ref-open-pdf-at-point ()
    "Open the pdf for bibtex key under point if it exists."
    (interactive)
    (let* ((results (org-ref-get-bibtex-key-and-file))
            (key (car results))
        (pdf-file (car (bibtex-completion-find-pdf key))))
        (if (file-exists-p pdf-file)
        (org-open-file pdf-file)
        (message "No PDF found for %s" key))))

    (setq org-ref-open-pdf-function 'my/org-ref-open-pdf-at-point)


  (defun org-ref-open-in-scihub ()
    "Open the bibtex entry at point in a browser using the url field or doi field.
Not for real use, just here for demonstration purposes."
    (interactive)
    (let ((doi (org-ref-get-doi-at-point)))
      (when doi
        (if (string-match "^http" doi)
            (browse-url doi)
          (browse-url (format "http://sci-hub.se/%s" doi)))
        (message "No url or doi found"))))

  ;; (helm-add-action-to-source "Grep PDF" 'org-ref-grep-pdf helm-source-bibtex 1)

;; https://write.as/dani/notes-on-org-noter provides a solution to open org
;; noter on a cite link

(defun org-ref-noter-at-point () "Open the pdf for bibtex key under point if it
      exists." (interactive) (let* ((results (org-ref-get-bibtex-key-and-file))
      (key (car results)) (pdf-file (funcall org-ref-get-pdf-filename-function
      key))) (if (file-exists-p pdf-file) (progn (find-file-other-window
      pdf-file) (org-noter)) (message "no pdf found for %s" key))))


(add-to-list 'org-ref-helm-user-candidates '("Org-Noter notes" . org-ref-noter-at-point))
(add-to-list 'org-ref-helm-user-candidates '("Open in Sci-hub" . org-ref-open-in-scihub))
(add-to-list 'org-ref-helm-user-candidates '("Open in Emacs" . org-ref-open-pdf-at-point-in-emacs)))
(setq ivy-bibtex-default-action 'ivy-bibtex-insert-key)
(after! org
(setq org-id-link-to-org-use-id 'create-if-interactive-and-no-custom-id))
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
   org-noter-notes-window-location 'horizontal-split
   ;; Please stop opening frames
   org-noter-always-create-frame nil
   ;; I want to see the whole file
   org-noter-hide-other nil
   org-noter-notes-search-path '("~/Documents/Research/zettel/biblio")
   )
  )
(use-package! org-sidebar
  :config
  (setq org-sidebar-tree-jump-fn #'org-sidebar-tree-jump-source))
(use-package! org-mime)
(use-package! org-journal
  :custom
   (org-journal-date-prefix "#+DATE:")
   (org-journal-date-format "%A, %d %B %Y")
   (org-journal-file-format "%Y-%m-%d.org")
   (org-journal-dir "~/Documents/Research/zettel/")
  :config
   (setq org-journal-file-type 'daily)
   (setq org-journal-enable-encryption nil)
   (setq org-journal-enable-agenda-integration t)
   (setq org-journal-carryover-items "TODO=\"TODO\"|TODO=\"STRT\"|TODO=\"WAIT\"|TODO=\"[ ]\"TODO=\"[-]\"")
)
(after! deft
  (setq deft-recursive t
        deft-use-filter-string-for-filename t
        deft-default-extension "org"
        deft-extensions '("org" "txt" "tex" "md" "markdown" "gpg")
        deft-directory org-roam-directory))
(after! org
  (appendq! +pretty-code-symbols
            '(:checkbox     "☐"
              :pending      "◼"
              :checkedbox   "☑"
              :results      "🠶"
              :property     "☸"
              :properties   "⚙"
              :logbook      "📘"
              :end          "∎"
              :options      "⌥"
              :title        "𝙏"
              :email        "⟰"
              :author       "𝘼"
              :date         "𝘿"
              :latex_header "⇥"
              :begin_quote  "❮"
              :end_quote    "❯"
              :begin_export "⯮"
              :end_export "⯬"
              :jupyter-python ""
              :em_dash      "—"))
  (set-pretty-symbols! 'org-mode
    :merge t
    :checkbox     "[ ]"
    :pending      "[-]"
    :checkedbox   "[X]"
    :results      "#+RESULTS:"
    :property     "#+PROPERTY:"
    :properties   ":PROPERTIES:"
    :logbook      ":LOGBOOK:"
    :end          ":END:"
    :options      "#+OPTIONS:"
    :title        "#+TITLE:"
    :email        "#+EMAIL:"
    :author       "#+AUTHOR:"
    :date         "#+DATE:"
    :latex_header "#+LATEX_HEADER:"
    :begin_quote  "#+BEGIN_QUOTE"
    :end_quote    "#+END_QUOTE"
    :begin_export "#+BEGIN_EXPORT"
    :end_export   "#+END_EXPORT"
    :jupyter-python "jupyter-python"
    :em_dash      "---")
)
(plist-put +pretty-code-symbols :name "⁍") ; or › could be good?
(add-hook 'org-mode-hook 'org-fragtog-mode)
(setq org-preview-latex-default-process 'dvipng)
(after! org
  (setq org-highlight-latex-and-related '(native script entities)))
(setq org-format-latex-header "\\documentclass[8pt]{article}
\\usepackage[usenames]{color}

\\usepackage[T1]{fontenc}
\\usepackage{mathtools}
\\usepackage{textcomp,amssymb}
\\usepackage[makeroom]{cancel}

\\pagestyle{empty}             % do not remove
% The settings below are copied from fullpage.sty
\\setlength{\\textwidth}{\\paperwidth}
\\addtolength{\\textwidth}{-3cm}
\\setlength{\\oddsidemargin}{1.5cm}
\\addtolength{\\oddsidemargin}{-2.54cm}
\\setlength{\\evensidemargin}{\\oddsidemargin}
\\setlength{\\textheight}{\\paperheight}
\\addtolength{\\textheight}{-\\headheight}
\\addtolength{\\textheight}{-\\headsep}
\\addtolength{\\textheight}{-\\footskip}
\\addtolength{\\textheight}{-3cm}
\\setlength{\\topmargin}{1.5cm}
\\addtolength{\\topmargin}{-2.54cm}
% my custom stuff
\\usepackage{arev}
\\usepackage{arevmath}")
;; (after! org
;; make background of fragments transparent
  ;; (let ((dvipng--plist (alist-get 'dvipng org-preview-latex-process-alist)))
  ;;   (plist-put dvipng--plist :use-xcolor t)
  ;;   (plist-put dvipng--plist :image-converter '("dvipng -D %D -bg 'transparent' -T tight -o %O %f")))
;;   (add-hook! 'doom-load-theme-hook
;;     (defun +org-refresh-latex-background ()
;;       (plist-put! org-format-latex-options
;;                   :background
;;                   (face-attribute (or (cadr (assq 'default face-remapping-alist))
;;                                       'default)
;;                                   :background nil t))))
;; )
(plist-put org-format-latex-options :scale 1.2) ; smaller larger previews
(after! org
  (defun scimax-org-latex-fragment-justify (justification)
    "Justify the latex fragment at point with JUSTIFICATION.
JUSTIFICATION is a symbol for 'left, 'center or 'right."
    (interactive
     (list (intern-soft
            (completing-read "Justification (left): " '(left center right)
                             nil t nil nil 'left))))
    (let* ((ov (ov-at))
           (beg (ov-beg ov))
           (end (ov-end ov))
           (shift (- beg (line-beginning-position)))
           (img (overlay-get ov 'display))
           (img (and (and img (consp img) (eq (car img) 'image)
                          (image-type-available-p (plist-get (cdr img) :type)))
                     img))
           space-left offset)
      (when (and img
                 ;; This means the equation is at the start of the line
                 (= beg (line-beginning-position))
                 (or
                  (string= "" (s-trim (buffer-substring end (line-end-position))))
                  (eq 'latex-environment (car (org-element-context)))))
        (setq space-left (- (window-max-chars-per-line) (car (image-size img)))
              offset (floor (cond
                             ((eq justification 'center)
                              (- (/ space-left 2) shift))
                             ((eq justification 'right)
                              (- space-left shift))
                             (t
                              0))))
        (when (>= offset 0)
          (overlay-put ov 'before-string (make-string offset ?\ ))))))

  (defun scimax-org-latex-fragment-justify-advice (beg end image imagetype)
    "After advice function to justify fragments."
    (scimax-org-latex-fragment-justify (or (plist-get org-format-latex-options :justify) 'left)))


  (defun scimax-toggle-latex-fragment-justification ()
    "Toggle if LaTeX fragment justification options can be used."
    (interactive)
    (if (not (get 'scimax-org-latex-fragment-justify-advice 'enabled))
        (progn
          (advice-add 'org--format-latex-make-overlay :after 'scimax-org-latex-fragment-justify-advice)
          (put 'scimax-org-latex-fragment-justify-advice 'enabled t)
          (message "Latex fragment justification enabled"))
      (advice-remove 'org--format-latex-make-overlay 'scimax-org-latex-fragment-justify-advice)
      (put 'scimax-org-latex-fragment-justify-advice 'enabled nil)
      (message "Latex fragment justification disabled"))))
;; Numbered equations all have (1) as the number for fragments with vanilla
;; org-mode. This code injects the correct numbers into the previews so they
;; look good.
(after! org
  (defun scimax-org-renumber-environment (orig-func &rest args)
    "A function to inject numbers in LaTeX fragment previews."
    (let ((results '())
          (counter -1)
          (numberp))
      (setq results (loop for (begin .  env) in
                          (org-element-map (org-element-parse-buffer) 'latex-environment
                            (lambda (env)
                              (cons
                               (org-element-property :begin env)
                               (org-element-property :value env))))
                          collect
                          (cond
                           ((and (string-match "\\\\begin{equation}" env)
                                 (not (string-match "\\\\tag{" env)))
                            (incf counter)
                            (cons begin counter))
                           ((string-match "\\\\begin{align}" env)
                            (prog2
                                (incf counter)
                                (cons begin counter)
                              (with-temp-buffer
                                (insert env)
                                (goto-char (point-min))
                                ;; \\ is used for a new line. Each one leads to a number
                                (incf counter (count-matches "\\\\$"))
                                ;; unless there are nonumbers.
                                (goto-char (point-min))
                                (decf counter (count-matches "\\nonumber")))))
                           (t
                            (cons begin nil)))))

      (when (setq numberp (cdr (assoc (point) results)))
        (setf (car args)
              (concat
               (format "\\setcounter{equation}{%s}\n" numberp)
               (car args)))))

    (apply orig-func args))


  (defun scimax-toggle-latex-equation-numbering ()
    "Toggle whether LaTeX fragments are numbered."
    (interactive)
    (if (not (get 'scimax-org-renumber-environment 'enabled))
        (progn
          (advice-add 'org-create-formula-image :around #'scimax-org-renumber-environment)
          (put 'scimax-org-renumber-environment 'enabled t)
          (message "Latex numbering enabled"))
      (advice-remove 'org-create-formula-image #'scimax-org-renumber-environment)
      (put 'scimax-org-renumber-environment 'enabled nil)
      (message "Latex numbering disabled.")))

  (advice-add 'org-create-formula-image :around #'scimax-org-renumber-environment)
  (put 'scimax-org-renumber-environment 'enabled t))
(setq org-file-apps
      '((auto-mode . emacs)
        (directory . emacs)
        ("\\.x?html?\\'" . default)
        ("\\.pdf\\(::[0-9]+\\)?\\'" . emacs)
        ("\\.gif\\'" . "eog \"%s\"")
        ("\\.mp4\\'" . "vlc \"%s\"")
        ("\\.mkv" . "vlc \"%s\"")))
;; see http://thread.gmane.org/gmane.emacs.orgmode/42715
(add-hook 'org-checkbox-statistics-hook (function ndk/checkbox-list-complete))

(defun ndk/checkbox-list-complete ()
  (save-excursion
    (org-back-to-heading t)
    (let ((beg (point)) end)
      (end-of-line)
      (setq end (point))
      (goto-char beg)
      (if (re-search-forward "\\[\\([0-9]*%\\)\\]\\|\\[\\([0-9]*\\)/\\([0-9]*\\)\\]" end t)
            (if (match-end 1)
                (if (equal (match-string 1) "100%")
                    ;; all done - do the state change
                    (org-todo 'done)
                  (org-todo 'todo))
              (if (and (> (match-end 2) (match-beginning 2))
                       (equal (match-string 2) (match-string 3)))
                  (org-todo 'done)
                (org-todo 'todo)))))))
(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states)   ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)
(setq org-fast-tag-selection-include-todo t)
(after! org
  (setq org-ditaa-jar-path "/usr/share/java/ditaa/ditaa-0.11.jar"))
(use-package! org-colored-text)
;; (use-package! mathpix.el
;;   :config
;;   (setq mathpix-app-id "app-id")
;;   (setq mathpix-app-key "app-key")
;;   )
(use-package! beancount
  :config
  ;; (add-to-list 'load-path "~/programs/beancount/editors/emacs")
    ;; (require 'beancount)
  (setq beancount-electric-currency t)
  (add-to-list 'auto-mode-alist '("\\.beancount\\'" . beancount-mode))  ;; Automatically open .beancount files in beancount-mode.
  (add-to-list 'auto-mode-alist '("\\.beancount$" . beancount-mode))
  (defun beancount-bal ()
    "Run bean-report bal."
    (interactive)
    (let ((compilation-read-command nil))
      (beancount--run "bean-report"
                      (file-relative-name buffer-file-name) "bal")))
  (add-hook 'beancount-mode-hook 'outline-minor-mode))
;; (use-package! lsp-ui
;;     :requires use-package-hydra
;;     :commands lsp-ui-mode
;;     :config
;;     (setq lsp-ui-sideline-enable t)
;; (setq flycheck-checker-error-threshold 10000)
(after! lsp-ui
(setq lsp-ui-flycheck-list-position 'right)
(setq lsp-flycheck-live-reporting t)
(setq lsp-ui-peek-list-width 60)
(setq lsp-ui-peek-peek-height 25)
(setq lsp-ui-imenu-enable t)
(setq lsp-ui-doc-enable t)
(setq lsp-ui-doc-use-webkit t)
;; (setq lsp-enable-on-type-formatting nil)
(setq lsp-ui-doc-delay 0.1)
)
(after! lsp-python-ms (set-lsp-priority! 'mspyls 1))
;; (setq lsp-pyls-server-command '("mspyls"))
;; (setq lsp-ui-sideline-ignore-duplicate t)
;; )
;; (setq read-process-output-max (* 1024 2048)) ;; 1mb
;; (after! lsp-mode
;;   (use-package! lsp-python-ms
;;     :ensure t
;;     :config
;;     (setq lsp-prefer-capf t)
;;     )
;;   )
;; uncomment to have default interpreter as ipython. in Doom : use +python/open-ipython-repl instead
;; Important: using ipython as default python interpreter breaks LSP
;; (when (executable-find "ipython")
;;   (setq python-shell-interpreter "ipython"))
;; (use-package! lsp-python-ms
;;   :ensure t
;;   :hook (python-mode . (lambda ()
;;                           (require 'lsp-python-ms)
;;                           (lsp))))
(after! ob-jupyter
  (require 'jupyter))
(after! jupyter
  (set-lookup-handlers! '(jupyter-repl-mode jupyter-org-interaction-mode jupyter-repl-interaction-mode jupyter-repl-persistent-mode)
    :documentation '(jupyter-inspect-at-point :async t)))
;; (set-lookup-handlers! '(jupyter-repl-mode jupyter-org-interaction-mode jupyter-repl-interaction-mode)
;;   :documentation #'jupyter-inspect-at-point
;;   )
(use-package! blacken)
;;(setq vc-handled-backends nil)
;;(unpin! t)
(auto-save-visited-mode +1) ;;may be redundant with auto-save-default
(setq auto-save-default t
      auto-save-timeout 5
      auto-save-interval 100)
(setq auto-save-file-name-transforms
  `((".*" "~/.emacs-saves/" t)))
(setq backup-directory-alist `(("." . "~/.emacs-saves")))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 2
  kept-old-versions 0
  version-control t)
(setq vc-make-backup-files t)

(defun force-backup-of-buffer ()
  ;; Make a special "per session" backup at the first save of each
  ;; emacs session.
  (when (not buffer-backed-up)
    ;; Override the default parameters for per-session backups.
    (let ((backup-directory-alist '(("" . "~/.emacs-saves/per-session")))
          (kept-new-versions 3))
      (backup-buffer)))
  ;; Make a "per save" backup on each save.  The first save results in
  ;; both a per-session and a per-save backup, to keep the numbering
  ;; of per-save backups consistent.
  (let ((buffer-backed-up nil))
    (backup-buffer)))

(add-hook 'before-save-hook  'force-backup-of-buffer)
(add-load-path! "/usr/share/emacs/site-lisp/mu4e")
(use-package! smtpmail)
(use-package! mu4e
  :config
(remove-hook 'mu4e-main-mode-hook 'evil-collection-mu4e-update-main-view)
  (load! "mu4e-config.el")
 )
;(use-package!
;    snails)
(add-hook 'org-mode-hook 'turn-off-smartparens-mode)
(sp-local-pair
     '(org-mode)
     "<<" ">>"
     :actions '(insert))
(after! flyspell (require 'flyspell-lazy) (flyspell-lazy-mode 1))
(setq ispell-dictionary "en-custom")
(setq ispell-personal-dictionary "~/.dotfiles/.hunspell_personal" )
(setq calc-angle-mode 'rad  ;; radians are rad
      calc-algebraic-mode t ;; allows '2*x instead of 'x<RET>2*
      calc-symbolic-mode t) ;; keeps stuff like √2 irrational for as long as possible
(after! calctex
  (setq calctex-format-latex-header (concat calctex-format-latex-header
                                            "\n\\usepackage{arevmath}")))
(add-hook 'calc-mode-hook #'calctex-mode)
(setq which-key-idle-delay 0.3)
(setq which-key-allow-multiple-replacements t)
(after! which-key
  (pushnew!
   which-key-replacement-alist
   '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
   '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))
   ))
(setq +lookup-open-url-fn #'eww)
(defun markdown-window-p (window-title)
  "Judges from WINDOW-TITLE whether the current window likes markdown"
  (string-match-p (rx (or "Stack Exchange" "Stack Overflow"
                          "Pull Request" "Issue" "Discord"))
                  window-title))
(define-minor-mode emacs-anywhere-mode
  "To tweak the current buffer for some emacs-anywhere considerations"
  :init-value nil
  :keymap (list
           ;; Finish edit, but be smart in org mode
           (cons (kbd "C-c C-c") (cmd! (if (and (eq major-mode 'org-mode)
                                                   (org-in-src-block-p))
                                              (org-ctrl-c-ctrl-c)
                                            (delete-frame))))
           ;; Abort edit. emacs-anywhere saves the current edit for next time.
           (cons (kbd "C-c C-k") (cmd! (setq ea-on nil)
                                          (delete-frame))))
  (when emacs-anywhere-mode
    ;; line breaking
    (turn-off-auto-fill)
    (visual-line-mode t)
    ;; DEL/C-SPC to clear (first keystroke only)
    (set-transient-map (let ((keymap (make-sparse-keymap)))
                         (define-key keymap (kbd "DEL")   (cmd! (delete-region (point-min) (point-max))))
                         (define-key keymap (kbd "C-SPC") (cmd! (delete-region (point-min) (point-max))))
                         keymap))
    ;; disable tabs
    (when (bound-and-true-p centaur-tabs-mode)
      (centaur-tabs-local-mode t))))

(defun ea-popup-handler (app-name window-title x y w h)
  (interactive)
  (set-frame-size (selected-frame) 80 12)
  ;; position the frame near the mouse
  (let* ((mousepos (split-string (shell-command-to-string "xdotool getmouselocation | sed -E \"s/ screen:0 window:[^ ]*|x:|y://g\"")))
         (mouse-x (- (string-to-number (nth 0 mousepos)) 100))
         (mouse-y (- (string-to-number (nth 1 mousepos)) 50)))
    (set-frame-position (selected-frame) mouse-x mouse-y))

  (set-frame-name (concat "Quick Edit ∷ " ea-app-name " — "
                          (truncate-string-to-width
                           (string-trim
                            (string-trim-right window-title
                                               (format "-[A-Za-z0-9 ]*%s" ea-app-name))
                            "[\s-]+" "[\s-]+")
                           45 nil nil "…")))
  (message "window-title: %s" window-title)

  ;; set major mode
  (cond
   ((markdown-window-p window-title) (gfm-mode))
   (t (org-mode)) ; default major mode
   )

  (when-let ((selection (gui-get-selection 'PRIMARY)))
    (insert selection)
    ;; I'll be honest with myself, I /need/ spellcheck
    (flyspell-buffer))

  (evil-insert-state) ; start in insert
  (emacs-anywhere-mode 1))

(add-hook 'ea-popup-hook 'ea-popup-handler)
;; (setq bibtex-completion-notes-template-multiple-files "${author-or-editor} - ${year}: ${title}\n#+ROAM_KEY: cite:${=key=}\n\n- keywords :: ${keywords}\n\n* Notes on ${title}\n:PROPERTIES:\n:NOTER_DOCUMENT: ${file}\n:END:\n\n")
(setq bibtex-completion-notes-template-multiple-files
(concat
  "${author-abbrev}: ${title}\n"
  "#+ROAM_KEY: cite:${=key=}\n\n"
  "- tags :: \n"
  "- keywords :: ${keywords}\n\n"
  "* TODO Notes\n"
  ":PROPERTIES:\n"
  ":Custom_ID: ${=key=}\n"
  ":NOTER_DOCUMENT: ${file}\n"
  ":AUTHOR: ${author-abbrev}\n"
  ":JOURNAL: ${journaltitle}\n"
  ":DATE: ${date}\n"
  ":YEAR: ${year}\n"
  ":DOI: ${doi}\n"
  ":URL: ${url}\n"
  ":END:\n\n"
  ))
(set-popup-rule! "^\\*eww*" :side 'right :size 0.5)
(setq ranger-show-literal nil)
;; (use-package! cdlatex
;; :init
;; (setq cdlatex-math-modify-alist '((?B "\\mathbb" nil t nil nil)))
;; )
(setq yas-triggers-in-field t)
