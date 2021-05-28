;;; init.el -- Initialization file for Emacs
;;
;; 28 May 2021 -- Bob Yantosca -- yantosca@seas.harvard.edu

;; Define if you want 2 vertical frames (t) or not (nil)
(setq two-vertical-frames nil)

;; Load emacs configurations from the emacs-config submodule
(add-to-list 'load-path "~/.emacs.d/emacs-config")
(require 'emacs-config)
