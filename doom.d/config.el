;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

;; Load personalized bindings
(load! "+bindings")

;; 中文字体
(setq
  mac-command-modifier 'meta
  set-charset-priority 'unicode
  doom-font (font-spec :family "Meslo LG M for Powerline" :size 14)
  doom-big-font (font-spec :family "Meslo LG M for Powerline" :size 18)
  doom-variable-pitch-font (font-spec :family "Hannotate SC" :size 14)
  projectile-project-search-path '("~/codes/")

  plantuml-executable-path "/usr/local/bin/plantuml"
  plantuml-default-exec-mode 'executable
;;  plantuml-server-url "http://localhost:8080"
)


;;全局启用better-jumper
(better-jumper-mode +1)

;;tide
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;;golang
(setenv "GOPATH" (concat ""
                       "/Users/sajia/codes/golang"))
