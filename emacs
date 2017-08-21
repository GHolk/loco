
 ;; create by c34031328
;; 2016-12-10

;; el-get at top!
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
      (lambda (s) (end-of-buffer) (eval-print-last-sexp))))

(setq
 el-get-sources
 '((:name pangu-spacing
	  :after (progn
		   (customize-set-variable
		    'pangu-spacing-real-insert-separtor t)
		   ;; true add space into document
		   (global-pangu-spacing-mode 1)))
   (:name smex
	  :after (progn
		   (global-set-key (kbd "M-x") 'smex)
		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))
   (:name evil
	  :after (progn
		   (customize-set-variable 'evil-shift-width 4)
		   (customize-set-variable 'evil-find-skip-newlines t)
		   (customize-set-variable 'evil-want-fine-undo t)
		   (customize-set-variable 'evil-want-Y-yank-to-eol t)
		   (defalias 'evil-insert-state 'evil-emacs-state
		     "use emacs state as insert state")
		   (evil-mode 1)))))

(setq my:el-get-packages
      '(el-get smex markdown-mode pangu-spacing evil mediawiki))

(el-get 'sync my:el-get-packages)


(require 'package)
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
	("melpa" . "http://melpa.milkbox.net/packages/")))


(require 'ido)
(ido-mode t)
(global-set-key (kbd "C-x f") 'ido-find-file)

;; emacs has no user-agent default??
(customize-set-variable 'url-user-agent "Emacs25")
(menu-bar-mode -1)
;(setq-default mode-line-format nil)
(customize-set-variable 'mode-line-format nil)
