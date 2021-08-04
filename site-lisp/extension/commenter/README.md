# commenter.el

This package allows you to set both single and multi line comment
variables like `comment-start` or `comment-end` etc.

## example

Configuration example for go-mode:

```lisp
(setq comment-style 'extra-line)
   (add-hook 'go-mode-hook
     (lambda ()
       (setq-local commenter-config
           '((single
              . ((comment-start      . "//")
                 (comment-end        . "")
                 (comment-start-skip . "\\(//+\\|/\\*+\\)\\s *")))
             (multi
              . ((comment-start      . "/* ")
                 (comment-end        . " */")
                 (comment-start-skip . "/\\*")
                 (comment-end-skip   . "\\*/")
                 (comment-continue   . " * ")
                 (comment-padding    . " ")
                 (comment-multi-line . t)))))
       (commenter-setup)))
```

After this configuration your `comment-dwim` will be multi line
comment.
