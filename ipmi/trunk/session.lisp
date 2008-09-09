;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :ipmi)

(defclass ipmi-session ()
  ((socket  :type datagram-usocket
            :accessor ipmi-socket
            :initarg :socket)
   (host    :type string
            :accessor ipmi-host
            :initarg :host)
   (port    :type integer
            :accessor ipmi-port
            :initarg :port
            :initform *asf-rmcp-port*)
   (version :type number
            :accessor ipmi-version
            :initarg :version
            :initform 1.5))
  (:documentation "IPMI session"))

(defun open-session (host)
  (make-instance 'ipmi-session
                 :socket (ipmi-connect host)
                 :host host))

(defun close-session (session)
  (declare (type ipmi-session session))
  (socket-close (ipmi-socket session)))

(defmacro with-open-session ((session &rest args) &body body)
  `(let ((,session (open-session ,@args)))
     (unwind-protect
         (progn ,@body)
       (close-session ,session))))
