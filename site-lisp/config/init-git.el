;;; init-git.el --- Init for git

;; Filename: init-git.el
;; Description: Init for git
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2014, Andy Stewart, all rights reserved.
;; Created: 2014-01-03 23:04:31
;; Version: 0.1
;; Last-Updated: 2014-01-03 23:04:31
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/init-git.el
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
;; Init for git
;;

;;; Installation:
;;
;; Put init-git.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'init-git)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET init-git RET
;;

;;; Change log:
;;
;; 2014/01/03
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
(require 'magit)

;;; Code:
(when (featurep 'cocoa)
  ;; Initialize environment from user's shell to make eshell know every PATH by other shell.
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))
(load-library "with-editor")

;; Magit configuration.
(setq magit-commit-ask-to-stage nil)    ;don't ask stage question
(setq magit-display-buffer-noselect t) ;don't select magit buffer default

;; Make path column have enough space to display.
(setq magit-submodule-list-columns
      '(("Path"     80 magit-modulelist-column-path   nil)
        ("Version"  30 magit-repolist-column-version  nil)
        ("Branch"   20 magit-repolist-column-branch   nil)
        ("B<U" 3 magit-repolist-column-unpulled-from-upstream   ((:right-align t)))
        ("B>U" 3 magit-repolist-column-unpushed-to-upstream     ((:right-align t)))
        ("B<P" 3 magit-repolist-column-unpulled-from-pushremote ((:right-align t)))
        ("B>P" 3 magit-repolist-column-unpushed-to-pushremote   ((:right-align t)))
        ("B"   3 magit-repolist-column-branches                 ((:right-align t)))
        ("S"   3 magit-repolist-column-stashes                  ((:right-align t)))))

(one-key-create-menu
 "MAGIT"
 '(
   (("s" . "Magit status") . magit-status+)
   (("c" . "Magit checkout") . magit-checkout)
   (("C" . "Magit commit") . magit-commit)
   (("u" . "Magit push to remote") . magit-push-current-to-pushremote)
   (("p" . "Magit delete remote branch") . magit-delete-remote-branch)
   (("i" . "Magit pull") . magit-pull-from-upstream)
   (("r" . "Magit rebase") . magit-rebase)
   (("e" . "Magit merge") . magit-merge)
   (("l" . "Magit log") . magit-log-all)
   (("L" . "Magit blame") . magit-blame+)
   (("b" . "Magit branch") . magit-branch)
   (("m" . "Magit submodule add") . magit-submodule-add+)
   (("d" . "Magit submodule remove") . magit-submodule-remove+)
   (("M" . "Magit submodule list") . magit-list-submodules)
   (("D" . "Magit discarded") . magit-discard)
   (("," . "Magit init") . magit-init)
   (("." . "Magit add remote") . magit-remote-add)
   )
 t)

(defun magit-submodule-add+ (url)
  (interactive "sURL: ")
  (let ((parent-dir (cadr (split-string (file-name-as-directory lazycat-emacs-extension-dir) (expand-file-name (cdr (project-current)))))))
    (magit-submodule-add
     url
     (concat parent-dir (file-name-base url))
     (file-name-base url))))

(defun magit-submodule-remove+ ()
  (interactive)
  (magit-submodule-remove (list (magit-read-module-path "Remove module")) "--force" nil))

(defun magit-status+ ()
  (interactive)
  (magit-status)
  (other-window 1))

(defun magit-blame+ ()
  (interactive)
  (setq magit-blame--style
        '(margin
          (margin-format " %s%f" " %C %a" " %H")
          (margin-width . 42)
          (margin-face . magit-blame-margin)
          (margin-body-face magit-blame-dimmed)))
  (magit-blame))

(defun magit-delete-remote-branch ()
  (interactive)
  (when (y-or-n-p (format "Delete remote branch (%s): " (magit-get-current-branch)))
    (magit-run-git-async "push" "origin" (format ":%s" (magit-get-current-branch)))))

(provide 'init-git)

;;; init-git.el ends here
