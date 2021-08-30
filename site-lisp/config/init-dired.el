;;; init-dired.el --- Dired configuration

;; Filename: init-dired.el
;; Description: Dired configuration
;; Author: Andy Stewart lazycat.manatee@gmail.com
;; Maintainer: Andy Stewart lazycat.manatee@gmail.com
;; Copyright (C) 2008, 2009, Andy Stewart, all rights reserved.
;; Created: 2008-10-20 09:38:03
;; Version: 0.2
;; Last-Updated: 2017-10-16 23:14:09
;;           By: Andy Stewart
;; URL:
;; Keywords: dired
;; Compatibility: GNU Emacs 23.0.60.1
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
;; Dired configuration
;;

;;; Installation:
;;
;; Put init-dired.el to your load-path.
;; The load-path is usually ~/elisp/.
;; It's set in your ~/.emacs like this:
;; (add-to-list 'load-path (expand-file-name "~/elisp"))
;;
;; And the following to your ~/.emacs startup file.
;;
;; (require 'init-dired)
;;
;; No need more.

;;; Change log:
;;
;; 2008/10/20
;;      First released.
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
(require 'dired)
(require 'dired-x)
(require 'dired-details)                ;Dired详细信息
(require 'dired-details+)

;;; Code:

(setq dired-recursive-copies t)         ;可以递归的进行拷贝
(setq dired-recursive-deletes t)        ;可以递归的删除目录
(setq dired-recursive-deletes 'always)  ;删除东西时不提示
(setq dired-recursive-copies 'always)   ;拷贝东西时不提示
(setq dired-listing-switches "-aluh")   ;传给 ls 的参数
(setq dired-details-hidden-string "") ;设置隐藏dired里面详细信息的字符串
(setq directory-free-space-args "-Pkh") ;目录空间选项
(setq dired-omit-size-limit nil)        ;dired忽略的上限
(setq dired-dwim-target t)              ;Dired试着猜处默认的目标目录
(setq my-dired-omit-status t)           ;设置默认忽略文件
(setq my-dired-omit-regexp "^\\.?#\\|^\\..*") ;设置忽略文件的匹配正则表达式
(setq my-dired-omit-extensions '(".cache")) ;设置忽略文件的扩展名列表
(add-hook 'dired-after-readin-hook #'(lambda ()
                                       (progn
                                         (require 'dired-extension)
                                         (dired-sort-method)))) ;先显示目录, 然后显示文件
(add-hook
 'dired-mode-hook
 #'(lambda ()
     (require 'dired-extension)
     (dired-omit-method)                ;隐藏文件的方法
     ))
(setq dired-guess-shell-alist-user      ;设置文件默认打开的模式
      '(
        ;; 压缩包
        (list "\\.rar$" "unrar e -ad")
        (list "\\.tar.bz2$" "tar jxvf")
        (list "\\.gz$" "gzip -d")
        ;; 其他
        (list "\\.exe$" "wine")))

;;; ### Dired ###
;;; --- 文件浏览器
(lazy-load-set-keys
 '(
   ("h" . dired-next-subdir)            ;下一个子目录
   ("l" . dired-prev-subdir)            ;上一个子目录
   ("n" . dired-next-dirline)           ;下一个目录
   ("p" . dired-prev-dirline)           ;上一个目录
   ("P" . dired-do-kill-lines)          ;删除标记的行
   ("5" . dired-translate-to-html)      ;转换到HTML格式
   ("9" . auto-install-from-dired)      ;自动从EmacsWiki安装标记的文件
   ("I" . image-dired)                  ;打开浏览模式
   ("W" . dired-x-find-file)            ;查找文件
   ("J" . awesome-tab-backward-tab)
   ("K" . awesome-tab-forward-tab)
   ("X" . traverse-cp-or-mv-extfiles-in-dir) ;拷贝或移动目录下指定扩展名的文件
   ("V" . traverse-dired-browse-archive)     ;浏览压缩文件
   ("," . dired-diff)                        ;比较文件
   ("SPC" . scroll-up)                       ;向下翻页
   ("e" . scroll-down)                       ;向上翻页
   ("c" . kill-this-buffer)                  ;关闭当前标签
   ("/" . copy-buffer-file-name-as-kill)     ;显示路径或名称
   ("s" . one-key-menu-dired-sort)           ;排序
   ("F" . one-key-menu-dired-filter)         ;过滤
   ("w" . wdired-change-to-wdired-mode)      ;切换到dired编辑模式
   )
 dired-mode-map
 )
(lazy-load-local-keys
 '(
   ("w" . wdired-change-to-wdired-mode))
 dired-mode-map
 "wdired")
(lazy-load-local-keys
 '(
   ("C-s" . dired-isearch-forward)             ;向后搜索
   ("C-r" . dired-isearch-backward)            ;向前搜索
   ("ESC C-s" . dired-isearch-forward-regexp)  ;向前正则表达式搜索
   ("ESC C-r" . dired-isearch-backward-regexp) ;向后正则表达式搜索
   )
 dired-mode-map
 "dired-isearch")
(lazy-load-local-keys
 '(
   ("/" . copy-buffer-file-name-as-kill))
 dired-mode-map
 "buffer-extension")
(lazy-load-local-keys
 '(
   (";" . dired-view-minor-mode-toggle) ;字母输入导航模式
   )
 dired-mode-map
 "dired-view")
(lazy-load-local-keys
 '(
   ("T" . dired-tar-pack-unpack)
   )
 dired-mode-map
 "dired-tar")
(lazy-load-local-keys
 '(
   ("M-o" . dired-toggle-omit)          ;切换忽略状态
   ("?" . dired-get-size)               ;得到文件的大小
   ("[" . dired-rename-with-copy)       ;重命名函数
   ("'" . dired-up-directory-single)    ;返回上一级目录
   ("4" . dired-serial-rename)          ;批量重命名
   ("7" . dired-move-to-last-file)      ;移动到最后一个文件
   ("8" . dired-move-to-first-file)     ;移动到第一个文件
   ("k" . dired-previous-file-line)     ;上一行
   ("j" . dired-next-file-line)         ;下一行
   ("{" . dired-gnome-open-file)        ;用GNOME方式打开文件
   ("E" . dired-touch-now)              ;Touch命令
   ("f" . dired-find-file+)             ;打开当前文件或目录
   ("C-m" . dired-find-file+)           ;打开当前文件或目录
   )
 dired-mode-map
 "dired-extension")
(lazy-load-local-keys
 '(
   ("\"" . grep-dired-dwim)             ;查找特定的lisp文件
   )
 dired-mode-map
 "grep-dired")
(lazy-load-local-keys
 '(
   ("]" . dired-show-file-qrcode))
 dired-mode-map
 "eaf.el")
;;; ### Wdired ###
;;; --- Dired 的编辑模式
(eval-after-load 'wdired
  '(lambda ()
     (progn
       (require 'wdired-extension)
       (lazy-load-set-keys
        '(
          ("C-c C-e" . wdired-format-filename) ;格式化文件名
          )
        wdired-mode-map
        ))))

(require 'one-key)
(require 'dired-sort)                 ;排序 dired 文件
(require 'dired-filter)

(one-key-create-menu
 "DIRED-SORT"
      '(
        (("s" . "Size") . dired-sort-size)
        (("x" . "Extension") . dired-sort-extension)
        (("n" . "Name") . dired-sort-name)
        (("t" . "Modified Time") . dired-sort-time)
        (("u" . "Access Time") . dired-sort-utime)
        (("c" . "Create Time") . dired-sort-ctime))
      t)

(one-key-create-menu
 "DIRED-FILTER"
 '(
   (("x" . "Extension") . dired-filter-by-extension)
   (("f" . "File") . dired-filter-by-file)
   (("d" . "Directory") . dired-filter-by-directory)
   (("e" . "Execute") . dired-filter-by-executable)
   (("." . "Dot files") . dired-filter-by-dot-files)
   (("r" . "Regex") . dired-filter-by-regexp)
   (("s" . "Symlink") . dired-filter-by-symlink)
   (("n" . "Name") . dired-filter-by-name)
   )
 t)

(provide 'init-dired)

;;; init-dired.el ends here
