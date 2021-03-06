(add-to-list 'load-path (expand-file-name "~/.emacs.d/"))
(require 'noprompt-util)
(require 'noprompt-package)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; General settings
(when (display-graphic-p)
  (progn
    (set-face-attribute 'default nil :font "DejaVu Sans Mono" :height 130)
    (global-set-key (kbd "M-<return>") 'maximize-frame)
    (global-set-key (kbd "M-=") 'increase-font-height)
    (global-set-key (kbd "M--") 'decrease-font-height)))

;; Turn off the annoying visual bell.
(setq visible-bell nil)

;; Turn on blinking cursor
(blink-cursor-mode)
(idle-highlight-mode)

;; Turn off line highlighting.
(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)
;; Turn off idle highlight mode. It's annnoying.
(remove-hook 'prog-mode-hook 'esk-turn-on-idle-highlight-mode)

;; Color theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'deeper-blue t)
(set-face-attribute 'font-lock-comment-face 'nil :slant 'italic)

(require 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;; Smooth scrolling.
(setq scroll-step 1
      scroll-conservatively 10000)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Evil/Keybindings
(require 'ace-jump-mode)

(require 'key-chord)
(key-chord-mode 1)

(require 'evil)
(evil-mode t)

(setq evil-shift-width 2
      evil-default-cursor t)

;;;; Vim style functions

(defun gui (face &rest options)
  "Shorthand for set-face-attribute for FACE."
  (progn
    (eval (append '(set-face-attribute face nil) options))))

(defun guibg (face color)
  "Set face background for FACE to COLOR."
  (set-face-background face color))

(defun guifg (face color)
  "Set face foreground for FACE to COLOR."
  (set-face-foreground face color))

(defun nmap (key def)
  "Define an Evil normal state sequence."
  (define-key evil-normal-state-map key def))

(defun nlmap (key def)
  "Define a local Evil normal state sequence."
  (define-key evil-normal-state-local-map key def))

(defun imap (key def)
  "Define an Evil insert state sequence."
  (define-key evil-insert-state-map key def))

(defun ilmap (key def)
  "Define a local Evil insert state sequence."
  (define-key evil-insert-state-local-map key def))

;;;; Normal state bindings

;;mapped these next 4 to adjust frame sizes
(nmap (kbd "C-8") (kbd "C-3 C-2 C-x ^"))
(nmap (kbd "C-7") (kbd "C-- C-2 C-3 C-x ^"))
(nmap (kbd "C-9") (kbd "C-x }"))
(nmap (kbd "C-0") (kbd "C-x {"))

;;(nmap (kbd "C-j") 'evil-scroll-page-down)
;;(nmap (kbd "C-k") 'evil-scroll-page-up)
(nmap (kbd "C-j") (kbd "12j"))
(nmap (kbd "C-k") (kbd "12k"))
(nmap (kbd "C-f") 'find-file)

(nmap "zo" 'evil-toggle-fold)
(nmap "zc" 'evil-toggle-fold)

(nmap (kbd "SPC") 'ace-jump-mode)
(nmap (kbd "S-SPC") 'ace-jump-mode-pop-mark)


(nmap (kbd "C-h") (kbd "20h"))
(nmap (kbd "C-M-h") (kbd "C-x <left>"))

(nmap (kbd "C-l") (kbd "20l"))
(nmap (kbd "C-M-l") (kbd "C-x <right>"))

(nmap (kbd "C-M-k") (kbd "C-x k"))
(nmap (kbd ",.") 'load-file)

;;;; Insert state bindings

(imap (kbd "C-j") 'next-line)
(imap (kbd "C-k") 'previous-line)
(imap (kbd "TAB") 'smart-tab)
(imap (kbd "C-n") nil)
(imap (kbd "C-p") nil)

;;mapped these next 4 to adjust frame sizes
(imap (kbd "C-8") (kbd "C-3 C-2 C-x ^"))
(imap (kbd "C-7") (kbd "C-- C-2 C-3 C-x ^"))
(imap (kbd "C-9") (kbd "C-x }"))
(imap (kbd "C-0") (kbd "C-x {"))
;;(imap (kbd "S-<backspace>") (kbd "DEL"))

;;;; Escape

(define-key minibuffer-local-map [escape] 'keyboard-escape-quit)
(define-key minibuffer-local-ns-map [escape] 'keyboard-escape-quit)
(define-key minibuffer-local-completion-map [escape] 'keyboard-escape-quit)
(define-key minibuffer-local-must-match-map [escape] 'keyboard-escape-quit)
(define-key minibuffer-local-isearch-map [escape] 'keyboard-escape-quit)

;;;; Keychord bindings

;; Toggle evil-mode
(key-chord-define-global "GH" 'evil-mode)
(key-chord-define evil-insert-state-map ",e" 'evil-normal-state)
(key-chord-define evil-normal-state-map ",s" 'switch-to-buffer)
(key-chord-define evil-normal-state-map ",k" 'kill-buffer)

;; M-x emulation
(key-chord-define-global "x," 'execute-extended-command)

;; TDL -sample
;;(define-key key-translation-map (kbd "") (kbd "C-x"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Autocomplete
;;(require 'auto-complete)
;;(require 'auto-complete-config)
;;(ac-config-default)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-1.4/dict")
;;(defun set-auto-complete-as-completion-at-point-function ()
;;(setq completion-at-point-functions '(auto-complete)))
;;(add-hook 'auto-complete-mode-hook
;;'set-auto-complete-as-completion-at-point-function)
;;(define-key ac-mode-map (kbd "C-n") 'ac-next)
;;(define-key ac-mode-map (kbd "C-p") 'ac-previous)

;; (defun set-auto-complete-as-completion-at-point-function ()
;;(setq completion-at-point-functions '(auto-complete)))

;;(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
;;(add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
;;(add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)

;;(setq ac-quick-help-delay 1)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Paredit
(require 'paredit)

(defun paredit-wrap-quote ()
  "Wrap the following sexp in double quotes."
  (interactive)
  (save-excursion
    (insert "\"")
    (forward-sexp)
    (insert "\"")))

(defun toggle-paren-style ()
  (interactive)
  (if (eq 'parentheses show-paren-style)
      (setq show-paren-style 'expression)
    (setq show-paren-style 'parentheses)))

(defun define-paredit-keys ()
  (progn
    (nlmap "W(" 'paredit-wrap-round)
    (nlmap "W[" 'paredit-wrap-square)
    (nlmap "W{" 'paredit-wrap-curly)
    (nlmap "W\"" 'paredit-wrap-quote)
    (nlmap "(" 'paredit-backward-slurp-sexp)
    (nlmap ")" 'paredit-backward-barf-sexp)
    (nlmap "{" 'paredit-forward-barf-sexp)
    (nlmap "}" 'paredit-forward-slurp-sexp)
    (nlmap "S" 'paredit-splice-sexp)
    (nlmap "s" 'paredit-split-sexp)
    (nlmap "T" 'transpose-sexps)
    (nlmap "t" 'clojure-test-run-test)
    (nlmap "D" 'paredit-kill)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Clojure/nREPL
(require 'clojure-mode)

(add-hook 'clojure-mode-hook
  '(lambda ()
     (paredit-mode)
     (define-paredit-keys)

     (define-clojure-indent
       (select 'defun)
       (insert 'defun)
       (create-table 'defun)
       (drop-table 'defun)
       (GET 'defun)
       (POST 'defun))

     (rainbow-delimiters-mode)))

(define-key clojure-mode-map (kbd "C-:") 'toggle-clj-keyword-string)

;; nREPL
(require 'nrepl)
(setq nrepl-hide-special-buffers t)
;;(setq nrepl-popup-stacktraces nil)
;;(setq nrepl-popup-stacktraces-in-repl t)
(setq nrepl-history-file "~/.emacs.d/nrepl-history")

;; Auto completion for nREPL
;;(require 'ac-nrepl)
;; (eval-after-load "auto-complete" '(add-to-list 'ac-modes 'nrepl-mode))

(add-hook 'nrepl-interaction-mode-hook 'my-nrepl-mode-setup)
(defun my-nrepl-mode-setup ()
  (require 'nrepl-ritz))

(add-hook 'nrepl-connected-hook 'nrepl-enable-on-existing-clojure-buffers)
(add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)

(add-hook 'nrepl-mode-hook (lambda ()
                             ;;(ac-nrepl-setup)
                             (rainbow-delimiters-mode)
                             ))

(add-hook 'clojure-mode-hook
          (lambda ()
            (define-key nrepl-interaction-mode-map
              (kbd "C-c C-d") 'ac-nrepl-popup-doc)
            (define-key evil-normal-state-local-map
              ",e" 'nrepl-eval-expression-at-point)
            (define-key evil-normal-state-local-map
              ",l" 'nrepl-load-file)))

;; Javert
(load-file "~/.emacs.d/javert/nrepl-inspect.el")
(define-key nrepl-mode-map (kbd "C-c i") 'nrepl-inspect)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Lisp interaction

(add-hook 'lisp-interaction-mode-hook
          (lambda ()
	    (paredit-mode)
            (eldoc-mode)
            (define-paredit-keys)
            (rainbow-delimiters-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs lisp

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
	    (paredit-mode)
            (eldoc-mode)
            (define-paredit-keys)
            (nlmap ",e" 'eval-defun)
            (rainbow-delimiters-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ruby
(require 'ruby-mode)
(require 'ruby-end)
(setq ruby-end-insert-newline nil)

(defun ruby-mode-hook-for-fixing-ruby-electric ()
  (require 'ruby-electric)
  (ruby-electric-mode)
  (ruby-electric-mode -1))

(remove-hook 'ruby-mode-hook 'ruby-electric-mode)
(add-hook 'ruby-mode-hook 'ruby-mode-hook-for-fixing-ruby-electric)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Prolog
(add-to-list 'auto-mode-alist '("\\.pl$" . prolog-mode))

(setq prolog-system 'swi)

(setq prolog-program-name
      '(((getenv "EPROLOG")
         (eval
          (getenv "EPROLOG")))
        (eclipse "eclipse")
        (mercury nil)
        (sicstus "sicstus")
        (swi "/usr/local/bin/swipl")
        (gnu "gprolog")
        (t "gprolog")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; JavaScript
(add-hook 'js-mode-hook 'electric-indent-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Powerline
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/non-elpa/powerline"))
;;(require 'powerline)
;;(powerline-center-evil-theme)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "72348ab1195650b7357fc109c1695da71e0dff6e2cf59f144851afd330308720" "405fda54905200f202dd2e6ccbf94c1b7cc1312671894bc8eca7e6ec9e8a41a2" "978ff9496928cc94639cb1084004bf64235c5c7fb0cfbcc38a3871eb95fa88f6" "e53cc4144192bb4e4ed10a3fa3e7442cae4c3d231df8822f6c02f1220a0d259a" "c5c8c61c9ea795c410d7ddfee26b5ff8156383235af333cc51563164b0d14390" "de2c46ed1752b0d0423cde9b6401062b67a6a1300c068d5d7f67725adc6c3afb" "9bac44c2b4dfbb723906b8c491ec06801feb57aa60448d047dbfdbd1a8650897" "41b6698b5f9ab241ad6c30aea8c9f53d539e23ad4e3963abff4b57c0f8bf6730" "ae8d0f1f36460f3705b583970188e4fbb145805b7accce0adb41031d99bd2580" "51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" "f41fd682a3cd1e16796068a2ca96e82cfd274e58b978156da0acce4d56f2b0d5" "1affe85e8ae2667fb571fc8331e1e12840746dae5c46112d5abb0c3a973f5f5a" default)))
 '(electric-indent-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )




