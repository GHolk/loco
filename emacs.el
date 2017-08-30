
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
   (:name js2-mode
          :after (progn
                   (add-to-list 'auto-mode-alist
                                `(,(rx ".js" string-end) . js2-mode))
                   (customize-set-variable
                    'js2-mode-assume-strict nil)
                   (customize-set-variable
                    'js2-strict-missing-semi-warning nil)))
   (:name evil
          :after (progn
                   (customize-set-variable 'evil-shift-width 4)
                   (customize-set-variable 'evil-find-skip-newlines t)
                   (customize-set-variable 'evil-want-fine-undo t)
                   (customize-set-variable 'evil-want-Y-yank-to-eol t)
                   (defalias 'evil-insert-state 'evil-emacs-state
                     "use emacs state as insert state")
                   (defalias 'evil-previous-line 'evil-previous-visual-line
                     "always use visual line instead of realy line")
                   (defalias 'evil-next-line 'evil-next-visual-line
                     "always use visual line instead of realy line")
                   (customize-set-variable
                    'evil-overriding-maps
                    (mapcar (lambda (map-and-state)
                              (if (eq 'Info-mode-map (car map-and-state))
                                  '(Info-mode-map . emacs)
                                map-and-state))
                            evil-overriding-maps))
                   (evil-define-key 'motion Info-mode-map
                     (kbd "RET") 'Info-follow-nearest-node)
                   (evil-mode 1)))
   (:name evil-surround
          :after (global-evil-surround-mode 1))
    ))

(setq my:el-get-packages
      '(el-get smex markdown-mode pangu-spacing mediawiki js2-mode
               evil evil-surround))

(el-get nil my:el-get-packages)

(require 'package)
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://melpa.milkbox.net/packages/")))

(require 'ido)
(ido-mode t)
(global-set-key (kbd "C-x f") 'ido-find-file)

;;;; about Emacs itself
;; emacs has no user-agent default??
(customize-set-variable 'url-user-agent "Emacs25")
;; free most space
(menu-bar-mode -1)
(customize-set-variable 'mode-line-format nil)
(customize-set-variable 'indent-tabs-mode nil)

(customize-set-variable
 'Info-additional-directory-list
 '("/home/gholk/.local/share/info/")
 "my local info directory, always a symbol link to other directory.")

(load "~/.emacs.d/sdcv.el")
(global-set-key (kbd "C-c d") 'kid-sdcv-to-buffer)
