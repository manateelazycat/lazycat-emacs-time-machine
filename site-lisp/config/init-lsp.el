;;; init-lsp.el --- Configuration for lsp-mode

;; Filename: init-lsp.el
;; Description: Configuration for lsp-mode
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2018, Andy Stewart, all rights reserved.
;; Created: 2018-09-10 22:46:41
;; Version: 0.2
;; Last-Updated: 2018-09-14 09:48:52
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/init-lsp.el
;; Keywords:
;; Compatibility: GNU Emacs 27.0.50
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
;; Configuration for lsp-mode
;;

;;; Installation:
;;
;; Put init-lsp.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'init-lsp)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET init-lsp RET
;;

;;; Change log:
;;
;; 2018-09-14
;;      * Switch from eglot to lsp-mode since lsp-ruby looks fix disconnect problem.
;;
;; 2018/09/10
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

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

(with-eval-after-load 'lsp-mode
  ;; enable log only for debug
  (setq lsp-log-io nil)

  ;; Disable folding.
  (setq lsp-enable-folding nil)

  ;; No real time syntax check
  (setq lsp-diagnostic-package :none)

  ;; handle yasnippet by myself
  (setq lsp-enable-snippet nil)

  ;; Disable completion at point.
  (setq lsp-enable-completion-at-point nil)

  ;; Turn off for better performance
  (setq lsp-enable-symbol-highlighting nil)

  ;; Turn off hover doc.
  (setq lsp-ui-doc-enable nil)

  ;; Turn off lens.
  (setq lsp-lens-enable nil)

  ;; Disable headerline.
  (setq lsp-headerline-breadcrumb-enable nil)

  ;; Disable sideline.
  (setq lsp-ui-sideline-enable nil)

  ;; Disable modeline.
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-modeline-diagnostics-enable nil)

  ;; Disable help.
  (setq lsp-signature-auto-activate nil)
  (setq lsp-signature-render-documentation nil)

  ;; Disable flycheck.
  (setq lsp-diagnostics-provider :none)

  ;; Disable eldoc.
  (setq lsp-eldoc-enable-hover nil)

  ;; Disable link.
  (setq lsp-enable-links nil)

  ;; Auto restart LSP.
  (setq lsp-restart 'auto-restart)

  ;; Don't scan 3rd party javascript libraries.
  (push "[/\\\\][^/\\\\]*\\.\\(json\\|html\\|jade\\)$" lsp-file-watch-ignored)

  ;; Don't ping LSP lanaguage server too frequently.
  (defvar lsp-on-touch-time 0)
  (defadvice lsp-on-change (around lsp-on-change-hack activate)
    ;; don't run `lsp-on-change' too frequently
    (when (> (- (float-time (current-time))
                lsp-on-touch-time) 30) ;; 30 seconds
      (setq lsp-on-touch-time (float-time (current-time)))
      ad-do-it)))

(dolist (hook (list
               'js-mode-hook
               'ruby-mode-hook
               'go-mode-hook
               ))
  (add-hook hook #'(lambda ()
                     (require 'lsp-mode)
                     (require 'lsp-modeline)
                     (require 'lsp-headerline)
                     (lsp)
                     )))

(dolist (hook (list
               'python-mode-hook
               ))
  (add-hook hook #'(lambda ()
                     (require 'lsp-mode)
                     (require 'lsp-modeline)
                     (require 'lsp-headerline)

                     (require 'lsp-python-ms)
                     (setq lsp-python-ms-executable "~/mspyls/Microsoft.Python.LanguageServer")

                     (lsp)
                     )))

(provide 'init-lsp)

;;; init-lsp.el ends here
