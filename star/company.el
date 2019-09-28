;;; -*- lexical-binding: t -*-

(defvar luna-company-manual nil
  "If t, invoke company manually.")

(load-package company
  :commands (company-mode)
  :config
  (when luna-company-manual
    (setq company-idle-delay nil
          company-auto-complete t))
  (setq company-minimum-prefix-length 1
        company-dabbrev-downcase nil
        company-tooltip-limit 15)
  (setq-default company-search-filtering t))

(luna-with-eval-after-load 'key.general
  (when luna-company-manual
    ;; we secretly swap tab and C-o so
    ;; default bindings of tab (folding, indent, etc) goes to C-o
    ;; (define-key input-decode-map (kbd "<tab>") (kbd "C-o"))
    ;; (define-key input-decode-map (kbd "C-o") (kbd "<tab>"))
    (global-set-key (kbd "<C-i>") #'company-complete)
    (global-set-key (kbd "M-i") #'company-complete))
  (general-define-key
   :keymaps '(company-active-map
              company-search-map)
   "C-p" #'company-select-previous
   "C-n" #'company-select-next
   "C-j" #'company-search-candidates)
  (general-define-key
   :keymaps 'company-search-map
   "<escape>" #'company-abort))

(load-package company-box
  ;; don't enable by default
  :config
  (setq company-box-enable-icon nil)
  (setq company-box-doc-delay 0.3)
  :commands company-box-mode)
