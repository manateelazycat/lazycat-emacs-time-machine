;;; init-highlight-indent-guides.el --- Configuration for highlight-indent-guides

;; Filename: init-highlight-indent-guides.el
;; Description: Configuration for highlight-indent-guides
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2019, Andy Stewart, all rights reserved.
;; Created: 2019-06-30 19:19:37
;; Version: 0.1
;; Last-Updated: 2019-06-30 19:19:37
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/init-highlight-indent-guides.el
;; Keywords:
;; Compatibility: GNU Emacs 26.2
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
;; Configuration for highlight-indent-guides
;;

;;; Installation:
;;
;; Put init-highlight-indent-guides.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'init-highlight-indent-guides)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET init-highlight-indent-guides RET
;;

;;; Change log:
;;
;; 2019/06/30
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
             (require 'highlight-indent-guides)
             (setq highlight-indent-guides-method 'character)
             (setq highlight-indent-guides-auto-enabled t)
             (setq highlight-indent-guides-responsive 'top)
             (highlight-indent-guides-mode)))

(provide 'init-highlight-indent-guides)

;;; init-highlight-indent-guides.el ends here
