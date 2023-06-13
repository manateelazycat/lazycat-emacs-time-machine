;;; init-tree-sitter.el --- Configure for tree sitter

;; Filename: init-tree-sitter.el
;; Description: Configure for tree sitter
;; Author: Andy Stewart <lazycat.manatee@gmail.com>
;; Maintainer: Andy Stewart <lazycat.manatee@gmail.com>
;; Copyright (C) 2021, Andy Stewart, all rights reserved.
;; Created: 2021-05-29 00:19:03
;; Version: 0.1
;; Last-Updated: 2021-05-29 00:19:03
;;           By: Andy Stewart
;; URL: http://www.emacswiki.org/emacs/download/init-tree-sitter.el
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
;; Configure for tree sitter
;;

;;; Installation:
;;
;; Put init-tree-sitter.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'init-tree-sitter)
;;
;; No need more.

;;; Customize:
;;
;;
;;
;; All of the above can customize by:
;;      M-x customize-group RET init-tree-sitter RET
;;

;;; Change log:
;;
;; 2021/05/29
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
(require 'tree-sitter)
(require 'tree-sitter-hl)
(require 'tree-sitter-langs)
(require 'tree-sitter-debug)
(require 'tree-sitter-query)

;;; Code:
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)

;; Add Emacs-Lisp for tree-sitter:
;;
;; 1. git clone https://github.com/Wilfred/tree-sitter-elisp
;; 2. gcc ./src/parser.c -fPIC -I./ --shared -o elisp.so
;; 3. cp ./elisp.so ~/.tree-sitter-langs/bin (~/.tree-sitter-langs/bin is path of your tree-sitter-langs repo)
(tree-sitter-load 'elisp)
(add-to-list 'tree-sitter-major-mode-language-alist '(emacs-lisp-mode . elisp))
(add-to-list 'tree-sitter-major-mode-language-alist '(inferior-emacs-lisp-mode . elisp))

;; Add Vue for tree-sitter:
;;
;; 1. git clone https://github.com/ikatyang/tree-sitter-vue.git
;; 2. gcc ./src/parser.c ./src/scanner.cc -fPIC -I./ --shared -o vue.so
;; 3. cp ./vue.so ~/.tree-sitter-langs/bin (~/.tree-sitter-langs/bin is path of your tree-sitter-langs repo)
(tree-sitter-load 'vue)
(add-to-list 'tree-sitter-major-mode-language-alist '(web-mode . vue))

;; Add Typescript for tree-sitter.
;;
;; 1. git clone https://github.com/tree-sitter/tree-sitter-typescript.git
;; 2. gcc ./tsx/src/parser.c ./tsx/src/scanner.cc -fPIC -I./ --shared -o typescript.so
;; 3. cp ./typescript.so ~/.tree-sitter-langs/bin (~/.tree-sitter-langs/bin is path of your tree-sitter-langs repo)
(tree-sitter-load 'typescript)
(add-to-list 'tree-sitter-major-mode-language-alist '(typescript-mode . typescript))

(provide 'init-tree-sitter)

;;; init-tree-sitter.el ends here
