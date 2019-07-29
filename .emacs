;; $HOME/.emacs
;; Personal settings for Emacs.

;; Activate UTF-8 mode:
  (setq locale-coding-system 'utf-8)
  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (set-selection-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)

; Personal X resources for Emacs can be set in ~/.Xdefaults.
; Look also at the global configuration in /etc/emacs/.

; Emacs has a customization menu, changes done there are written 
; into this file.
; For example, to turn off the autostart of Flyspell, customize
; Data->"Text Mode Hook" item.

(set-language-environment "Chinese")

