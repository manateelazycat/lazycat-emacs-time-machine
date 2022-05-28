;;; init-company-mode.el --- Company-mode configuration

;; Filename: init-company-mode.el
;; Description: Company-mode configuration
;; Author: Andy Stewart lazycat.manatee@gmail.com
;; Maintainer: Andy Stewart lazycat.manatee@gmail.com
;; Copyright (C) 2008, 2009, Andy Stewart, all rights reserved.
;; Created: 2008-10-20 09:56:57
;; Version: 1.1
;; Last-Updated: 2018-09-11 01:00:24
;;           By: Andy Stewart
;; URL:
;; Keywords: company-mode
;; Compatibility: GNU Emacs 23.0.60.1
;;
;; Features that might be required by this library:
;;
;;
;;

;;; This file is NOT part of GNU Emacs

;;; License
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; Company-mode configuration
;;

;;; Installation:
;;
;; Put init-company-mode.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'init-company-mode)
;;

;;; Change log:
;;
;; 2018/09/11
;;      * Split lsp configuration to `init-lsp.el'.
;;
;; 2018/07/24
;;      * Add command to install python completion backend.
;;
;; 2018/07/23
;;      * Add `company-elisp' backend when load emacs-lisp mode.
;;
;; 2018/07/16
;;      * Don't downcase completion result from dabbrev.
;;
;; 2018/07/12
;;      * Customize dabbrev backend, to make company can completion any words in all buffer like `dabbrev-expand'.
;;      * Default add `company-files' backend.
;;
;; 2018/07/07
;;      * Add `company-css' into `company-backends'.
;;
;; 2018/07/06
;;      * Fix ruby mode load error.
;;      * Fix python mode load error.
;;      * Use `exec-path-from-shell' avoid LSP can't found server bin path.
;;
;; 2018/07/05
;;      * Config company and company-lsp fronted.
;;      * Make company works with posframe.
;;      * Add LSP mode support.
;;      * Add support for python and rubyl
;;
;; 2008/10/20
;;      * First released.
;;

;;; Acknowledgements:
;;
;;
;;

;;; TODO
;;
;;
;;

;;; Require

;;; Code:
(add-hook 'prog-mode-hook
          #'(lambda ()
              (require 'company)
              (require 'company-yasnippet)
              (require 'company-dabbrev)
              (require 'company-files)
              (require 'company-tng)
              (require 'company-tabnine)

              (require 'lazy-load)
              (require 'lsp-bridge)

              ;; lsp-mode for test.
              ;; (require 'lsp-mode)
              ;; (require 'lsp-lens)
              ;; (require 'lsp-modeline)
              ;; (require 'lsp-headerline)
              ;; (require 'lsp-pyright)

              ;; (setq lsp-log-io t)
              ;; (setq lsp-headerline-breadcrumb-enable nil)
              ;; (setq lsp-enable-symbol-highlighting nil)
              ;; (setq lsp-ui-doc-enable nil)
              ;; (setq lsp-ui-doc-show-with-cursor nil)
              ;; (setq lsp-ui-doc-show-with-mouse nil)
              ;; (setq lsp-lens-enable nil)
              ;; (setq lsp-ui-sideline-enable nil)
              ;; (setq lsp-ui-sideline-show-code-actions nil)
              ;; (setq lsp-ui-sideline-enable nil)
              ;; (setq lsp-ui-sideline-show-hover nil)
              ;; (setq lsp-diagnostics-provider :none)
              ;; (setq lsp-ui-sideline-enable nil)
              ;; (setq lsp-eldoc-enable-hover nil)
              ;; (setq lsp-modeline-diagnostics-enable nil)
              ;; (setq lsp-signature-auto-activate nil)
              ;; (setq lsp-signature-render-documentation nil)

              ;; (add-hook 'python-mode-hook #'lsp-deferred)

              ;; Config for company mode.
              (setq company-minimum-prefix-length 0)
              (setq company-show-numbers t)
              (setq company-require-match nil)
              (setq company-idle-delay 0.2)

              ;; Don't downcase the returned candidates.
              (setq company-dabbrev-downcase nil)
              (setq company-dabbrev-ignore-case t)

              ;; Customize company backends.
              (setq company-backends
                    '((
                       company-lsp-bridge
                       ;; company-tabnine
                       ;; company-dabbrev
                       ;; company-keywords
                       company-files
                       company-capf
                       )))

              ;; Add yasnippet support for all company backends.
              ;; (defvar company-mode/enable-yas t
              ;;   "Enable yasnippet for all backends.")

              ;; (defun company-mode/backend-with-yas (backend)
              ;;   (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
              ;;       backend
              ;;     (append (if (consp backend) backend (list backend))
              ;;             '(:with company-yasnippet))))

              ;; (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

              ;; Remove duplicate candidate.
              (add-to-list 'company-transformers #'delete-dups)

              ;; Add `company-elisp' backend for elisp.
              (add-hook 'emacs-lisp-mode-hook
                        #'(lambda ()
                            (require 'company-elisp)
                            (if (and (listp company-backends) (member 'company-elisp company-backends))
                                company-backends
                              (push 'company-elisp company-backends))))

              ;; Enable global.
              (global-company-mode)
              ))

;; The free version of TabNine is good enough,
;; and below code is recommended that TabNine not always
;; prompt me to purchase a paid version in a large project.
(defadvice company-echo-show (around disable-tabnine-upgrade-message activate)
  (let ((company-message-func (ad-get-arg 0)))
    (when (and company-message-func
               (stringp (funcall company-message-func)))
      (unless (string-match "The free version of TabNine only indexes up to" (funcall company-message-func))
        ad-do-it))))

(provide 'init-company-mode)

;;; init-company-mode.el ends here
