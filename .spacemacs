;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(csv
     javascript
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; auto-completion
     ;; better-defaults
     emacs-lisp
     systemd
     git
     pdf
     html
     helm
     pandoc
     (auto-completion :variables
                      auto-completion-complete-with-key-sequence "jk"
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-help-tooltip t
                      spacemacs-default-company-backends '(company-files company-capf)
                      )
     better-defaults
     emacs-lisp
     (multiple-cursors :variables multiple-cursors-backend 'evil-mc)
     git
     markdown
     games
     spotify
     treemacs
     neotree
     graphviz
     ranger
     org
     finance
     (templates :variables templates-private-directory "~/.emacs.d/private/templates"
                auto-insert-query nil )
     shell-scripts
     google-calendar
     dap
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     (spell-checking :variables spell-checking-enable-auto-dictionary t
                     spell-checking-enable-by-default nil
                     =enable-flyspell-auto-completion= t)
     syntax-checking
     (c-c++ :variables c-c++-enable-clang-support t)
     semantic
     ;;lsp
     (julia :variables julia-mode-enable-lsp nil)
     (python :variables
             python-backend 'anaconda
             python-formatter 'yapf
             python-format-on-save nil
             ;;python-sort-imports-on-save t
             )
     jupyter
     treemacs
     colors
     themes-megapack
     bibtex
     (latex :variables latex-enable-auto-fill t
            latex-enable-folding t)
     ;; version-control
     )

   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   ;; To use a local version of a package, use the `:location' property:
   ;; '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(org-chef
                                      org-noter
                                      simple-httpd
                                      websocket
                                      ox-reveal
                                      ox-hugo
                                      ob-async
                                      sphinx-doc
                                      julia-repl
                                      polymode
                                      dash
                                      s
                                      cdlatex
                                      (beancount :location (recipe
                                                            :fetcher bitbucket
                                                            :repo "blais/beancount"
                                                            :files ("editors/emacs/beancount.el")))
                                     )


   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=~/.emacs.d/.cache/dumps/spacemacs.pdmp
   ;; (default spacemacs.pdmp)
   dotspacemacs-emacs-dumper-dump-file "spacemacs.pdmp"

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due to garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'vim

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7)
                                (agenda . 10))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'org-mode

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         tango-2
                         spacemacs-dark
                         spacemacs-light)

   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts.
   dotspacemacs-default-font '("Fira Code Light"
                               :size 10.0
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 5

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state t

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but lines are only visual lines are counted. For example, folded lines
   ;; will not be counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers nil

   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server nil

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'trailing

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs t))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that will be included in the
dump."
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."
  ;; add personal load path
  (add-to-list 'load-path "~/.emacs.d/private/lisp/org-graph-view")
  ;; PYTHON
  (pyenv-mode)
  (add-to-list 'load-path "~/.pyenv/shims/jupyter")
  (add-to-list 'load-path "~/.pyenv/shims")
  (add-to-list 'exec-path "~/.pyenv/shims")
  (add-to-list 'python-shell-extra-pythonpaths  "/home/philip/programs/gmsh/api")
  (when (executable-find "ipython")
    (setq python-shell-interpreter "ipython"))
  (setq flycheck-python-pycompile-executable "python3")
  (add-hook 'python-mode-hook 'anaconda-eldoc-mode)

  ;; enable proselint in textual modes:
  (add-hook 'markdown-mode-hook #'flycheck-mode)
  (add-hook 'text-mode-hook #'flycheck-mode)
  (add-hook 'message-mode-hook #'flycheck-mode)
  (add-hook 'org-mode-hook #'flycheck-mode)


  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; ORG
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; Capture
  (global-set-key (kbd "<f6>") 'org-capture)
  (setq org-directory "~/Documents/org")
  (setq org-agenda-files
        (list
        (concat org-directory "/PhD.org.gpg")
        (concat org-directory "/personal.org.gpg" )
        (concat org-directory "/gcal.org" )
        (concat org-directory "/gcal-work.org")))
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
       "* %^{The word} :drill:\n %t\n %^{Extended word (may be empty)} \n** Answer \n%^{The definition}")))

  (setq org-agenda-custom-commands
        '(("c" "Simple agenda view"
           ((agenda "")
            (alltodo "")))))
  (require 'org-gcal)
  (setq org-gcal-client-id "778561039072-m4jsg3lmr9eoihk79uouuucf9tug9agp.apps.googleusercontent.com"
        org-gcal-client-secret "UjB-Q-S09K2uZjHcoRIyPvNd"
        org-gcal-file-alist '(("naehmlich@gmail.com" .  "~/Documents/org/gcal.org")
                              ("rhcgeikr7l3umo3vk69rbn9nos@group.calendar.google.com" . "~/Documents/org/gcal-work.org")))
  ;; (add-hook 'org-agenda-mode-hook (lambda () (org-gcal-sync) ))
  ;; (add-hook 'org-capture-after-finalize-hook (lambda () (org-gcal-sync) ))
  (setq org-log-into-drawer t)
  (setq org-log-redeadline (quote note))
  (setq org-log-reschedule (quote note))
  (setq org-log-repeat (quote note))
  (setq org-src-fontify-natively t)
  (setq org-src-tab-acts-natively t)   ; remove two additional tabs in src blocks
  (defadvice org-switch-to-buffer-other-window
      (after supress-window-splitting activate)
    "Delete the extra window if we're in a capture frame"
    (if (equal "capture" (frame-parameter nil 'name))
        (delete-other-windows)))

  (defadvice org-capture-finalize
      (after delete-capture-frame activate)
    "Advise capture-finalize to close the frame"
    (when (and (equal "capture" (frame-parameter nil 'name))
	             (not (eq this-command 'org-capture-refile)))
      (delete-frame)))
  (defadvice org-capture-refile
      (after delete-capture-frame activate)
    "Advise org-refile to close the frame"
    (delete-frame))
  (defun activate-capture-frame ()
    "run org-capture in capture frame"
    (select-frame-by-name "capture")
    (switch-to-buffer (get-buffer-create "*scratch*"))
    (org-capture))

  ;; Misc
  (require 'org-graph-view)
  ;; org-babel
  (setq org-src-fontify-natively t
        org-src-window-setup 'other-window
        org-src-strip-leading-and-trailing-blank-lines t
        org-src-preserve-indentation nil
        org-src-tab-acts-natively nil)

  (require 'ob-async)
  (add-to-list 'load-path "~/programs/julia")
  (add-to-list 'exec-path "~/programs/julia")
  (add-hook 'julia-mode-hook 'julia-repl-mode)
  (setq inferior-julia-program-name "/home/philip/programs/julia/julia")
  ;; This needs to be repeated for ob-async

  (add-hook 'ob-async-pre-execute-src-block-hook
            '(lambda ()
               (setq inferior-julia-program-name "/home/philip/programs/julia/julia")))

  (setq ob-async-no-async-languages-alist '( "jupyter-python" "jupyter-julia" "julia" "python"))

  (with-eval-after-load 'org
    (setq org-babel-load-languages
          (append org-babel-load-languages
                  '((emacs-lisp . t)
                    (gnuplot . t)
                    (latex . t)
                    (shell . t)
                    (julia . t)
                    (python . t)
                    ;; jupyter has to be the last element
                    (jupyter . t)
                    )))
  (spacemacs//org-babel-do-load-languages))
  ;;(setq python-shell-completion-native-enable nil)
  (setq org-confirm-babel-evaluate nil)   ;don't prompt me to confirm everytime I want to evaluate a block
  (setq org-babel-default-header-args '((:eval . "never-export")))
  (add-to-list 'org-babel-default-header-args:python
               '(:async . "yes"))
  (org-babel-jupyter-override-src-block "python")
  (setq jupyter-pop-up-frame t)


  ;; org export
  (setq org-image-actual-width nil)
     (require 'ox-extra)
     (ox-extras-activate '(latex-header-blocks ignore-headlines))
  ;; latex koma-article
  (with-eval-after-load "ox-latex"
    (add-to-list 'org-latex-classes
                 '("koma-article" "\\documentclass{scrartcl}"
                   ("\\section{%s}" . "\\section*{%s}")
                   ("\\subsection{%s}" . "\\subsection*{%s}")
                   ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                   ("\\paragraph{%s}" . "\\paragraph*{%s}")
                   ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))


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

  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")
  ;;;;;;
   (defun autoinsert-yas-expand()
     "Replace text in yasnippet template."
     (yas-expand-snippet (buffer-string) (point-min) (point-max)))
   (define-auto-insert "\\.org$" ["~/.emacs.d/private/autoinsert/org_mode_header_full.org" autoinsert-yas-expand])



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
  (setq org-ref-default-bibliography '("~/Documents/PhD/Literature.bib/library_org.bib")
        org-ref-pdf-directory "~/Documents/PhD/Literature/pdfs/"
        org-ref-bibliography-notes "~/Documents/PhD/Literature.bib/notes.org"
        org-ref-notes-directory "~/Documents/PhD/Literature.bib/notes/"

        reftex-default-bibliography '("~/Documents/PhD/Literature.bib/library_org.bib")
        ;;bibtex-completion-notes "~/Documents/PhD/Literature.bib/notes"
        bibtex-completion-notes-path "~/Documents/PhD/Literature.bib/notes.org"
        bibtex-completion-bibliography "~/Documents/PhD/Literature.bib/library_org.bib"
        bibtex-completion-library-path "~/Documents/PhD/Literature/pdfs"
        org-noter-notes-search-path "~/Documents/PhD/Literature.bib/notes"
        )
  (setq bibtex-completion-find-additional-pdfs t)
  ;; latex compiler
  (setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))

  (defun org-noter-init-pdf-view ()
    (pdf-view-fit-page-to-window)
    (pdf-view-auto-slice-minor-mode)
    (run-at-time "0.5 sec" nil #'org-noter))

  (add-hook 'pdf-view-mode-hook 'org-noter-init-pdf-view)

  ;; latex compile
  (setq org-latex-pdf-process
        '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "bibtex %b"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
  (setq org-latex-logfiles-extensions (quote ("lof" "lot" "tex" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb" "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl" "pygtex" "pygstyle")))

  ;; LATEX
  (add-hook 'org-mode-hook 'turn-on-org-cdlatex)
  (add-to-list 'org-latex-packages-alist
               '("" "tikz" t))

  (eval-after-load "preview"
    '(add-to-list 'preview-default-preamble "\\PreviewEnvironment{tikzpicture}" t))
  (setq org-latex-create-formula-image-program 'imagemagick)
  ;; C
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (defun clang-format-buffer-smart ()
    "Reformat buffer if .clang-format exists in the projectile root."
    (when (f-exists? (expand-file-name ".clang-format" (projectile-project-root)))
      (clang-format-buffer)))
  (defun clang-format-buffer-smart-on-save ()
    "Add auto-save hook for clang-format-buffer-smart."
    (add-hook 'before-save-hook 'clang-format-buffer-smart nil t))
  (spacemacs/add-to-hooks 'clang-format-buffer-smart-on-save
                          '(c-mode-hook c++-mode-hook))

  ;; LaTeX
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)

  ;; Completion
  (global-company-mode)

  (setq yas-triggers-in-field t)
  '(setq auto-completion-enable-help-tooltip t)
  (global-set-key (kbd "M-n") 'pcomplete)

  (define-key evil-normal-state-map (kbd "zn") 'hs-hide-level)

  '(add-hook 'vhdl-mode-hook (lambda () (vhdl-tools-mode 1)))


  ;; Automatically open .beancount files in beancount-mode.
  (add-to-list 'auto-mode-alist '("\\.beancount$" . beancount-mode))

  ;; faces
  (custom-set-faces
   '(company-tooltip-common
     ((t (:inherit company-tooltip :weight bold :underline nil))))
   '(company-tooltip-common-selection
     ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))

  (let ((path (shell-command-to-string ". ~/.bash_profile; echo -n $PATH")))
    (setenv "PATH" path)
    (setq exec-path
          (append
           (split-string-and-unquote path ":")
           exec-path)))
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (zenburn-theme zen-and-art-theme yatemplate yasnippet-snippets yapfify xterm-color ws-butler writeroom-mode winum white-sand-theme which-key web-mode web-beautify vterm volatile-highlights vi-tilde-fringe uuidgen use-package unfill underwater-theme ujelly-theme typit twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme toc-org terminal-here tao-theme tangotango-theme tango-plus-theme tango-2-theme tagedit systemd symon symbol-overlay sunny-day-theme sudoku sublime-themes subatomic256-theme subatomic-theme string-inflection stickyfunc-enhance srefactor spotify sphinx-doc spaceline-all-the-icons spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme smeargle slim-mode shell-pop seti-theme scss-mode sass-mode reverse-theme restart-emacs rebecca-theme ranger rainbow-mode rainbow-identifiers rainbow-delimiters railscasts-theme pytest pyenv-mode py-isort purple-haze-theme pug-mode professional-theme prettier-js popwin polymode planet-theme pippel pipenv pip-requirements phoenix-dark-pink-theme phoenix-dark-mono-theme persp-mode pcre2el password-generator paradox pandoc-mode pacmacs ox-reveal ox-pandoc overseer orgit organic-green-theme org-ref org-projectile org-present org-pomodoro org-noter org-mime org-gcal org-download org-cliplink org-chef org-bullets org-brain open-junk-file omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme ob-async nodejs-repl noctilux-theme neotree naquadah-theme nameless mwim mustang-theme multi-term move-text monokai-theme monochrome-theme molokai-theme moe-theme mmm-mode minimal-theme material-theme markdown-toc majapahit-theme magit-svn magit-section magit-gitflow madhat2r-theme macrostep lush-theme lsp-ui lsp-python-ms lsp-julia lorem-ipsum livid-mode live-py-mode link-hint light-soap-theme kaolin-themes jupyter julia-repl json-navigator json-mode js2-refactor js-doc jbeans-theme jazz-theme ir-black-theme insert-shebang inkpot-theme indent-guide importmagic impatient-mode hybrid-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation heroku-theme hemisu-theme helm-xref helm-themes helm-swoop helm-spotify-plus helm-rtags helm-pydoc helm-purpose helm-projectile helm-org-rifle helm-org helm-mode-manager helm-make helm-lsp helm-ls-git helm-gitignore helm-git-grep helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag hc-zenburn-theme gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme google-translate google-c-style golden-ratio gnuplot gitignore-templates gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md gandalf-theme fuzzy font-lock+ flyspell-correct-helm flycheck-ycmd flycheck-rtags flycheck-pos-tip flycheck-package flycheck-ledger flycheck-elsa flycheck-bashate flx-ido flatui-theme flatland-theme fish-mode fill-column-indicator farmhouse-theme fancy-battery eziam-theme eyebrowse expand-region exotica-theme evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-textobj-line evil-surround evil-org evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-ledger evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu espresso-theme eshell-z eshell-prompt-extras esh-help emmet-mode elisp-slime-nav editorconfig dumb-jump dracula-theme dotenv-mode doom-themes doom-modeline django-theme disaster diminish devdocs define-word darktooth-theme darkokai-theme darkmine-theme darkburn-theme dap-mode dakrone-theme cython-mode cyberpunk-theme csv-mode cquery cpp-auto-include company-ycmd company-web company-tern company-statistics company-shell company-rtags company-reftex company-quickhelp company-lsp company-c-headers company-auctex company-anaconda column-enforce-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized color-identifiers-mode clues-theme clean-aindent-mode clang-format chocolate-theme cherry-blossom-theme centered-cursor-mode ccls calfw busybee-theme bubbleberry-theme blacken birds-of-paradise-plus-theme badwolf-theme auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile auctex-latexmk apropospriate-theme anti-zenburn-theme ample-zen-theme ample-theme alect-themes aggressive-indent afternoon-theme ace-link ace-jump-helm-line ac-ispell 2048-game))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-common ((t (:inherit company-tooltip :weight bold :underline nil))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection :weight bold :underline nil)))))
)
