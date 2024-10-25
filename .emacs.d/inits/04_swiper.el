;;; 04_swiper.el --- Swiper configurations. -*- no-byte-compile: t; -*-
;;; Commentary:
;;; Code:
;; (setq debug-on-error t)

(leaf swiper :ensure t
  :doc "Isearch with an overview"
  :bind (("C-s" . swiper-region)
	 ("C-r" . swiper-thing-at-point))
  :config
  (defun swiper-region ()
    "If region is selected, `swiper-thing-at-point'.
If the region isn't selected, `swiper'."
    (interactive)
    (if (not (use-region-p))
	(swiper)
      (swiper-thing-at-point)))
  :init
  (leaf swiper-migemo
    :vc (:url "https://github.com/tam17aki/swiper-migemo")
    :doc "ivy/counsel/swiper with migemo"
    :hook (after-init-hook . global-swiper-migemo-mode)
    :config
    (add-to-list 'swiper-migemo-enable-command 'counsel-rg)
    (setq migemo-options '("--quiet" "--nonewline" "--emacs"))
    (migemo-kill)
    (migemo-init))

  (leaf migemo :ensure t
    :doc "Japanese incremental search through dynamic pattern expansion"
    :if (executable-find "cmigemo")
    :hook (after-init-hook . migemo-init)
    :config
    (setq migemo-command    "cmigemo")
    (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")))


;;; 04_swiper.el ends here
