;;; init-ecb.el --- Init ecb

;; Filename: init-ecb.el
;; Description: Init ecb
;; Author: Andy Stewart <andy@freedom>
;; Maintainer: Andy Stewart <andy@freedom>
;; Copyright (C) 2013, Andy Stewart, all rights reserved.
;; Created: 2013-12-30 15:00:16
;; Version: 0.1
;; Last-Updated: 2013-12-30 15:00:16
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/init-ecb.el
;; Keywords:
;; Compatibility: GNU Emacs 24.3.50.1
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
;; Init ecb
;;

;;; Installation:
;;
;; Put init-ecb.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'init-ecb)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET init-ecb RET
;;

;;; Change log:
;;
;; 2013/12/30
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ECB ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(one-key-create-menu
 "ECB"
      '(
        (("s" . "Sources") . ecb-goto-window-sources)
        (("h" . "History") . ecb-goto-window-history)
        (("d" . "Directory") . ecb-goto-window-directories)
        (("m" . "Methods") . ecb-goto-window-methods)
        (("e" . "Edit") . ecb-goto-window-edit1))
      t)

(provide 'init-ecb)

;;; init-ecb.el ends here
