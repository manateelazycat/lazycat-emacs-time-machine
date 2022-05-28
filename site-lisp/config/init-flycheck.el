;;; init-flycheck.el --- Configuration for flycheck

;; Filename: init-flycheck.el
;; Description: Configuration for flycheck
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2018, Andy Stewart, all rights reserved.
;; Created: 2018-07-04 21:35:23
;; Version: 0.3
;; Last-Updated: 2018-07-10 07:58:50
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/init-flycheck.el
;; Keywords:
;; Compatibility: GNU Emacs 27.0.50
;;
;; Features that might be required by this library:
;;
;; `flycheck'
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
;; Configuration for flycheck
;;

;;; Installation:
;;
;; Put init-flycheck.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'init-flycheck)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET init-flycheck RET
;;

;;; Change log:
;;
;; 2018/07/10
;;      * Turn off js2 mode warnings
;;
;; 2018/07/05
;;      * Use `posframe' for MacOS, bug has fixed at: https://www.emacswiki.org/emacs/init-startup.el
;;
;; 2018/07/04
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

;; I don't like `global-flycheck-mode', some mode, such as elisp mode don't need.
(dolist (hook (list
               'ruby-mode-hook
               'python-mode-hook
               'swift-mode-hook
               'go-mode-hook
               'js-mode-hook
               ))
  (add-hook
   hook
   #'(lambda ()
       ;; OS Config
       (when (featurep 'cocoa)
         ;; Initialize environment from user's shell to make eshell know every PATH by other shell.
         (require 'exec-path-from-shell)
         (setq exec-path-from-shell-variables '("PATH" "MANPATH" "GEM_PATH"))
         (exec-path-from-shell-initialize))

       (require 'flycheck)

       (setq-default flycheck-disabled-checkers ;disable json-jsonlist checking for json files
                     (append flycheck-disabled-checkers
                             '(json-jsonlist)))

       (setq-default flycheck-disabled-checkers ;disable jshint since we prefer eslint checking
                     (append flycheck-disabled-checkers
                             '(javascript-jshint)))

       (flycheck-add-mode 'javascript-eslint 'web-mode) ;use eslint with web-mode for jsx files

       (setq-default flycheck-temp-prefix ".flycheck")

       (with-eval-after-load 'flycheck
         (require 'flycheck-posframe)
         (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode))
       (flycheck-mode 1))))

;; Add flycheck for swift.
(add-hook 'swift-mode-hook
          #'(lambda ()
              (require 'flycheck-swift)
              (flycheck-swift-setup)
              ))

(provide 'init-flycheck)

;;; init-flycheck.el ends here
