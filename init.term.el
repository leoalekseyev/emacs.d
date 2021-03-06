;; To use folding: turn on folding mode and use F7/M-F7/M-S-F7
;; Increase the memory reserved
(setq gc-cons-threshold 80000000)
(setq garbage-collection-messages t) 
;; Set the load path for the default elisp directory
(setq load-path (append (list (expand-file-name "~/.emacs.d/elisp"))
			load-path))


;(set-default-font "Bitstream Vera Sans Mono-10")
;(set-default-font "Consolas-11")
(set-default-font "DejaVu Sans Mono-11")
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)


; fix copy/paste in Linux?..
(setq x-select-enable-clipboard t)
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

; Switch between windows using shift-arrows
(windmove-default-keybindings)
(global-set-key (kbd "C-S-p") 'windmove-up)
(global-set-key (kbd "C-S-n") 'windmove-down)
(global-set-key (kbd "C-<tab>") 'other-window)

;;{{{ Customize comment-style (and other newcomment.el options)
(setq comment-style 'indent)
(global-set-key (kbd "M-;") 'comment-dwim-line)
(global-set-key (kbd "C-;") 'comment-dwim-line)


(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
    If no region is selected and current line is not blank and we are not at the end of the line,
      then comment current line.
    Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
;;}}}


; Make left window key act as super
(setq w32-lwindow-modifier 'super)

;; Autosave tweaks
(setq auto-save-interval 120)
(setq auto-save-timeout 30) 
(setq version-control t)
(setq backup-directory-alist '(("." . "~/.emacs.d/autosave")))
(setq delete-old-versions t)


;; Misc. tweaks
(fset 'yes-or-no-p 'y-or-n-p) ; stop forcing me to spell out "yes"
;; use Unix-style line endings
(setq-default buffer-file-coding-system 'undecided-unix)
;; make woman not pop up a new frame
(setq woman-use-own-frame nil)

;; Misc. keybindings
(global-set-key "\C-ci" 'indent-region)
(global-set-key [(control f3)] 'explorer-here)
(global-set-key [(control super f3)] 'explorer-here)
(global-set-key [(control f4)] 'terminal-here)
(global-set-key [(control super f4)] 'terminal-here)

; work-around for C-M-p broken in my windows
(global-set-key [(control meta shift z)] 'backward-list)

(defalias 'evabuf 'eval-buffer)
(defalias 'eregion 'eval-region)


;  -- faster point movement: -- bad idea w/ these bindings; clobbers sexp nav
;; (global-set-key "\M-\C-p" 
;;   '(lambda () (interactive) (previous-line 5)))
;; (global-set-key "\M-\C-n" 
;;   '(lambda () (interactive) (next-line 5)))


(desktop-save-mode nil)


;; ========== Line by line scrolling ==========

;; This makes the buffer scroll by only a single line when the up or
;; down cursor keys push the cursor (tool-bar-mode) outside the
;; buffer. The standard emacs behaviour is to reposition the cursor in
;; the center of the screen, but this can make the scrolling confusing
;(setq scroll-step 1)
;; this seemed to sucks; let's try this smooth-scrolling package
;(setq scroll-step 1)
(require 'smooth-scrolling)
;; to change where the scrolling starts, customize-variable smooth-scroll-margin

;; Color-theme:
;; (setq load-path (append (list (expand-file-name "~/.emacs.d/elisp/color-theme-6.6.0")) load-path))
;; (require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-midnight)

;; thing at point mark:
(require 'thing-cmds)
(global-set-key [?\C-\M- ] 'cycle-thing-region)
(global-set-key [(meta ?@)] 'mark-thing)


;; highlight symbol
(add-to-list 'load-path "~/.emacs.d/elisp/highlight-symbol")
(require 'highlight-symbol)
(global-set-key [(meta f3)] 'highlight-symbol-at-point)

;; (require 'chop)
;; (global-set-key "\M-p" 'chop-move-up)
;; (global-set-key "\M-n" 'chop-move-down)

;; folding mode
(require 'folding)
(autoload 'folding-mode          "folding" "Folding mode" t)
(autoload 'turn-off-folding-mode "folding" "Folding mode" t)
(autoload 'turn-on-folding-mode  "folding" "Folding mode" t)
;(folding-add-to-marks-list 'matlab-mode "%{{{" "%}}}" nil t)




(require 'fold-dwim)
(global-set-key (kbd "<f7>")      'fold-dwim-toggle)
(global-set-key (kbd "<M-f7>")    'fold-dwim-hide-all)
(global-set-key (kbd "<S-M-f7>")  'fold-dwim-show-all)


;; speedbar
(require 'sr-speedbar)
(global-set-key (kbd "C-S-s") 'sr-speedbar-toggle)

;; docview
;; (load-file (expand-file-name "~/.emacs/doc-view.el"))
;; ("\\.pdf$" . open-in-doc-view)
;; ("\\.dvi$" . open-in-doc-view)
;; ("\\.ps$" . open-in-doc-view)
;; (defun open-in-doc-view ()
;;   (interactive)
;;   (doc-view
;;    (buffer-file-name (current-buffer))
;;    (buffer-file-name (current-buffer))))
;; (add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; Org-mode:
(setq load-path (cons "~/.emacs.d/elisp/org-6.26d/lisp" load-path))
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cq" 'org-iswitchb)

(global-font-lock-mode 1)			  ; for all buffers
(add-hook 'org-mode-hook 'turn-on-font-lock)	  ; Org buffers only

;; Autohotkey (Windows-specific)
;; choose ahk-mode rather than ahk-org mode:
(when (eq system-type 'windows-nt)
  (setq ahk-syntax-directory "C:/Program Files/AutoHotkey/Extras/Editors/Syntax/")
  (add-to-list 'auto-mode-alist '("\\.ahk$" . ahk-mode))
  (autoload 'ahk-mode "ahk-mode"))

;; Make dired sort case-insensitive on Windows
(when (eq system-type 'windows-nt)
  (setq ls-lisp-emulation   'MS-Windows
	ls-lisp-dirs-first  t
	ls-lisp-ignore-case t
	ls-lisp-verbosity   (nconc (and (w32-using-nt)
					'(links)) '(uid)))
)

(when (eq system-type 'windows-nt)
  (require 'cygwin-mount)
  (cygwin-mount-activate)
  (require 'w32-symlinks)
 ;(require 'setup-cygwin)
  )



;;{{{ `-- Explorer here / terminal here functions
; Windows explorer to go to the file in the current buffer
;; (defun explorer-here ()  
;;   "Call when editing a file in a buffer. Open windows explorer in the current directory and select the current file"  
;;   (interactive)  
;;   (w32-shell-execute 
;;     "open" "explorer"  
;;     (concat "/e,/select," (convert-standard-filename buffer-file-name))
;;   )
;; )

(defun explorer-here ()   
  "Open Windows Explorer to FILE (a file or a folder)."
  (interactive)
  (let ((w32file "") (dir ""))
    (if
	(and (local-variable-p 'dired-directory) dired-directory)
	(setq w32file (substitute ?\\ ?/ (expand-file-name (convert-standard-filename dired-directory))))
      (setq w32file (substitute ?\\ ?/ (expand-file-name (convert-standard-filename buffer-file-name))))
      )
    (if (file-directory-p w32file)
	(w32-shell-execute "explore" w32file "/e,/select,")
      (w32-shell-execute "open" "explorer" (concat "/e,/select," w32file)))))

(defun terminal-here ()   
  "Launch external terminal in the current buffer's directory or current dired
directory.  (Works by grabbing the directory name and passing as an argument to
a batch file.  Note the (toggle-read-only) workaround; the command will not run
in dired mode without it."
  (interactive)
  (let ((dir "") (diredp nil))
    (cond
     ((and (local-variable-p 'dired-directory) dired-directory)
      (setq dir dired-directory)
      (setq diredp t)
      (toggle-read-only)
)
     ((stringp (buffer-file-name))
      (setq dir (file-name-directory (buffer-file-name))))
      )
    (shell-command (concat "~/bin/mrxvt_win.bat \""dir"\" 2>/dev/null &") 
 (universal-argument))
    (if diredp (toggle-read-only))
))


;; try external ls as per ntemacs faq 7.9 (doesn't work well)
;; (when (eq system-type 'windows-nt)
;;   (setq ls-lisp-use-insert-directory-program t)      ;; use external ls
;;   (setq insert-directory-program "c:/cygwin/bin/ls") ;; ls program name
;; )

;;}}}

;; swap windows (steve yegge)
(defun swap-windows ()
 "If you have 2 windows, it swaps them." (interactive) (cond ((not (= (count-windows) 2)) (message "You need exactly 2 windows to do this."))
 (t
 (let* ((w1 (first (window-list)))
	 (w2 (second (window-list)))
	 (b1 (window-buffer w1))
	 (b2 (window-buffer w2))
	 (s1 (window-start w1))
	 (s2 (window-start w2)))
 (set-window-buffer w1 b2)
 (set-window-buffer w2 b1)
 (set-window-start w1 s2)
 (set-window-start w2 s1)))))
(define-key ctl-x-4-map (kbd "t") 'swap-windows)

;; TODO:
;; what needs to happen re: kill-window-other-buffer:
;; need to check the winner stack and see if the last change was a window config
;; change or just a buffer change; if config change then winner-undo o/w just kill
(defun kill-buffer-other-window (arg)
  "Kill the buffer in the other window,
 and make the current buffer full size.
 If no other window, kills current buffer."
  (interactive "p")
  (let ((buf (save-window-excursion (other-window arg) (current-buffer))))
    (delete-windows-on buf) (kill-buffer buf)) (winner-undo))
(define-key ctl-x-4-map (kbd "k") 'kill-buffer-other-window)


;; (defvar my-display-buffer-list)
;; (add-to-list 'my-display-buffer-list "*TeX Help*")

;; ;b (setq display-buffer-function (quote my-display-buffer))


;; (defun my-display-buffer (buffer-or-name &optional not-this-window frame)
;;   (let (display-buffer-function window)
;;     (setq window (display-buffer buffer-or-name not-this-window))
;;     (when (member (buffer-name buffer-or-name) my-display-buffer-list)
;;       ;(debug)
;;       (select-window window)
;;       ;(view-mode t)
;;       (message "FOOBAR")
;;       )
;;     (set-window-buffer window buffer)
;;     (select-window window)
;;     window))



;; ispell:
(when (eq system-type 'windows-nt)
    (setq ispell-program-name "C:/Program Files/Aspell/bin/aspell.exe")
)

;; git
(if (eq system-type 'windows-nt)
    (require 'git-mswin)
  (require 'git))


;;{{{ dired enhancements:
(require 'dired-details)
;; (dired-details-install)  ;;;; this seems to break dired, TODO: fix
(require 'dired+)
(toggle-dired-find-file-reuse-dir 1)	; show subdirs in same buffer

(define-key dired-mode-map [(backspace)] 'dired-up-directory) 



(defun dired-show-only (regexp)		; show only files that match a 
   (interactive "sFiles to show (regexp): ") ; regex (e.g. .*nb$ to only
   (dired-mark-files-regexp regexp)	     ; show .nb files)
   (dired-toggle-marks)
   (dired-do-kill-lines))
(define-key dired-mode-map [?%?h] 'dired-show-only) 

(add-hook 'dired-after-readin-hook	; put "dired" in buffer name
          #'(lambda () (unless (string-match "*dired*" (buffer-name))
			 (rename-buffer (concat "*dired* " (buffer-name))))))

;;    (add-hook 'dired-load-hook
;;             (lambda () (load "dired-x") 
;;                  ;; set dired-x global variables here.))
;; ^^^ commented out b/c dired-x is loaded by dired+
(add-hook 'dired-mode-hook		; requires dired-x 
	  (function (lambda () ; Set dired-x buffer-local variables here. 
		      ;; (dired-omit-mode 1) ; turn on omit mode and
 		      ;; (setq dired-omit-files ; omit the "dot" files
		      ;; 	    (concat dired-omit-files "\\|^\\..+$"))
		      )))


;; unfill paragraph (remove hard linebreaks; use w/ longlines mode)
;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
;; Takes a multi-line paragraph and makes it into a single line of text.
(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
  (fill-paragraph nil)))
;;}}}

;; Use isearch+ (cf http://www.emacswiki.org/emacs/IsearchPlus)
(eval-after-load "isearch" '(require 'isearch+))
   ; avoid automatic mark that persists when terminating search w/ arrow keys:
(eval-after-load "isearch+" '(setq isearchp-set-region-flag nil)) 
(define-key isearch-mode-map [(control ? )] 'set-region-around-search-target)
; control-SPC, overrides the default isearchp setting of isearchp-toggle-set-region
(global-set-key [f11] 'isearch-forward)
(define-key isearch-mode-map [f11] 'isearch-repeat-forward)
(global-set-key [(shift f11)] 'isearch-backward)
(define-key isearch-mode-map [(shift f11)] 'isearch-repeat-backward)
(define-key view-mode-map (kbd "/") 'isearch-forward)
(define-key dired-mode-map (kbd "/") 'isearch-forward)
; overrides default mark directories
(define-key isearch-mode-map (kbd "<C-n>") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "<C-/>") 'isearch-repeat-forward)
(define-key isearch-mode-map (kbd "<C-p>") 'isearch-repeat-backward)
(define-key isearch-mode-map (kbd "<C-?>") 'isearch-repeat-backward)

;; modify C-s C-w to match whole word
(defun my-isearch-yank-word-or-char-from-beginning ()
  "Move to beginning of word before yanking word in isearch-mode."
  (interactive)
  ;; Making this work after a search string is entered by user
  ;; is too hard to do, so work only when search string is empty.
  (if (= 0 (length isearch-string))
      (beginning-of-thing 'word))
  (isearch-yank-word-or-char)
  ;; Revert to 'isearch-yank-word-or-char for subsequent calls
  (substitute-key-definition 'my-isearch-yank-word-or-char-from-beginning 
			     'isearch-yank-word-or-char
			     isearch-mode-map))

(add-hook 'isearch-mode-hook
 (lambda ()
   "Activate my customized Isearch word yank command."
   (substitute-key-definition 'isearch-yank-word-or-char 
			      'my-isearch-yank-word-or-char-from-beginning
			      isearch-mode-map)))


;; turn on view mode for read-only files
(setq view-read-only t)

;(require 'viewer)
;(viewer-stay-in-setup)
;(setq view-mode-by-default-regexp "/regexp-to-path")
;; (defun temp-mode-view (buffer)
;;   (message "TEEEEEEEEEEEEEEMP")
;; )
;; ;; (if (string-match (buffer-name buffer) "*Help*")
;; ;;       (view-mode buffer)))

;; (setq temp-buffer-show-hook 'temp-mode-view) 

;; (global-set-key (kbd "C-/") 'isearch-forward)  ; conflicts w/ undo?


;; w3m
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(setq w3m-use-cookies t)
(autoload 'w3m-type-ahead-mode "wta" t)
(add-hook 'w3m-mode-hook 'w3m-type-ahead-mode)

;; mew
(add-to-list 'load-path "~/.emacs.d/elisp/mew-6.2.51")
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)



;; tramp
(require 'tramp)
(setq tramp-verbose 2)
(setq tramp-default-method "ssh")
(setq tramp-debug-buffer nil)
;; (setq tramp-password-end-of-line "\r\n")
(nconc (cadr (assq 'tramp-login-args (assoc "ssh" tramp-methods)))
       '(("bash" "-i")))
(setcdr (assq 'tramp-remote-sh (assoc "ssh" tramp-methods))
	'("bash -i"))


;; stuff that was necessary to get tramp to work under cygwin
; (setq load-path (append load-path '("/usr/share/emacs/22.1/lisp/emacs-lisp")))
; (setq load-path (append load-path '("/usr/share/emacs/22.1/lisp/calendar")))
; (require 'tramp)

;; old matlab mode stuff:
; (autoload 'matlab-mode "~/emacs.d/matlab.el" "Enter Matlab mode." t)
; (setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
; (autoload 'matlab-shell "~/emacs.d/matlab.el" "Interactive Matlab mode." t)
; (setq load-path (append load-path '("~/.emacs.d"))) 

;; Matlab mode stuff as per Matlab (windows) instructions:
;(add-to-list 'load-path "~/.emacs.d/elisp/matlab-emacs/") 

(load-file (expand-file-name 
	    "~/.emacs.d/elisp/cedet-1.0pre4/common/cedet.el"))

;; mathematica mode
(load-file "~/.emacs.d/elisp/mathematica.el")
(setq auto-mode-alist (append '(("\\.mma\\'" . mathematica-mode))
			      auto-mode-alist))
(setq mathematica-never-start-kernel-with-mode t)
(if (eq system-type 'windows-nt)
  (setq mathematica-command-line "C:/Program Files/Wolfram Research/Mathematica/7.0/math")
  (setq mathematica-command-line "/usr/local/bin/math")
)

(setq load-path (cons "~/.emacs.d/elisp/matlab-emacs/" load-path))

; (require 'matlab-load)
(setq-default matlab-show-mlint-warnings t)
(setq-default matlab-highlight-cross-function-variables t)


(autoload 'matlab-eei-connect "matlab-eei" 
  "Connects Emacs to MATLAB's external editor interface.")

(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)

(setq matlab-indent-function t)	; if you want function bodies indented
(setq matlab-verify-on-save-flag nil)	; turn off auto-verify on save
(defun my-matlab-mode-hook ()
;  (define-key matlab-mode-map [(meta j)] 'bc-previous)
  (setq fill-column 77)
  (imenu-add-to-menubar "Find"))	; where auto-fill should wrap
(add-hook 'matlab-mode-hook 'my-matlab-mode-hook)
; ~matlab-mode-stuff

(setq transient-mark-mode t)
(column-number-mode 1)
(require 'paren)
(show-paren-mode 1)

;;dark room:
;; (require 'martin-darkroom)

;;word counting:
(defun wc ()
  (interactive)
  (message "Word count: %s" (how-many "\\w+" (point-min) (point-max))))

;;  Allow ido to open recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 500)
(setq recentf-max-menu-items 60)

(defun ido-choose-from-recentf ()
 "Use ido to select a recently opened file from the `recentf-list'"
 (interactive)
 (let ((home (expand-file-name (getenv "HOME"))))
   (find-file
    (ido-completing-read "Recentf open: "
                         (mapcar (lambda (path)
                                   (replace-regexp-in-string home "~" path))
                                 recentf-list)
                         nil t))))

(global-set-key (kbd "C-x f") 'ido-choose-from-recentf)
(global-set-key (kbd "C-x M-f") 'set-fill-column)
;;~ end set ido to do recent files

;;{{{  LaTex/AucTeX settings
(require 'tex-site)
(when (eq system-type 'windows-nt)
  (require 'tex-mik))

;;Anrei says forcing latex mode for tex files explicitly is better in some way
(setq auto-mode-alist (append '(("\\.tex$" . latex-mode))
			      auto-mode-alist))    

;(add-hook 'TeX-mode-hook 'TeX-PDF-mode) ; NB: if already in TeX-PDF-mode
                            ; via some other magic, this will turn it OFF

(add-hook 'TeX-mode-hook 'auto-fill-mode) ; hook the auto-fill-mode with LaTeX-mode
(add-hook 'TeX-mode-hook 'outline-minor-mode) 

;; (add-hook 'outline-mode-hook
;; 	  '(lambda ()
;; 	     (require 'outline-mode-easy-bindings)))

;; (add-hook 'outline-minor-mode-hook
;; 	  '(lambda ()
;; 	     (require 'outline-mode-easy-bindings)))
 


(add-hook 'TeX-mode-hook '(lambda () (setq fill-column 77)))
;; (add-hook 'LaTeX-mode-hook '(lambda ()
;; 			      (setq outline-minor-mode-prefix "\C-c\C-o")))
(setq-default fill-column 77)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex) 
(add-hook 'LaTeX-mode-hook (lambda ()
			     (TeX-fold-mode 1))) ;turn on
					;tex-fold-mode
					;by default
(add-hook 'LaTeX-mode-hook
	  (function (lambda ()
		      (setq TeX-auto-save t)
		      (setq TeX-parse-self t)
		      )))
   ; not necessary, I think....:
;; (add-hook 'LaTeX-mode-hook
;; 	  (function ( lambda()
;; 		      (setq TeX-command-default "LaTeX")
;; 		      )))

;; Tun on the flyspell mode
(defun turn-on-flyspell-mode () (flyspell-mode t))
;; disable spell chekcing of out commented lines
(setq ispell-check-comments nil)

(add-hook 'LaTex-mode-hook 'turn-on-flyspell-mode)
(add-hook 'TeX-mode-hook 'turn-on-flyspell-mode)
(add-hook 'html-mode-hook 'turn-on-flyspell-mode)

(add-hook 'LaTeX-mode-hook
	  (function (lambda ()
		      (setq ispell-parser 'tex)
		      )))

;;}}}~ end LaTeX/AucTeX customizations

;; uniquify settings
(require 'uniquify)
(add-hook 'eshell-post-command-hook 'eshell-dir-buffer-name)

(defun eshell-rename-buffer (x)
  (rename-buffer
   (concat (car (split-string (buffer-name) "|")) "|" x)
   t))

(defun eshell-dir-buffer-name () (eshell-rename-buffer default-directory))


(setq uniquify-buffer-name-style 'reverse)
(setq uniquify-separator "|")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")
;;~ end uniqify settings

;; Change title bar to ~/file-directory if the current buffer is a
;; real file or buffer name if it is just a buffer.
;; (setq frame-title-format 
;;       '(:eval 
;;         (if buffer-file-name 
;;             (replace-regexp-in-string (getenv "HOME") "~" 
;;                                       (file-name-directory buffer-file-name)) 
;;           (buffer-name))))

;(setq frame-title-format (concat invocation-name "@" system-name ": %b %+%+ %f"))
(setq frame-title-format (concat invocation-name ": %b %+%+ %f"))

   ; (setq frame-title-format "%b") ; simpler code for setting frame title
;;~ end rename title bar

;; icicles mode:
;(setq load-path (cons "~/.emacs.d/elisp/icicles/" load-path))


;;{{{ ido settings:
(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'no-prompt)
(ido-everywhere t)
(setq ido-max-prospects 15)
;; (defvar ido-execute-command-cache nil)

;; (defun ido-execute ()
;;   (interactive)
;;   (let ((ido-max-prospects 7))
;;   (call-interactively
;;    (intern
;;     (ido-completing-read
;;      "M-x "
;;      (progn
;;        (unless ido-execute-command-cache
;; 	 (mapatoms (lambda (s)
;; 		     (when (commandp s)
;; 		       (setq ido-execute-command-cache
;; 			     (cons (format "%S" s) ido-execute-command-cache)))))
;; 	 (setq ido-execute-command-cache 
;; 	       (sort (sort ido-execute-command-cache 'string-lessp)
;; 		     (lambda (x y) (< (length x) (length y)))))
;; 	 )
;;        ido-execute-command-cache))))))

;; (defun ido-update-mx ()
;;   (setq ido-execute-command-cache nil)
;; )

(defadvice completing-read
      (around foo activate)
      (if (boundp 'ido-cur-list)
          ad-do-it
        (setq ad-return-value
              (ido-completing-read
               prompt
               (all-completions "" collection predicate)
               nil require-match initial-input hist def))))

;; (defun ido-execute ()
;;  (interactive)
;;  (let ((ido-max-prospects 7))
;;  (call-interactively
;;   (intern
;;    (ido-completing-read
;;     "M-x "
;;     (let (cmd-list)
;;       (mapatoms (lambda (S)
;;                   (when (commandp S)
;;                     (setq cmd-list (cons (format "%S" S) cmd-list)))))
;;       (sort (sort cmd-list 'string-lessp)
;;             (lambda (x y) (< (length x) (length y))))))))))
;; (global-set-key "\M-x" 'ido-execute)
;; (global-set-key "\C-x\C-m" 'ido-execute)
;; (global-set-key "\C-c\C-m" 'ido-execute)
;;}}}

;; further ido key refinements -- no easy customization; modify ido.el
;; ;    (define-key map "\t" 'ido-complete)
;;     (define-key map "\t" 'ido-next-match)
;;     (define-key map [(shift tab)] 'ido-prev-match)


;;this functionality is superceded by smex:
(require 'smex)
;  (smex-initialize) is put at the end of .emacs
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c M-x") 'smex-update-and-run)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
	  





;; --- Quick bookmarks -----------------------------------------------------
(require 'af-bookmarks)
(global-set-key [(control f2)]  'af-bookmark-toggle )
(global-set-key "\C-cb"  'af-bookmark-toggle )
(global-set-key [f2]  'af-bookmark-cycle-forward )
(global-set-key [(shift f2)]  'af-bookmark-cycle-reverse )
(global-set-key [(control shift f2)]  'af-bookmark-clear-all )
(global-set-key "\C-c\C-b"  'af-bookmark-clear-all )
(global-set-key "\C-ccb"  'af-bookmark-clear-all )



;;{{{ --- Breadcrumb settings ---------------------------------------------------
;(require 'breadcrumb)
;; (autoload 'bc-set "breadcrumb" "Set bookmark in current point." t)
;; (autoload 'bc-previous "breadcrumb" "Go to previous bookmark." t)
;; (autoload 'bc-next "breadcrumb" "Go to next bookmark." t)
;; (autoload 'bc-local-previous "breadcrumb" "Go to previous local bookmark." t)
;; (autoload 'bc-local-next "breadcrumb" "Go to next local bookmark." t)
;; (autoload 'bc-goto-current "breadcrumb" "Go to the current bookmark." t)
;; (autoload 'bc-list "breadcrumb" "List all bookmarks in menu mode." t)
;; (autoload 'bc-clear "breadcrumb" "Clear all bookmarks." t) 
;;   ; breadcrumb keys:
;; ; (global-set-key (kbd "S-SPC")         'bc-set)  ;; used to be S-M-SPC
;; (global-set-key (kbd "C-S-SPC") 'bc-set)
;; (global-set-key (kbd "C-S-<left>") 'bc-previous)
;; (global-set-key (kbd "C-S-<right>") 'bc-next)
;; (global-set-key (kbd "C-S-<down>") 'bc-local-previous)
;; (global-set-key (kbd "C-S-<up>") 'bc-local-next)
;; (global-set-key (kbd "C-S-<return>") 'bc-goto-current)
;; (global-set-key (kbd "C-S-l") 'bc-list)
;; (global-set-key (kbd "C-S-c") 'bc-clear)

;;(global-set-key [f2]         'bc-set) 
;; Shift-SPACE for set bookmark
;; (global-set-key [(meta j)]              'bc-previous)       ;; M-j for jump to previous
;; (global-set-key [(shift meta j)]        'bc-next)           ;; Shift-M-j for jump to next
;; (global-set-key [(meta up)]             'bc-local-previous) ;; M-up-arrow for local previous
;; (global-set-key [(meta down)]           'bc-local-next)     ;; M-down-arrow for local next
;; (global-set-key [(control c)(j)]        'bc-goto-current)   ;; C-c j for jump to current bookmark
;; (global-set-key [(control x)(meta j)]   'bc-list)           ;; C-x M-j for the bookmark menu list

;;}}}~end Breadcrumb settings ---------------------------------------------------

;; Add color to a shell running in emacs 'M-x shell'
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; Automatically enable hideshow minor mode for specified major modes
(add-hook 'c-mode-hook 'hs-minor-mode)
(add-hook 'c++-mode-hook 'hs-minor-mode)
(add-hook 'perl-mode-hook 'hs-minor-mode)


(global-unset-key [f1])
(global-set-key [f1] 'hs-toggle-hiding)


;;{{{ -- Andrei's magic line-dragging code --------------------------------------
(defun move-line (&optional n)
 "Move current line N (1) lines up/down leaving point in place."
 (interactive "p")
 (when (null n)
   (setq n 1))
 (let ((col (current-column)))
   (interactive)
   (beginning-of-line)
   (next-line 1)
   (transpose-lines n)
   (previous-line 1)
   (forward-char col)))

(defun move-line-up (n)
 "Moves current line N (1) lines up leaving point in place."
 (interactive "p")
 (move-line (if (null n) -1 (- n))))

(defun move-line-down (n)
 "Moves current line N (1) lines down leaving point in place."
 (interactive "p")
 (move-line (if (null n) 1 n)))

(global-set-key (kbd "S-M-<down>") 'move-line-down) 
(global-set-key (kbd "S-M-<up>") 'move-line-up)
 
;;}}}~end Andrei's magic line-dragging code -------------------------------------

;; -- Jump by n lines up/down:
(defun jump-forward-lines()
   " This function will move the cursor forward some lines (currently 10)."
   (interactive)
   (forward-line 5)
)
(defun jump-back-lines()
   " This function will move the cursor back a few lines (currently 10)."
   (interactive)
   (forward-line -5)
)
(global-set-key (kbd "M-<down>") 'jump-forward-lines)
(global-set-key (kbd "M-<up>") 'jump-back-lines)



;; make buffers focus when they are displayed in another frame 
;; (i.e. make the display-buffer and pop-to-buffer identical in functionality
;; (defadvice display-buffer (after display-buffer-focus activate compile)
;; "Focuses the buffer after switching to it, mimicking pop-to-buffer"
;; (other-window 1)
;; )
;(setq pop-up-frames nil)
;(setq pop-up-windows t)


;;{{{ -- enable killing/copying lines w/o having them marked; duplicate lines ---
;; cf http://www.emacswiki.org/emacs/SlickCopy
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position)
	   (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))

(defun duplicate-current-line ()
  (interactive)
  (beginning-of-line nil)
  (let ((b (point)))
    (end-of-line nil)
    (copy-region-as-kill b (point)))
  (beginning-of-line 2)
  (open-line 1)
  (yank)
  (back-to-indentation))

;; Author: Eberhard Mattes <mattes@azu.informatik.uni-stuttgart.de>
(defun emx-duplicate-current-line (arg)
  "Duplicate current line.
Set mark to the beginning of the new line.
With argument, do this that many times."
  (interactive "*p")
  (setq last-command 'identity) ; Don't append to kill ring
  (let ((s (point)))
    (beginning-of-line)
    (let ((b (point)))
      (forward-line)
      (if (not (eq (preceding-char) ?\n)) (insert ?\n))
      (copy-region-as-kill b (point))
    (while (> arg 0)
      (yank)
      (setq arg (1- arg)))
    (goto-char s))))


(defun duplicate-current-region ()
  (interactive)
  (copy-region-as-kill (region-beginning) (region-end))
  (yank)
  (back-to-indentation))

(global-set-key "\C-cd" 'emx-duplicate-current-line)
(global-set-key (kbd "s-w") 'duplicate-current-line)
(global-set-key (kbd "s-k") 'kill-ring-save)
;;}}}~end enable killing/copying lines w/o having them marked -------------------


(defun save-windows-recompile () "Recompiling"
  (proc
   (window-configuration-to-register ?w)
   (recompile))
  )
(global-set-key [f9] 'recompile)
(global-set-key [f10] 'compile)


;; ;; Helper for compilation. Close the compilation window if
;; ;; there was no error at all.
;; (defun compilation-exit-autoclose (status code msg)
;;   ;; If M-x compile exists with a 0
;;   (when (and (eq status 'exit) (zerop code))
;;     ;; then bury the *compilation* buffer, so that C-x b doesn't go there
;;     (bury-buffer)
;;     ;; and delete the *compilation* window
;;     (delete-window (get-buffer-window (get-buffer "*compilation*"))))
;;   ;; Always return the anticipated result of compilation-exit-message-function
;;   (cons msg code))
;; ;; Specify my function (maybe I should have done a lambda function)
;; (setq compilation-exit-message-function 'compilation-exit-autoclose)

;; enable winner mode for swiching windows configurations
(when (fboundp 'winner-mode)
  (winner-mode 1))

;; (setq compilation-finish-functions 'compile-autoclose)
;; (defun compile-autoclose (buffer string)
;;   (cond ((string-match "finished" string)
;; 	 (bury-buffer "*compilation*")
;; 	 ;;(winner-undo)
;; 	 (jump-to-register ?w)
;; 	 (message "Build successful."))
;; 	(t                                                                    
;; 	 (message "Compilation exited abnormally: %s" string))))


;; Line-wrapping stuff: ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; disable line wrap
;;(setq default-truncate-lines t)

;; make side by side buffers function the same as the main window
(setq truncate-partial-width-windows nil) ;; didn't work the first few times?
;;(setq truncate-lines nil)  ;; had to play w/ it before partial width worked

;; Optionally add key to toggle line wrap
;; (global-set-key [f10] 'toggle-truncate-lines)

;; Replace DOS shell w/ bash ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(let ((var (getenv "HOME")))
;  home-env-var
;  )

;(setenv "HOME" "C:\\cygwin\\home\\Leo")

(when (eq system-type 'windows-nt)
  (add-hook 'comint-output-filter-functions
	    'shell-strip-ctrl-m nil t)
  (add-hook 'comint-output-filter-functions
	    'comint-watch-for-password-prompt nil t)
  (setq exec-path (cons "C:/cygwin/bin" exec-path))
  (setenv "PATH" (concat "C:\\cygwin\\bin;" (getenv "PATH")))
  (setq explicit-shell-file-name "bash")
  (setq explicit-bash-args '("--login" "-i"))
  ;;C:\cygwin\bin\bash -c "/bin/xhere /bin/bash.exe '%L'"
  ;; For subprocesses invoked via the shell
  ;; (e.g., "shell -c command")
  (setq shell-file-name explicit-shell-file-name)
)

;;{{{ ESS/R options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(unless (eq system-type 'windows-nt) ;in win. ess-site is in emacs dir
  (setq load-path (cons "~/.emacs.d/elisp/ess-5.3.8/lisp/" load-path))
)
(require 'ess-site)
(setq ess-ask-for-ess-directory nil)
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-prompt-read-only t)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)
;; Do not echo the evaluated commands into the transcript (R process window)
;; (the output is going to be displayed, however)
(setq  ess-eval-visibly-p nil)

;; This stuff (stolen from emacs wiki?) evaluates things via shift-return
(defun my-ess-start-R ()
  (interactive)
  (if (not (member "*R*" (mapcar (function buffer-name) (buffer-list))))
      (progn
	(delete-other-windows)
	(setq w1 (selected-window))
	(setq w1name (buffer-name))
	(setq w2 (split-window w1))
	(R)
	(set-window-buffer w2 "*R*")
	(set-window-buffer w1 w1name))))

(defun my-ess-eval ()
  (interactive)
  (my-ess-start-R)
  (if (and transient-mark-mode mark-active)
      (call-interactively 'ess-eval-region-and-go)
    (call-interactively 'ess-eval-line-and-go)))

(add-hook 'ess-mode-hook
	  '(lambda()
	     (local-set-key [(shift return)] 'my-ess-eval)))

(add-hook 'ess-mode-hook
	  '(lambda()
	     (setq fill-column 78)))

(add-hook 'inferior-ess-mode-hook
	  '(lambda()
	     (local-set-key [C-up] 'comint-previous-input)
	     (local-set-key [C-down] 'comint-next-input)))

;; Linking ESS with AucTex

(add-to-list 'auto-mode-alist '("\\.Rnw\\'" . Rnw-mode))
(add-to-list 'auto-mode-alist '("\\.Snw\\'" . Snw-mode))
(setq TeX-file-extensions
     '("Snw" "Rnw" "nw" "tex" "sty" "cls" "ltx" "texi" "texinfo"))
(add-hook 'Rnw-mode-hook
	  (lambda ()
	    (add-to-list 'TeX-command-list
			 '("Sweave" "R CMD Sweave %s"
			   TeX-run-command nil (latex-mode) :help "Run Sweave") t)
;			 '("LatexSweave" "%l %(mode) \\input{%s}"

	    (add-to-list 'TeX-command-list
			 '("LatexSweave" "%l %(mode) %s"
			   TeX-run-TeX nil (latex-mode) :help "Run Latex after Sweave") t)
	    (setq TeX-command-default "Sweave")))

(add-hook 'Rnw-mode-hook 'auto-fill-mode) ; hook the auto-fill-mode with LaTeX-mode
(add-hook 'Rnw-mode-hook '(lambda () (setq fill-column 77)))
(setq-default fill-column 77)

;;}}} END ESS/R options ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Macros:
(fset 'paste-BOL
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("" 0 "%d")) arg)))
(global-set-key "\C-c\C-p" 'paste-BOL)
(global-set-key "\C-cpb" 'paste-BOL)
(fset 'paste-EOL
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ("" 0 "%d")) arg)))
(global-set-key "\C-cpe" 'paste-EOL)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(TeX-output-view-style (quote (("^dvi$" "^pstricks$\\|^pst-\\|^psfrag$" "dvips %d -o && start \"\" %f") ("^dvi$" "." "yap -1 %dS %d") ("^pdf$" "." "'C:/Program Files/Ghostgum/gsview/gsview32.exe' %o") ("^html?$" "." "start \"\" %o"))))
 '(cygwin-mount-cygwin-bin-directory "c:\\cygwin\\bin")
 '(desktop-path (quote ("~/.emacs.d/" "~" ".")))
 '(desktop-save-mode nil)
 '(help-window-select t)
 '(matlab-shell-command "matlab-terminal")
 '(mlint-programs (quote ("mlint" "win32/mlint" "/opt/matlab/R2008a/bin/glnxa64/mlint" "C:\\Program Files\\MATLAB\\R2008b\\bin\\win32\\mlint.exe")))
 '(org-replace-disputed-keys t)
 '(preview-transparent-color nil)
 '(scroll-preserve-screen-position 1)
 '(set-mark-command-repeat-pop 1)
 '(smooth-scroll-margin 5)
 '(speedbar-show-unknown-files t)
 '(thing-types (quote ("word" "symbol" "sexp" "list" "line" "paragraph" "page" "defun" "number" "form")))
 '(w32-symlinks-handle-shortcuts t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

(put 'narrow-to-region 'disabled nil)



; ----- init smex ---------
(smex-initialize)
; -------------------------

; (require 'frame-restore) ; don't work for me
