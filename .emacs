(require 'linum)

;disable backup
(setq backup-inhibited t)
;disable auto save
(setq auto-save-default nil)
;color theme
(set-background-color "black")
(set-foreground-color "green")
(set-cursor-color "green")
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(global-set-key "\C-x#" 'comment-region)
(global-set-key "\C-x%" 'uncomment-region)


(add-hook 'find-file-hook (lambda () (linum-mode 1)))
;set cc-mode style
(setq c-basic-offset 4)
(add-hook 'c-mode-common-hook ' (lambda () (c-toggle-auto-state 1)))
(c-set-offset 'substatement-open '0) ; brackets should be at same indentation level as the statements they open




