;;; init-mind-wave.el --- Config for mind wave   -*- lexical-binding: t; -*-

;; Filename: init-mind-wave.el
;; Description: Config for mind wave
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2023, Andy Stewart, all rights reserved.
;; Created: 2023-03-21 01:17:11
;; Version: 0.1
;; Last-Updated: 2023-03-21 01:17:11
;;           By: Andy Stewart
;; URL: https://www.github.org/manateelazycat/init-mind-wave
;; Keywords:
;; Compatibility: GNU Emacs 30.0.50
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
;; Config for mind wave
;;

;;; Installation:
;;
;; Put init-mind-wave.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'init-mind-wave)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET init-mind-wave RET
;;

;;; Change log:
;;
;; 2023/03/21
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
(require 'mind-wave)
(require 'eaf-git)

;;; Code:
(setq mind-wave-chat-model "gpt-4")
(setq mind-wave-async-text-model "gpt-4")
(setq mind-wave-action-code-model "gpt-4")
(setq mind-wave-explain-word-model "gpt-4")

(one-key-create-menu
 "MIND-WAVE"
 '(
   (("t" . "Translate to english") . mind-wave-translate-to-english)
   (("T" . "Explain word") . mind-wave-explain-word)
   (("d" . "Proofreading doc") . mind-wave-proofreading-doc)
   (("f" . "Fix typos") . mind-wave-check-typos)
   (("r" . "Refactory code") . mind-wave-refactory-code)
   (("R" . "Refactory code with input") . mind-wave-refactory-code-with-input)
   (("c" . "Comment code") . mind-wave-comment-code)
   (("e" . "Explain code") . mind-wave-explain-code)
   (("E" . "Explain point") . mind-wave-explain-point)
   (("a" . "Adjust text") . mind-wave-adjust-text)
   (("g" . "Generate code") . mind-wave-generate-code)
   (("G" . "Generate patch name") . mind-wave-generate-commit-name)
   (("v" . "Summary video") . mind-wave-summary-video)
   (("w" . "Summary video") . mind-wave-summary-web)
   (("x" . "Restore window configuration") . mind-wave-restore-window-configuration)
   )
 t)

(add-hook 'eaf-git-commit-and-push-hook #'mind-wave-generate-commit-name)


(provide 'init-mind-wave)

;;; init-mind-wave.el ends here
