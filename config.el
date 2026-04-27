;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Make possible more split
(setq window-min-width 30)  ; default is 10, lower = more splits allowed

;; Treemacs config
(use-package! treemacs
  :bind ("<f5>" . treemacs)
  :config
  (treemacs-follow-mode t)
  (treemacs-project-follow-mode t))

;; Golden ratio config
(use-package! golden-ratio
  :hook (doom-first-input . golden-ratio-mode)  ; load after first input
  :config
  (setq golden-ratio-exclude-modes '("treemacs-mode" "neotree-mode")))

;; Vertico config
(use-package! vertico
  :config
  (setq vertico-cycle t))

;; Different display styles per command
(use-package! vertico-multiform
  :hook (vertico-mode . vertico-multiform-mode)
  :config
  (setq vertico-multiform-commands
        '((consult-line (:not posframe))
          (consult-ag   (:not posframe))
          (t posframe))))

;; Floating posframe popup (just for looks)
(use-package! vertico-posframe
  :config
  (setq vertico-posframe-parameters
        '((left-fringe  . 8)
          (right-fringe . 8))))

;; Dabbrev tweaks
(use-package! dabbrev
  :config
  (setq dabbrev-upcase-means-case-search t
        dabbrev-check-all-buffers nil
        dabbrev-check-other-buffers t
        dabbrev-friend-buffer-function 'dabbrev--same-major-mode-p))

;; Spacious-padding
(use-package! spacious-padding
  :hook (doom-first-input . spacious-padding-mode))

;; To open always the LaTeX view on the right
(setq display-buffer-alist
      '(("\\*pdf\\*\\|\\.pdf"
         (display-buffer-in-side-window)
         (side . right)
         (window-width . 0.5))))

;; Make text bigger as default
(setq doom-font (font-spec :family "monospace" :size 16))

;; Remove message window popping up.
;; Still accesible via M-x view-echo-area-messages.
(setq display-buffer-alist
      (append display-buffer-alist
              '(("\\*Messages\\*"
                 (display-buffer-no-window)))))

;; Vterm config
;; Make vterm open with F6 and always on the right
(after! vterm
  (setq vterm-shell "/bin/zsh"
        vterm-max-scrollback 10000))

(defun my/open-vterm-right ()
  "Open vterm in a side window on the right."
  (interactive)
  (let ((buf (get-buffer-create "*vterm*")))
    (with-current-buffer buf
      (unless (derived-mode-p 'vterm-mode)
        (vterm-mode)))
    (display-buffer-in-side-window
     buf '((side . right)
            (window-width . 0.4)))))

(global-set-key (kbd "<f6>") #'my/open-vterm-right)
