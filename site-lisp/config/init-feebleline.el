;;; init-feebleline.el --- Configuration for feebleline

;; Filename: init-feebleline.el
;; Description: Configuration for feebleline
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2018, Andy Stewart, all rights reserved.
;; Created: 2018-10-06 20:11:36
;; Version: 0.1
;; Last-Updated: 2018-10-06 20:11:36
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/init-feebleline.el
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
;; Configuration for feebleline
;;

;;; Installation:
;;
;; Put init-feebleline.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'init-feebleline)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET init-feebleline RET
;;

;;; Change log:
;;
;; 2018/10/06
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
(require 'feebleline)

;;; Code:
(feebleline-mode 1)
(setq feebleline-show-time t)
(setq feebleline-show-git-branch t)
(setq feebleline-show-directory nil)

(provide 'init-feebleline)

;;; init-feebleline.el ends here
