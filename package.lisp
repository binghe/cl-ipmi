;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :cl-user)

(defpackage ipmi
  (:use :common-lisp
        :usocket
        :trivial-gray-streams))

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
    (setf (logical-pathname-translations "IPMI")
          `(("**;*.*" ,home)))))
