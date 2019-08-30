;;; package --- Emacs config
;;; Commentary:

;;; Code:
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
  '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

(add-to-list 'exec-path "/usr/local/bin/")
(add-to-list 'exec-path "~/.local/bin/")

;; Install Intero
(package-install 'intero)
(add-hook 'haskell-mode-hook 'intero-mode)

(setq-default line-spacing 3)

;; hide or shorten minor mode names
(package-install 'diminish)
(require 'diminish)


;; Setup the file backup in a specific directory
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs.d/backup/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

(package-install 'counsel)
;; ivy
(package-install 'ivy) 
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key "\C-r" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
(diminish 'ivy-mode)

;; powerline
(package-install 'powerline)
(require 'powerline)
(powerline-default-theme)
(set-face-attribute 'mode-line nil
                    :foreground "black"
                    :background "orange"
                    :box nil)

(package-install 'smooth-scrolling)
(require 'smooth-scrolling)
(smooth-scrolling-mode 1)

(set-keyboard-coding-system nil)
(setq c-basic-indent 4)
(setq js-indent-level 4)
(setq-default indent-tabs-mode nil)
;(setq-default indent-tabs-mode nil)  ;; Enable this will make some lines blink in Yosemite.
(setq max-mini-window-height 1)

;; find-file-in-repository mode
(package-install 'find-file-in-repository)
(global-set-key (kbd "C-x f") 'find-file-in-repository)

;; for linum-mode
(setq global-linum-mode 't)

;; for the projectile mode
(package-install 'projectile)
(projectile-global-mode)

;; for git-gutter
(package-install 'git-gutter+)
(global-git-gutter+-mode)
(diminish 'git-gutter+-mode)

;; for ido-mode
(package-install 'ido)
(require 'ido)
(setq ido-enable-flex-matching 't)
(setq ido-everywhere 't)
(ido-mode 't)

;; For Javascript IDE
(package-install 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq js2-highlight-level 3)

;; use web-mode for .jsx files
(package-install 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

;; http://www.flycheck.org/manual/latest/index.html
(package-install 'flycheck)
(require 'flycheck)
(diminish 'flycheck-mode "Fly")

;; turn on flychecking globally
(add-hook 'after-init-hook #'global-flycheck-mode)

;; shader mode
(package-install 'shader-mode)
(add-hook 'auto-mode-alist '("\\.shader$" . shader-mode))

;; For code folding
(add-hook 'js-mode-hook
          (lambda ()
            ;; Scan the file for nested code blocks
            (imenu-add-menubar-index)
            ;; Activate the folding mode
            (hs-minor-mode t)
            (flycheck-mode)))


;; enable the dummy-parenthes mode
(package-install 'dummyparens)
(setq global-dummyparens-mode 't)

;; Show-hide
(global-set-key (kbd "") 'hs-show-block)
(global-set-key (kbd "") 'hs-show-all)
(global-set-key (kbd "") 'hs-hide-block)
(global-set-key (kbd "") 'hs-hide-all)

;; Web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

(setq web-mode-markup-indent-offset 4)
(setq web-mode-css-indent-offset 4)
(setq web-mode-code-indent-offset 4)
(setq web-mode-indent-style 4)

;; magit related
(diminish 'auto-revert-mode)

;; set the interactive haskell program
(setq haskell-program-name "/usr/local/bin/ghci")
;; haskell-mod
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-hi2)
;;(add-hook 'haskell-mode-hook 'hindent-mode)

(setq haskell-indentation-layout-offset 4)
(setq haskell-indentation-starter-offset 4)
(setq haskell-indentation-left-offset 4)
(setq haskell-indentation-ifte-offset 4)
(setq haskell-indentation-where-pre-offset 4)
(setq haskell-indentation-where-post-offset 4)


;; ghc-mod
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat "/usr/local/bin:" my-cabal-path ":" (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;; purescript
(package-install 'psc-ide)
(require 'psc-ide)
(add-hook 'purescript-mode-hook
          (lambda ()
            (psc-ide-mode)
            (company-mode)
            (flycheck-mode)
            (turn-on-purescript-indentation)))
(diminish 'psc-ide-mode)
(diminish 'purescript-indentation-mode)
(setq psc-ide-purs-executable "~/.nvm/versions/node/v10.5.0/bin/purs")

;; omnisharp
(package-install 'omnisharp)
(add-hook 'csharp-mode-hook 'omnisharp-mode)
(eval-after-load
  'company
  '(add-to-list 'company-backends #'company-omnisharp))
(diminish 'omnisharp-mode "Omni")

(defun my-csharp-mode-setup ()
  (setq indent-tabs-mode nil)
  (setq c-syntactic-indentation t)
  (c-set-style "ellemtel")
  (setq c-basic-offset 4)
  (setq truncate-lines t)
  (setq tab-width 4)
  (setq evil-shift-width 4)
  (local-set-key (kbd "C-c C-c") 'recompile))
(add-hook 'csharp-mode-hook 'my-csharp-mode-setup t)

;; add the mono path to emacs' internal PATH variable
;;(setenv "PATH" (concat (getenv "PATH") ":/Library/Frameworks/Mono.framework/Versions/Current/Commands"))
;;(setq exec-path (append exec-path '("/Library/Frameworks/Mono.framework/Versions/Current/Commands")))

;; the newer version like 1.31.1 doesn't work well, so we use old version
;;(setq omnisharp-server-executable-path "~/.emacs.d/.cache/omnisharp/server/v1.30.1/run")
;;(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))


;; window-numbering mode
(package-install 'window-numbering)
(window-numbering-mode 't)

;; side bar project directory tree
(package-install 'neotree)
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(set neo-theme 'classic)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wheatgrass)))
 '(custom-safe-themes
   (quote
    ("e88abed2a39b47dfedb1272066f214cb2c9db28ee6aa1794bfb27948792f81c0" "6dd2b995238b4943431af56c5c9c0c825258c2de87b6c936ee88d6bb1e577cb9" "d5b121d69e48e0f2a84c8e4580f0ba230423391a78fcb4001ccb35d02494d79e" "c8858708e83ca1ed4efdde46d4b81f23ad332134263a520bbe5bbc70f13cbd00" "241627b2368997a03e05939e07dbb26672c6b00fd274906fe2a614d6024e7224" "e9460a84d876da407d9e6accf9ceba453e2f86f8b86076f37c08ad155de8223c" "1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" "e297f54d0dc0575a9271bb0b64dad2c05cff50b510a518f5144925f627bb5832" "bb749a38c5cb7d13b60fa7fc40db7eced3d00aa93654d150b9627cabd2d9b361" "705f3f6154b4e8fac069849507fd8b660ece013b64a0a31846624ca18d6cf5e1" "790e74b900c074ac8f64fa0b610ad05bcfece9be44e8f5340d2d94c1e47538de" "4904daa168519536b08ca4655d798ca0fb50d3545e6244cefcf7d0c7b338af7e" "a1289424bbc0e9f9877aa2c9a03c7dfd2835ea51d8781a0bf9e2415101f70a7e" "94f4d61714a42f9cb6bd212d3bb2e8049a9c3c31b25928a8d3b766975b549855" default)))
 '(display-time-mode t)
 '(fci-rule-color "#232A2F")
 '(fringe-mode 0 nil (fringe))
 '(js-indent-level 4 t)
 '(js2-basic-offset 4)
 '(package-selected-packages
   (quote
    (all-the-icons neotree window-numbering helm-projectile markdown-preview-mode ace-window groovy-mode markdown-mode shader-mode psci diminish flycheck-purescript purescript-mode psc-ide counsel counsel-etags counsel-gtags counsel-osx-app counsel-projectile powerline blackboard-theme grandshell-theme atom-one-dark-theme atom-dark-theme ample-zen-theme ac-emacs-eclim helm csharp-mode omnisharp smooth-scrolling ycmd yaxception yaml-mode xcscope web-mode w3 string-utils smex skewer-mode projectile popup osx-plist osx-clipboard org-wc org-tree-slide org-screenshot org-repo-todo org-pdfview org-magit org-jira org-grep org-elisp-help org-ehtml org-download org-context org-cliplink org-bullets org-beautify-theme org-autolist minimap magit-push-remote log4e js2-refactor intero ido-ubiquitous hindent hi2 handlebars-mode git-gutter git-gutter+ ghci-completion ghc-imported-from fringe-helper flycheck-haskell flycheck-ghcmod flx-ido fiplr find-file-in-repository f exec-path-from-shell dummyparens ctags-update ctags company-ghc company-cabal company-c-headers bash-completion auto-indent-mode aurora-theme)))
 '(tool-bar-mode nil)
 '(vc-annotate-background "#2B3B40")
 '(vc-annotate-color-map
   (quote
    ((20 . "#74CBC4")
     (40 . "#74CBC4")
     (60 . "#C2E982")
     (80 . "#FFC400")
     (100 . "#C792EA")
     (120 . "#C792EA")
     (140 . "#546D7A")
     (160 . "#546D7A")
     (180 . "#FF516D")
     (200 . "#9FC59F")
     (220 . "#859900")
     (240 . "#F77669")
     (260 . "#FF516D")
     (280 . "#82B1FF")
     (300 . "#82B1FF")
     (320 . "#82B1FF")
     (340 . "#D9F5DD")
     (360 . "#FFCB6B"))))
 '(vc-annotate-very-old-color "#FFCB6B"))

(package-install 'smex)
;; smex key binding
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; the old M-x
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(package-install 'company)
;; setup company mode in all buffers
(add-hook 'after-init-hook 'global-company-mode)
(setq company-dabbrev-downcase nil)
(setq company-idle-delay 0)
;; make sure it start autocomplete immediately after user types
(setq company-minimum-prefix-length 1)
(diminish 'company-mode "Comp")

(diminish 'projectile-mode "Proj")

(package-install 'magit)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

