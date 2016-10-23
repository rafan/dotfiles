(setq load-path (cons "~/.site-lisp" load-path))

; font-lock-mode
(if (fboundp 'global-font-lock-mode)
    (global-font-lock-mode 1)        ; GNU Emacs
  (setq font-lock-auto-fontify t))   ; XEmacs
  (setq font-lock-maximum-decoration t)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(load-home-init-file t t)
 '(safe-local-variable-values (quote ((TeX-master \` (\` thesis\.tex)))))
 '(visible-bell t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )

;; make marked region highlighted
(setq transient-mark-mode t)

;; shell mode
;;(setq ansi-color-names-vector ; better contrast colors
;;  ["black" "red4" "green4" "yellow4"
;;   "blue3" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; tex
;; (require 'tex-site)
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)
(setq TeX-auto-global nil) ; no global parsed info.
(setq TeX-parse-self t) ; enable parse on load
(setq TeX-auto-save t) ; enable parse on save
;;(setq TeX-auto-untabify nil) ; don't convert my TAB
(add-hook 'latex-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)   ; with AUCTeX LaTeX mode
(setq reftex-plug-into-auctex t)

;; python
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;; svn
;;(require 'psvn)

;; tabbed view
(when (require 'tabbar nil t)

      (setq tabbar-buffer-groups-function 
	    (lambda (b) (list "All Buffers")))
      (setq tabbar-buffer-list-function
	    (lambda ()
		  (remove-if
		   (lambda(buffer)
		     (find (aref (buffer-name buffer) 0) " *")) (buffer-list))))
    
      (tabbar-mode))

;; make it looks like 2D
(set-face-attribute
 'tabbar-default-face nil
 :background "gray60")
(set-face-attribute
 'tabbar-unselected-face nil
 :background "gray85"
 :foreground "gray30"
 :box nil)
(set-face-attribute
 'tabbar-selected-face nil
 :background "#f2f2f6"
 :foreground "black"
 :box nil)
(set-face-attribute
 'tabbar-button-face nil
 :box '(:line-width 1 :color "gray72" :style released-button))
(set-face-attribute
 'tabbar-separator-face nil
 :height 0.7)

;; move around the tabs
(global-set-key [(control p)] 'tabbar-backward)
(global-set-key [(control n)] 'tabbar-forward)

;; spell
(defun my-flyspell-mode-enable ()
  (flyspell-mode 1))
(mapc
 (lambda (hook)
   (add-hook hook 'my-flyspell-mode-enable))
 '(
   changelog-mode-hook
   ruby-mode-hook
   text-mode-hook
   latex-mode-hook
   ))
