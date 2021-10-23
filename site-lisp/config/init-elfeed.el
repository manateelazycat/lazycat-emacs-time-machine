;;; init-elfeed.el --- Config for elfeed

;; Filename: init-elfeed.el
;; Description: Config for elfeed
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2020, Andy Stewart, all rights reserved.
;; Created: 2020-12-28 10:38:58
;; Version: 0.1
;; Last-Updated: 2020-12-28 10:38:58
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/init-elfeed.el
;; Keywords:
;; Compatibility: GNU Emacs 28.0.50
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
;; Config for elfeed
;;

;;; Installation:
;;
;; Put init-elfeed.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'init-elfeed)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET init-elfeed RET
;;

;;; Change log:
;;
;; 2020/12/28
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
(require 'elfeed)
(require 'eaf)

;;; Code:

;; Temp function before https://github.com/skeeto/elfeed/pull/404 patch apply.
(defun elfeed-search-print-entry--default (entry)
  "Print ENTRY to the buffer."
  (let* ((date (elfeed-search-format-date (elfeed-entry-date entry)))
         (title (or (elfeed-meta entry :title) (elfeed-entry-title entry) ""))
         (title-faces (elfeed-search--faces (elfeed-entry-tags entry)))
         (feed (elfeed-entry-feed entry))
         (feed-title
          (when feed
            (or (elfeed-meta feed :title) (elfeed-feed-title feed))))
         (tags (mapcar #'symbol-name (elfeed-entry-tags entry)))
         (tags-str (mapconcat
                    (lambda (s) (propertize s 'face 'elfeed-search-tag-face))
                    tags ","))
         (title-width (- (window-width) 10 elfeed-search-trailing-width))
         (title-format-width (elfeed-clamp
                              elfeed-search-title-min-width
                              title-width
                              elfeed-search-title-max-width))
         (title-column (elfeed-format-column title title-format-width :left))
         (align-width (if (> (window-width) (/ (* 2 (frame-width)) 3))
                          title-width
                        (+ (string-width date) 5 title-format-width)))
         )
    (insert (propertize date 'face 'elfeed-search-date-face) " ")
    (insert (propertize title-column 'face title-faces 'kbd-help title) " ")

    ;; Use property `align-to' indent title pixel width, otherwise CJK title not alignment like expect.
    (put-text-property (point) (- (point) 1) 'display (elfeed-indent-pixel (* align-width (window-font-width))))

    (when feed-title
      (insert (propertize feed-title 'face 'elfeed-search-feed-face) " "))
    (when tags
      (insert "(" tags-str ")"))
    ))

(defsubst elfeed-indent-pixel (xpos)
  "Return a display property that aligns to XPOS."
  `(space :align-to (,xpos)))

(setq elfeed-feeds
      '(("https://sachachua.com/blog/feed/" SachaChua)
        ("http://www.solidot.org/index.rss" Solidot)
        ))

(defvar elfeed-search-window-configuration nil)

(defun elfeed-search-show ()
  (interactive)
  (setq elfeed-search-window-configuration (current-window-configuration))
  (elfeed))

(defun elfeed-search-quit ()
  (interactive)
  (delete-other-windows)
  (elfeed-search-quit-window)
  (when elfeed-search-window-configuration
    (set-window-configuration elfeed-search-window-configuration)))

(defvar elfeed-update-interval (* 15 60)
  "Interval time between two updates.
Default value is 15min.")

(defvar elfeed-update-timer nil
  "Timer defined by elfeed-update-background-start.")

(defun elfeed-update-background-start ()
  "Start an automatic update.
elfeed-update-timer is defined in this function."
  (interactive)
  (if elfeed-update-timer
      (warn "elfeed background update is already started")
    (setq elfeed-update-timer (run-with-timer 0 elfeed-update-interval 'elfeed-update))))

(defun elfeed-mark-all-items-as-read ()
  (interactive)
  (save-excursion
    (beginning-of-buffer)
    (while (not (equal (point) (point-max)))
      (let ((entry (elfeed-search-selected :ignore-region)))
        (elfeed-untag entry 'unread)
        (elfeed-search-update-entry entry)
        (forward-line)))))

(defun elfeed-update-background-stop ()
  "Stop the automatic update."
  (interactive)
  (if elfeed-update-timer
      (progn
        (cancel-timer elfeed-update-timer)
        (setq elfeed-update-timer nil))
    (warn "elfeed background update is alread stopped")))

(elfeed-update-background-start)

(lazy-load-local-keys
 '(
   ("RET" . eaf-elfeed-open-url)
   ("C-m" . eaf-elfeed-open-url)
   ("m" . eaf-elfeed-open-url)
   ("q" . elfeed-search-quit)
   ("j" . next-line)
   ("k" . previous-line)
   ("U" . elfeed-mark-all-items-as-read)
   )
 elfeed-search-mode-map
 "init-elfeed")

(provide 'init-elfeed)

;;; init-elfeed.el ends here
