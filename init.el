;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (tuareg dash company sml-mode evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 158 :width normal)))))

(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")))

(require 'evil)
(evil-mode 1)

(add-hook 'after-init-hook 'global-company-mode) ; 全局補全

(load "~/.emacs.d/elpa/dash-20170613.151/dash.el")
(load "~/.emacs.d/elpa/tuareg-20170531.557/tuareg-site-file.el")

(recentf-mode 1) ; keep a list of recently opened files

;; set F2 to list recently opened file
(global-set-key (kbd "<f2>") 'recentf-open-files)

(global-linum-mode t) ; 行號
