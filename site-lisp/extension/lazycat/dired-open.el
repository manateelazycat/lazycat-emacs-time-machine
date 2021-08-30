;;; dired-open.el --- Open varoius files in dired.

;; Filename: dired-open.el
;; Description: Open varoius files in dired.
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2009, Andy Stewart, all rights reserved.
;; Created: 2009-02-09 12:51:40
;; Version: 0.1
;; Last-Updated: 2009-02-09 12:51:40
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/dired-open.el
;; Keywords: dired, open
;; Compatibility: GNU Emacs 23.0.60.1
;;
;; Features that might be required by this library:
;;
;; `chm-view' `w3m' `doc-view'
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
;; Open varoius files in dired.
;;

;;; Installation:
;;
;; Put dired-open.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'dired-open)
;;
;; No need more.

;;; Change log:
;;
;; 2009/02/09
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
(require 'chm-view)
(require 'doc-view)

;;; Code:

(defun dired-open-file-root ()
  "Dired file as root."
  (interactive)
  (tramp-cleanup-all-connections)
  (find-file (concat find-file-root-prefix (dired-get-filename))))

(defun dired-open-file ()
  "Dired find file function.
Open file use another tool"
  (interactive)
  (dolist (file (dired-get-marked-files))
    (find-file file)
    ))

(provide 'dired-open)

;;; dired-open.el ends here
