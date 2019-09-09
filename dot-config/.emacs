;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(when (display-graphic-p)
  (package-initialize)
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
  (load-theme 'monokai t)
  )

;; (use-package elpy
;;   :ensure t
;;   :defer t
;;   :init
;;   (advice-add 'python-mode :before 'elpy-enable))

(setq python-shell-interpreter "ipython2")
(put 'upcase-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (company-jedi elpy exec-path-from-shell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'package)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/"))
(setq package-check-signature nil)

;; (eval-after-load "python"
;;   '(define-key inferior-python-mode-map "\t" 'python-shell-completion-complete-or-indent))
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(add-to-list 'load-path "~/site-lisp")
(add-to-list 'load-path "~/site-lisp/pymacs-2.5/")
(add-to-list 'load-path "~/site-lisp/auto-complete-1.3.1/")
(add-to-list 'load-path "~/site-lisp/ecb-2.40/")
(require 'linum)
;; (require 'google)
(require 'json)
;; (require 'js2-mode)
;; (require 'yaml-mode)
;; (require 'column-marker)

;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (autoload 'pymacs-autoload "pymacs")
;; ;;(eval-after-load "pymacs"
;; ;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))
;; (setq ropemacs-global-prefix "C-x /")
;; (require 'pymacs)
;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t)

;; (require 'auto-complete)
;; (global-auto-complete-mode t)


;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)
;color theme
;; (set-background-color "black")
;; (set-foreground-color "green")
;; (set-cursor-color "green")



(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-set-key "\C-x#" 'comment-region)
(global-set-key "\C-x%" 'uncomment-region)

;; I hate tabs!
(setq-default indent-tabs-mode nil)

(add-hook 'find-file-hook (lambda () (linum-mode 1)))
;set cc-mode style
;; (setq c-basic-offset 4)
;; (add-hook 'c-mode-common-hook ' (lambda () (c-toggle-auto-state 1)))
;; (c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open
;; (add-to-list 'auto-mode-alist '("\\.api\\'" . js-mode))

;; (setq go-basic-offset 4)

(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if (display-graphic-p)
  (progn
    ;; use 120 char wide window for largeish displays
    ;; and smaller 80 column windows for smaller displays
    ;; pick whatever numbers make sense for you
    (if (> (x-display-pixel-width) 1280)
           (add-to-list 'default-frame-alist (cons 'width 120))
           (add-to-list 'default-frame-alist (cons 'width 80)))
    ;; for the height, subtract a couple hundred pixels
    ;; from the screen height (for panels, menubars and
    ;; whatnot), then divide by the height of a char to
    ;; get the height we want
    (add-to-list 'default-frame-alist
         (cons 'height (/ (- (x-display-pixel-height) 100)
                             (frame-char-height)))))))

(set-frame-size-according-to-resolution)

;; Disable ECB since it's too fucking slow
;; (load-file "~/site-lisp/cedet-1.0pre6/common/cedet.el")
;; (global-ede-mode 1)                      ; Enable the Project management system
;; (semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
;; (global-srecode-minor-mode 1)            ; Enable template insertion menu

;; (load-file "~/site-lisp/ecb-2.40/ecb.el")
;; (require 'ecb-autoloads)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;ECB MODE;;;;;;;;;;;;;;;;;;;;;
;; (global-set-key "\C-cm" 'ecb-goto-window-methods)
;; (global-set-key "\C-c0" 'ecb-goto-window-edit1)
;; (global-set-key "\C-ch" 'ecb-goto-window-history)
;; (global-set-key "\C-cs" 'ecb-goto-window-sources)
;; (global-set-key "\C-cd" 'ecb-goto-window-directories)
(put 'downcase-region 'disabled nil)

;; (add-hook 'c++-mode-hook
;;         '(lambda () (font-lock-set-up-width-warning 80)))
;; (add-hook 'java-mode-hook
;;         '(lambda () (font-lock-set-up-width-warning 100)))
;; (add-hook 'python-mode-hook
;;         '(lambda () (font-lock-set-up-width-warning 80)))
;; (add-hook 'borg-mode-hook
;;         '(lambda () (font-lock-set-up-width-warning 80)))
;; (add-hook 'borg-patchpanel-mode-hook
;;         '(lambda () (font-lock-set-up-width-warning 80)))
;; (add-hook 'protobuf-mode-hook
;;         '(lambda () (font-lock-set-up-width-warning 80)))
;; (put 'upcase-region 'disabled nil)

;; (add-hook 'go-mode-hook
;;   (lambda ()
;;     (setq-default)
;;     (setq tab-width 2)
;;     (setq standard-indent 2)
;;     (setq indent-tabs-mode nil)))
(add-hook 'python-mode-hook
          '(lambda ()
             (elpy-enable)
             (global-set-key "\M-." 'elpy-goto-definition)
             (add-to-list 'company-backends 'company-jedi)
             (setq elpy-sell-echo-input nil)
             ))
