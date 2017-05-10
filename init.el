
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
 '(package-selected-packages (quote (company sml-mode evil))))
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

(recentf-mode 1) ; keep a list of recently opened files

;; set F7 to list recently opened file
(global-set-key (kbd "<f7>") 'recentf-open-files)

(global-linum-mode t) ; 行號


(require 'company)
(require 'cl-lib)
(defvar function-table (make-hash-table :test #'equal))
(defvar function-list
  (list
   (list "List.null" "val null : 'a list -> bool")
   (list "List.length" "val length : 'a list -> int")
   (list "List.hd" "val hd : 'a list -> 'a")
   (list "List.tl" "val tl : 'a list -> 'a list")
   (list "List.last" "val last : 'a list -> 'a")
   (list "List.getItem" "val getItem : 'a list -> ('a * 'a list) option")
   (list "List.nth" "val nth : 'a list * int -> 'a")
   (list "List.take" "val take : 'a list * int -> 'a list")
   (list "List.drop" "val drop : 'a list * int -> 'a list")
   (list "List.rev" "val rev : 'a list -> 'a list")
   (list "List.concat" "val concat : 'a list list -> 'a list")
   (list "List.revAppend" "val revAppend : 'a list * 'a list -> 'a list")
   (list "List.app" "val app : ('a -> unit) -> 'a list -> unit")
   (list "List.map" "val map : ('a -> 'b) -> 'a list -> 'b list")
   (list "List.mapPartial" "val mapPartial : ('a -> 'b option) -> 'a list -> 'b list")
   (list "List.find" "val find : ('a -> bool) -> 'a list -> 'a option")
   (list "List.filter" "val filter : ('a -> bool) -> 'a list -> 'a list")
   (list "List.partition" "val partition : ('a -> bool) -> 'a list -> 'a list * 'a list")
   (list "List.foldl" "val foldl : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b")
   (list "List.foldr" "val foldr : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b")
   (list "List.exists" "val exists : ('a -> bool) -> 'a list -> bool")
   (list "List.all" "val all : ('a -> bool) -> 'a list -> bool")
   (list "List.tabulate" "val tabulate : int * (int -> 'a) -> 'a list")
   (list "List.collate" "val collate : ('a * 'a -> order) -> 'a list * 'a list -> order")
   ))

(dolist (i function-list)
  (puthash (car i) (cadr i) function-table))

(defun company-simple-backend (command &optional arg &rest ignored)
  (interactive (list 'interactive))
  (cl-case command
    (interactive (company-begin-backend 'company-simple-backend))
    (prefix (and (eq major-mode 'sml-mode)
		 (company-grab-symbol)))
    (candidates (when (equal arg "List.")
		  (mapcar #'car
		   function-list)
		  ))
    (meta (format "%s" (gethash arg function-table)))))

(add-to-list 'company-backends 'company-simple-backend)

(global-set-key [(meta f5)] (make-hippie-expand-function
			     '(try-expand-dcsh-command
			       try-expand-dabbrev-visible
			       try-expand-dabbrev
			       try-expand-dabbrev-all-buffers) t))
