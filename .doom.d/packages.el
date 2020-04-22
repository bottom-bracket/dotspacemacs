;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here, run 'doom sync' on
;; the command line, then restart Emacs for the changes to take effect.
;; Alternatively, use M-x doom/reload.
;;
;; WARNING: Disabling core packages listed in ~/.emacs.d/core/packages.el may
;; have nasty side-effects and is not recommended.


;; All of Doom's packages are pinned to a specific commit, and updated from
;; release to release. To un-pin all packages and live on the edge, do:
;(unpin! t)

;; ...but to unpin a single package:
;(unpin! pinned-package)
;; Use it to unpin multiple packages
;(unpin! pinned-package another-pinned-package)


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a particular repo, you'll need to specify
;; a `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, for whatever reason,
;; you can do so here with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))


(package! flycheck-popup-tip ) ;:disable t)

(package! beancount :recipe (:local-repo "~/programs/beancount/editors/emacs"
                                         :files ("beancount.el")))
;; * Mail
(package! mu4e-maildirs-extension)
;; * Writing
(package! academic-phrases)
;; * Org
(package! org-chef)
(package! ox-reveal)
(package! ox-pandoc)
(package! ob-async)
(package! org-gcal)
(package! cdlatex)
(package! org-sidebar)
(package! org-mime)
(package! org-preview-html)
;; (package! org-journal)
;; Org Ref
(package! org-ref)
(package! org-noter)
;; Python
;; (package! lsp-python-ms)
;; (package! lsp-treemacs)
;; (package! helm-lsp)
;;
;; * Other
(package! simple-httpd)
(package! websocket)
(package! ranger)

(package! evil-goggles)
;; (package! evil-surround)
(package! evil-collection)
(package! popup-kill-ring)

(package! helm-org-rifle)
(package! company-tabnine :disable t)
(package! company-lsp :disable nil)
(package! company-math)
(package! mathpix.el
  :recipe (:host github :repo "jethrokuan/mathpix.el")
)
;; (package! dired+)
;; (package! snails
;;   :recipe (:host github :repo "manateelazycat/snails" :files ("*.el" "*.sh") :no-byte-compile t))
;; ;; (package! polymode :recipe
;;    (:host github :repo "polymode/polymode"))

;; (package! org-fstree :recipe (:local-repo "./modules/org"
                                         ;; :files ("org-fstree.el")))

(package! ox-koma-letter :recipe (:local-repo "./modules/org"
                                  :files ("ox-koma-letter.el")))
