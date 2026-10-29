;; -*- lexical-binding: t -*-
(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file :no-error-if-file-is-missing)

;; use an org file as config

(org-babel-load-file "~/.emacs.d/config.org")
