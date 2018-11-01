;;; rg-extension.el --- Extension for rg search

;; Filename: rg-extension.el
;; Description: Extension for rg search
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2018, Andy Stewart, all rights reserved.
;; Created: 2018-08-10 14:07:47
;; Version: 0.1
;; Last-Updated: 2018-08-10 14:07:47
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/rg-extension.el
;; Keywords:
;; Compatibility: GNU Emacs 27.0.50
;;
;; Features that might be required by this library:
;;
;; `rg'
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
;; Extension for rg search
;;

;;; Installation:
;;
;; Put rg-extension.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'rg-extension)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET rg-extension RET
;;

;;; Change log:
;;
;; 2018/08/10
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

;; ;; Make rg.el can find ripgrep path with `executable-find'.
;; (require 'exec-path-from-shell)
;; (exec-path-from-shell-initialize) ; `exec-path-from-shell-initialize' must execute before require package `rg'

(require 'rg)

;;; Code:

(defun rg-grep-pointer ()
  (interactive)
  (let* ((pointer-symbol (rg-pointer-string)))
    (if (string-equal pointer-symbol "")
        (rg-grep-input)
      (rg-grep-in-dir pointer-symbol default-directory)
      )))

(defun rg-grep-input ()
  (interactive)
  (rg-grep-in-dir (rg-read-input "rg grep current diredctory (%s): ") default-directory))

(defun rg-grep-in-rails-app-directory ()
  (interactive)
  (require 'projectile-rails)
  (rg-grep-in-dir (rg-read-input "rg grep rails app directory (%s): ") (concat (projectile-project-root) "app")))

(defun rg-grep-in-dir (query dir)
  (ignore-errors (kill-rg))
  (if (string-equal query "")
      (message "Can't search empty string")
    (rg-run query "all" dir)))

(defun rg-read-input (prompt-string)
  (let* ((current-symbol (rg-pointer-string))
         (input-string (string-trim (read-string (format prompt-string current-symbol)))))
    (when (string-blank-p input-string)
      (setq input-string current-symbol))
    input-string))

(defun rg-pointer-string ()
  (let* ((pointer-string
          (if (use-region-p)
              (buffer-substring-no-properties (region-beginning) (region-end))
            (string-remove-prefix "." (thing-at-point 'symbol)))))
    (if pointer-string
        pointer-string
      "")))

(provide 'rg-extension)

;;; rg-extension.el ends here
