;;;; -*- Mode: Lisp -*-
;;;; $Id$

;;;; IPMI (Intelligent Platform Management Interface)

(in-package :ipmi)

(defun asf-ping (host)
  (let ((ping (make-instance 'asf-presence-ping)))
    (with-open-session (session host)
      (send-ipmi-message session ping))))
