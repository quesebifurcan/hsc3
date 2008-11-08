;; hsc3.el - (c) rohan drape, 2006-2008

;; This mode is implemented as a derivation of `haskell' mode,
;; indentation and font locking is courtesy that mode.  The
;; inter-process communication is courtesy `comint'.  The symbol at
;; point acquisition is courtesy `thingatpt'.  The directory search
;; facilities are courtesy `find-lisp'.

(require 'scheme)
(require 'comint)
(require 'thingatpt)
(require 'find-lisp)

(defvar hsc3-buffer
  "*hsc3*"
  "*The name of the hsc3 process buffer (default=*hsc3*).")

(defvar hsc3-interpreter
  "ghci"
  "*The haskell interpter to use (default=ghci).")

(defvar hsc3-interpreter-arguments
  (list)
  "*Arguments to the haskell interpreter (default=none).")

(defvar hsc3-run-control
  "~/.hsc3.hs"
  "*Run control file (default=~/.hsc3.hs)")

(defvar hsc3-modules
  (list "import Control.Concurrent"
        "import Control.Monad"
        "import Data.List"
        "import Sound.OpenSoundControl"
        "import Sound.SC3"
        "import qualified Sound.SC3.UGen.Base as B"
        "import qualified Sound.SC3.UGen.Monadic as M"
        "import qualified Sound.SC3.UGen.Unsafe as U"
        "import System.Random")
  "*List of modules (possibly qualified) to bring into interpreter context.")

(defvar hsc3-help-directory
  nil
  "*The directory containing the help files (default=nil).")

(defvar hsc3-literate-p
  t
  "*Flag to indicate if we are in literate mode (default=t).")

(make-variable-buffer-local 'hsc3-literate-p)

(defun hsc3-unlit (s)
  "Remove bird literate marks"
  (replace-regexp-in-string "^> " "" s))

(defun hsc3-intersperse (e l)
  (if (null l)
      '()
    (cons e (cons (car l) (hsc3-intersperse e (cdr l))))))

(defun hsc3-write-default-run-control ()
  "Write default run control file if no file exists."
  (if (not (file-exists-p hsc3-run-control))
      (with-temp-file
          hsc3-run-control
        (mapc 
         (lambda (s)
           (insert (concat s "\n")))
         hsc3-modules))))

(defun hsc3-start-haskell ()
  "Start haskell."
  (interactive)
  (if (comint-check-proc hsc3-buffer)
      (error "An hsc3 process is already running")
    (apply
     'make-comint
     "hsc3"
     hsc3-interpreter
     nil
     hsc3-interpreter-arguments)
    (hsc3-see-output))
  (hsc3-write-default-run-control)
  (hsc3-send-string (concat ":l " hsc3-run-control))
  (hsc3-send-string ":set prompt \"hsc3> \""))

(defun hsc3-see-output ()
  "Show haskell output."
  (interactive)
  (when (comint-check-proc hsc3-buffer)
    (delete-other-windows)
    (split-window-vertically)
    (with-current-buffer hsc3-buffer
      (let ((window (display-buffer (current-buffer))))
	(goto-char (point-max))
	(save-selected-window
	  (set-window-point window (point-max)))))))

(defun hsc3-quit-haskell ()
  "Quit haskell."
  (interactive)
  (kill-buffer hsc3-buffer)
  (delete-other-windows))

(defun hsc3-help ()
  "Lookup up the name at point in the Help files."
  (interactive)
  (mapc (lambda (filename)
	  (find-file-other-window filename))
	(find-lisp-find-files hsc3-help-directory
			      (concat "^"
				      (thing-at-point 'symbol)
				      "\\.help\\.lhs"))))

(defun chunk-string (n s)
  "Split a string into chunks of 'n' characters."
  (let* ((l (length s))
         (m (min l n))
         (c (substring s 0 m)))
    (if (<= l n)
        (list c)
      (cons c (chunk-string n (substring s n))))))

(defun hsc3-send-string (s)
  (if (comint-check-proc hsc3-buffer)
      (let ((cs (chunk-string 64 (concat s "\n"))))
        (mapcar (lambda (c) (comint-send-string hsc3-buffer c)) cs))
    (error "no hsc3 process running?")))

(defun hsc3-transform-and-store (f s)
  "Transform example text into compilable form."
  (with-temp-file f
    (mapc (lambda (module)
	    (insert (concat module "\n")))
	  hsc3-modules)
    (insert "main = do\n")
    (insert (if hsc3-literate-p (hsc3-unlit s) s))))

(defun hsc3-run-line ()
  "Send the current line to the interpreter."
  (interactive)
  (let* ((s (buffer-substring (line-beginning-position)
			      (line-end-position)))
	 (s* (if hsc3-literate-p
		 (hsc3-unlit s)
	       s)))
    (hsc3-send-string s*)))

(defun hsc3-run-multiple-lines ()
  "Send the current region to the interpreter as a single line."
  (interactive)
  (let* ((s (buffer-substring-no-properties (region-beginning)
					    (region-end)))
	 (s* (if hsc3-literate-p
		 (hsc3-unlit s)
	       s)))
    (hsc3-send-string (replace-regexp-in-string "\n" " " s*))))

(defun hsc3-run-region ()
  "Place the region in a do block and compile."
  (interactive)
  (hsc3-transform-and-store
   "/tmp/hsc3.hs"
   (buffer-substring-no-properties (region-beginning) (region-end)))
  (hsc3-send-string ":load \"/tmp/hsc3.hs\"")
  (hsc3-send-string "main"))

(defun hsc3-load-buffer ()
  "Load the current buffer."
  (interactive)
  (save-buffer)
  (hsc3-send-string (format ":load \"%s\"" buffer-file-name)))

(defun hsc3-run-main ()
  "Run current main."
  (interactive)
  (hsc3-send-string "main"))

(defun hsc3-interrupt-haskell ()
  (interactive)
  (if (comint-check-proc hsc3-buffer)
      (with-current-buffer hsc3-buffer
	(interrupt-process (get-buffer-process (current-buffer))))
    (error "no hsc3 process running?")))

(defun hsc3-reset-scsynth ()
  "Reset"
  (interactive)
  (hsc3-send-string "withSC3 reset"))

(defun hsc3-status-scsynth ()
  "Status"
  (interactive)
  (hsc3-send-string "withSC3 serverStatus >>= mapM putStrLn"))

(defun hsc3-quit-scsynth ()
  "Quit"
  (interactive)
  (hsc3-send-string "withSC3 (\fd -> send fd quit)"))

(defvar hsc3-mode-map nil
  "Haskell SuperCollider keymap.")

(defun hsc3-mode-keybindings (map)
  "Haskell SuperCollider keybindings."
  (define-key map [?\C-c ?\C-s] 'hsc3-start-haskell)
  (define-key map [?\C-c ?\C-g] 'hsc3-see-output)
  (define-key map [?\C-c ?\C-x] 'hsc3-quit-haskell)
  (define-key map [?\C-c ?\C-k] 'hsc3-reset-scsynth)
  (define-key map [?\C-c ?\C-w] 'hsc3-status-scsynth)
  (define-key map [?\C-c ?\C-c] 'hsc3-run-line)
  (define-key map [?\C-c ?\C-e] 'hsc3-run-multiple-lines)
  (define-key map [?\C-c ?\C-r] 'hsc3-run-region)
  (define-key map [?\C-c ?\C-l] 'hsc3-load-buffer)
  (define-key map [?\C-c ?\C-i] 'hsc3-interrupt-haskell)
  (define-key map [?\C-c ?\C-m] 'hsc3-run-main)
  (define-key map [?\C-c ?\C-o] 'hsc3-quit-scsynth)
  (define-key map [?\C-c ?\C-h] 'hsc3-help))

(defun turn-on-hsc3-keybindings ()
  "Haskell SuperCollider keybindings in the local map."
  (local-set-key [?\C-c ?\C-s] 'hsc3-start-haskell)
  (local-set-key [?\C-c ?\C-g] 'hsc3-see-output)
  (local-set-key [?\C-c ?\C-x] 'hsc3-quit-haskell)
  (local-set-key [?\C-c ?\C-k] 'hsc3-reset-scsynth)
  (local-set-key [?\C-c ?\C-w] 'hsc3-status-scsynth)
  (local-set-key [?\C-c ?\C-c] 'hsc3-run-line)
  (local-set-key [?\C-c ?\C-e] 'hsc3-run-multiple-lines)
  (local-set-key [?\C-c ?\C-r] 'hsc3-run-region)
  (local-set-key [?\C-c ?\C-l] 'hsc3-load-buffer)
  (local-set-key [?\C-c ?\C-i] 'hsc3-interrupt-haskell)
  (local-set-key [?\C-c ?\C-m] 'hsc3-run-main)
  (local-set-key [?\C-c ?\C-o] 'hsc3-quit-scsynth)
  (local-set-key [?\C-c ?\C-h] 'hsc3-help))

(defun hsc3-mode-menu (map)
  "Haskell SuperCollider menu."
  (define-key map [menu-bar hsc3]
    (cons "Haskell-SuperCollider" (make-sparse-keymap "Haskell-SuperCollider")))
  (define-key map [menu-bar hsc3 help]
    (cons "Help" (make-sparse-keymap "Help")))
  (define-key map [menu-bar hsc3 help hsc3]
    '("Haskell SuperCollider help" . hsc3-help))
  (define-key map [menu-bar hsc3 expression]
    (cons "Expression" (make-sparse-keymap "Expression")))
  (define-key map [menu-bar hsc3 expression load-buffer]
    '("Load buffer" . hsc3-load-buffer))
  (define-key map [menu-bar hsc3 expression run-main]
    '("Run main" . hsc3-run-main))
  (define-key map [menu-bar hsc3 expression run-region]
    '("Run region" . hsc3-run-region))
  (define-key map [menu-bar hsc3 expression run-multiple-lines]
    '("Run multiple lines" . hsc3-run-multiple-lines))
  (define-key map [menu-bar hsc3 expression run-line]
    '("Run line" . hsc3-run-line))
  (define-key map [menu-bar hsc3 scsynth]
    (cons "SCSynth" (make-sparse-keymap "SCSynth")))
  (define-key map [menu-bar hsc3 scsynth quit]
    '("Quit scsynth" . hsc3-quit-scsynth))
  (define-key map [menu-bar hsc3 scsynth status]
    '("Display status" . hsc3-status-scsynth))
  (define-key map [menu-bar hsc3 scsynth reset]
    '("Reset scsynth" . hsc3-reset-scsynth))
  (define-key map [menu-bar hsc3 haskell]
    (cons "Haskell" (make-sparse-keymap "Haskell")))
  (define-key map [menu-bar hsc3 haskell quit-haskell]
    '("Quit haskell" . hsc3-quit-haskell))
  (define-key map [menu-bar hsc3 haskell see-output]
    '("See output" . hsc3-see-output))
  (define-key map [menu-bar hsc3 haskell start-haskell]
    '("Start haskell" . hsc3-start-haskell)))

(if hsc3-mode-map
    ()
  (let ((map (make-sparse-keymap "Haskell-SuperCollider")))
    (hsc3-mode-keybindings map)
    (hsc3-mode-menu map)
    (setq hsc3-mode-map map)))

(define-derived-mode
  literate-hsc3-mode
  hsc3-mode
  "Literate Haskell SuperCollider"
  "Major mode for interacting with an inferior haskell process."
  (setq hsc3-literate-p t)
  (setq haskell-literate 'bird)
  (turn-on-font-lock))

(add-to-list 'auto-mode-alist '("\\.lhs$" . literate-hsc3-mode))

(define-derived-mode
  hsc3-mode
  haskell-mode
  "Haskell SuperCollider"
  "Major mode for interacting with an inferior haskell process."
  (setq hsc3-literate-p nil)
  (turn-on-font-lock))

(add-to-list 'auto-mode-alist '("\\.hs$" . hsc3-mode))

(provide 'hsc3)
