;; -*- lexical-binding: t -*-

;; when at a URL, pressing enter opens it up
(require 'package)
(package-initialize)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; hide compilation warning (during pkg install and what not) and move them to a buffer Ig ;?

(add-to-list 'display-buffer-alist
             '("\\`\\*\\(Warnings\\|Compile-Log\\)\\*\\'"
               (display-buffer-no-window)
               (allow-no-window . t)))
;; delete the selected text upon text insertion

(use-package delsel
  :ensure nil ; no need to install it as it is built-in
  :hook (after-init . delete-selection-mode))

;; refinment of C-g this is no way my code but hopefully I'll learn from this process

(defun prot/keyboard-quit-dwim ()
  "Do-What-I-Mean behaviour for a general `keyboard-quit'.

  The generic `keyboard-quit' does not do the expected thing when
  the minibuffer is open.  Whereas we want it to close the
  minibuffer, even without explicitly focusing it.

  The DWIM behaviour of this command is as follows:

  - When the region is active, disable it.
  - When a minibuffer is open, but not focused, close the minibuffer.
  - When the Completions buffer is selected, close it.
  - In every other case use the regular `keyboard-quit'."
  (interactive)
  (cond
   ((region-active-p)
    (keyboard-quit))
   ((derived-mode-p 'completion-list-mode)
    (delete-completion-window))
   ((> (minibuffer-depth) 0)
    (abort-recursive-edit))
   (t
    (keyboard-quit))))

(define-key global-map (kbd "C-g") #'prot/keyboard-quit-dwim)

(setq org-return-follows-link t)
(setq org-M-RET-may-split-line '((item . nil)))


;; Non-nil means font-lock should hide

;; the emphasis marker characters.

(setq org-hide-emphasis-markers t)

;; start folded

(setq org-startup-folded 'fold)

;;unhide nested stuff
(setq org-hide-leading-stars nil)

;; Better list bullets.
(font-lock-add-keywords
 'org-mode
 '(("^ +\\([-*]\\) "
    (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; Pretty fontification of source code blocks.
(setq org-src-fontify-natively t)

;; Use `zsh' instead of `sh' in the `shell' code block.
(setq org-babel-sh-command "zsh")

;; Use C++17.
(setq org-babel-C++-compiler "g++ -std=c++17")

;; `org-babel' languages.
(require 'ob-tangle)
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (shell . t)
   (python . t)
   (C . t)
   (calc . t)
   (latex . t)
   (gnuplot . t)
   (sqlite . t)))

;; No confirmation on block execution.
(setq org-confirm-babel-evaluate nil)

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)

;; Enable Evil and evil-collection 
(setq evil-want-integration t) ;; This is optional since it's already set to t by default.
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)
(when (require 'evil-collection nil t)
  (evil-collection-init))

;;use tab to fold / unfold stuff in org
(with-eval-after-load 'org
  (evil-define-key 'normal org-mode-map (kbd "TAB") 'org-cycle))

;; commeting stuff with gcc

(require 'evil-commentary)
(evil-commentary-mode)

;; disable goy stuff uptop

(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)


;; fonts


(let ((mono-spaced-font "Iosevka Nerd Font Mono")
      (proportionately-spaced-font "Iosevka"))
  (set-face-attribute 'default nil :family mono-spaced-font :height 150)
  (set-face-attribute 'fixed-pitch nil :family mono-spaced-font :height 1.5)
  (set-face-attribute 'variable-pitch nil :family proportionately-spaced-font :height 1.5))

;; icon fonts

(use-package nerd-icons
  :ensure t)

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(use-package nerd-icons-dired
  :ensure t
  :hook
  (dired-mode . nerd-icons-dired-mode))

;; theme
(use-package tokyo-night
  :ensure t
  :config
  (load-theme 'tokyo-night-moon t))

;; terminal stuff 

(use-package vterm
:ensure t)

;; open vterm
(keymap-global-set "C-c v" 'vterm)

;; whenever I'm in vterm don't enable evil
(add-hook 'vterm-mode-hook 'evil-mode -1)

;; markdown mode

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
	      ("C-c C-e" . markdown-do)))

;; copying an image using markdown (not working for some reason) TODO: later fix this up
(with-eval-after-load 'markdown-mode
  (keymap-local-set "C-c C-i" 'markdown-insert-image))

  ;; Set custom markdown preview function
(setq markdown-live-preview-window-function #'my-markdown-preview-function)

;; always open the preview window at the right
(setq markdown-split-window-direction 'right)
;; always open the preview window at the bottom
(setq markdown-split-window-direction 'below)

;; delete exported HTML file after markdown-live-preview-export is called
(setq markdown-live-preview-delete-export 'delete-on-export)

(add-hook 'prog-mode-hook 'display-line-numbers-mode)
