(setq load-path (cons (expand-file-name "~/.emacs.d/vhdl-mode-3.33.28") load-path))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cua-mode t nil (cua-base))
 '(indent-tabs-mode nil)
 '(standard-indent 2)
 '(vhdl-clock-name "clk_i")
 '(vhdl-compiler-alist (quote (("ADVance MS" "vacom" "-work \\1" "make" "-f \\1" nil "valib \\1; vamap \\2 \\1" "./" "work/" "Makefile" "adms" ("\\s-\\([0-9]+\\):" 0 1 0) ("Compiling file \\(.+\\)" 1) ("ENTI/\\1.vif" "ARCH/\\1-\\2.vif" "CONF/\\1.vif" "PACK/\\1.vif" "BODY/\\1.vif" upcase)) ("Aldec" "vcom" "-93 -work \\1" "make" "-f \\1" nil "vlib \\1; vmap \\2 \\1" "./" "work/" "Makefile" "aldec" (".+?[ 	]+\\(?:ERROR\\)[^:]+:.+?\\(?:.+\"\\(.+?\\)\"[ 	]+\\([0-9]+\\)\\)" 1 2 0) ("" 0) nil) ("Cadence Leapfrog" "cv" "-work \\1 -file" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "leapfrog" ("duluth: \\*E,[0-9]+ (\\(.+\\),\\([0-9]+\\)):" 1 2 0) ("" 0) ("\\1/entity" "\\2/\\1" "\\1/configuration" "\\1/package" "\\1/body" downcase)) ("Cadence NC" "ncvhdl" "-work \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "ncvhdl" ("ncvhdl_p: \\*E,\\w+ (\\(.+\\),\\([0-9]+\\)|\\([0-9]+\\)):" 1 2 3) ("" 0) ("\\1/entity/pc.db" "\\2/\\1/pc.db" "\\1/configuration/pc.db" "\\1/package/pc.db" "\\1/body/pc.db" downcase)) ("GHDL" "ghdl" "-i --workdir=\\1 --ieee=synopsys -fexplicit " "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "ghdl" ("ghdl_p: \\*E,\\w+ (\\(.+\\),\\([0-9]+\\)|\\([0-9]+\\)):" 1 2 3) ("" 0) ("\\1/entity" "\\2/\\1" "\\1/configuration" "\\1/package" "\\1/body" downcase)) ("Ikos" "analyze" "-l \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "ikos" ("E L\\([0-9]+\\)/C\\([0-9]+\\):" 0 1 2) ("^analyze +\\(.+ +\\)*\\(.+\\)$" 2) nil) ("ModelSim" "vcom" "-93 -work \\1" "make" "-f \\1" nil "vlib \\1; vmap \\2 \\1" "./" "work/" "Makefile" "modelsim" ("\\(ERROR\\|WARNING\\|\\*\\* Error\\|\\*\\* Warning\\)[^:]*:\\( *[[0-9]+]\\)? \\(.+\\)(\\([0-9]+\\)):" 3 4 0) ("" 0) ("\\1/_primary.dat" "\\2/\\1.dat" "\\1/_primary.dat" "\\1/_primary.dat" "\\1/body.dat" downcase)) ("LEDA ProVHDL" "provhdl" "-w \\1 -f" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "provhdl" ("\\([^ 	
]+\\):\\([0-9]+\\): " 1 2 0) ("" 0) ("ENTI/\\1.vif" "ARCH/\\1-\\2.vif" "CONF/\\1.vif" "PACK/\\1.vif" "BODY/BODY-\\1.vif" upcase)) ("QuickHDL" "qvhcom" "-work \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "quickhdl" ("\\(ERROR\\|WARNING\\)[^:]*: \\(.+\\)(\\([0-9]+\\)):" 2 3 0) ("" 0) ("\\1/_primary.dat" "\\2/\\1.dat" "\\1/_primary.dat" "\\1/_primary.dat" "\\1/body.dat" downcase)) ("Savant" "scram" "-publish-cc -design-library-name \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work._savant_lib/" "Makefile" "savant" ("\\([^ 	
]+\\):\\([0-9]+\\): " 1 2 0) ("" 0) ("\\1_entity.vhdl" "\\2_secondary_units._savant_lib/\\2_\\1.vhdl" "\\1_config.vhdl" "\\1_package.vhdl" "\\1_secondary_units._savant_lib/\\1_package_body.vhdl" downcase)) ("Simili" "vhdlp" "-work \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "simili" ("\\(Error\\|Warning\\): \\w+: \\(.+\\): (line \\([0-9]+\\)): " 2 3 0) ("" 0) ("\\1/prim.var" "\\2/_\\1.var" "\\1/prim.var" "\\1/prim.var" "\\1/_body.var" downcase)) ("Speedwave" "analyze" "-libfile vsslib.ini -src" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "speedwave" ("^ *ERROR[[0-9]+]::File \\(.+\\) Line \\([0-9]+\\):" 1 2 0) ("" 0) nil) ("Synopsys" "vhdlan" "-nc -work \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "synopsys" ("\\*\\*Error: vhdlan,[0-9]+ \\(.+\\)(\\([0-9]+\\)):" 1 2 0) ("" 0) ("\\1.sim" "\\2__\\1.sim" "\\1.sim" "\\1.sim" "\\1__.sim" upcase)) ("Synopsys Design Compiler" "vhdlan" "-nc -spc -work \\1" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "synopsys_dc" ("\\*\\*Error: vhdlan,[0-9]+ \\(.+\\)(\\([0-9]+\\)):" 1 2 0) ("" 0) ("\\1.syn" "\\2__\\1.syn" "\\1.syn" "\\1.syn" "\\1__.syn" upcase)) ("Synplify" "n/a" "n/a" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "synplify" ("@[EWN]:\"\\(.+\\)\":\\([0-9]+\\):\\([0-9]+\\):" 1 2 3) ("" 0) nil) ("Vantage" "analyze" "-libfile vsslib.ini -src" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "vantage" ("\\*\\*Error: LINE \\([0-9]+\\) \\*\\*\\*" 0 1 0) ("^ *Compiling \"\\(.+\\)\" " 1) nil) ("VeriBest" "vc" "vhdl" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "veribest" ("^ +\\([0-9]+\\): +[^ ]" 0 1 0) ("" 0) nil) ("Viewlogic" "analyze" "-libfile vsslib.ini -src" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "viewlogic" ("\\*\\*Error: LINE \\([0-9]+\\) \\*\\*\\*" 0 1 0) ("^ *Compiling \"\\(.+\\)\" " 1) nil) ("Xilinx XST 14.2" "/opt/Xilinx/14.2/ISE_DS/ISE/bin/lin64/xst" "-ifn ../xst/script.xst" "make" "-f \\1" nil "mkdir \\1" "./" "work/" "Makefile" "xilinx" ("^ERROR:HDLParsers:[0-9]+ - \"\\(.+\\)\" Line \\([0-9]+\\)." 1 2 0) ("" 0) nil))))
 '(vhdl-project "EDA385")
 '(vhdl-project-alist (quote (("EDA385" "EDA385" "~/git/eda385/vhdl/simulation/" nil "" (("Xilinx XST 14.2" "\\2" "\\2" nil)) "./" "work" "work/" "Makefile" ""))))
 '(vhdl-reset-kind (quote sync))
 '(vhdl-reset-name "rst_i"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "unknown" :family "Monospace")))))

(defvar user-temporary-file-directory
  (concat temporary-file-directory user-login-name "/"))
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (,tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))
