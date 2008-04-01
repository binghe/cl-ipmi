;;;; -*- Mode: lisp; Syntax: ansi-common-lisp; Base: 10; Package: cl-user; -*-

#|
<DOCUMENTATION>
 <DESCRIPTION>
  Package definitions for IPMI
  </DESCRIPTION>
 <COPYRIGHT YEAR='2008' AUTHOR='Chun Tian (binghe)' MARK='(C)'
            HREF='https://cl-net-snmp.svn.sourceforge.net/svnroot/cl-net-snmp/ipmi/trunk/package.lisp'/>
 <CHRONOLOGY>
  <DELTA DATE='20080321'>create documentation for "package.lisp"</DELTA>
  </CHRONOLOGY>
 </DOCUMENTATION>
|#

(in-package :cl-user)

(defpackage ipmi
  (:use :common-lisp
        :usocket
        :trivial-gray-streams)
  (:export #:rmcp
           #:asf))

(in-package :ipmi)

;;; Logical Pathname Translations
(eval-when (:load-toplevel :execute)
  (let* ((defaults #+asdf (asdf:component-pathname (asdf:find-system :ipmi))
                   #-asdf *load-pathname*)
         (home (make-pathname :name :wild :type :wild
                              :directory (append (pathname-directory defaults)
                                                 '(:wild-inferiors))
                              :host (pathname-host defaults)
                              :defaults defaults)))
    (setf (logical-pathname-translations "ipmi")
          `(("**;*.*" ,home)))))

:eof
