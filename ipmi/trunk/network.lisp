;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :ipmi)

(defvar *asf-rmcp-port* 623)

#-(and lispworks win32)
(defun send-ipmi-message (session message)
  (declare (type ipmi-session session)
           (type rmcp message))
  (socket-sync (ipmi-socket session) message
               :address (ipmi-host session)
               :port (ipmi-port session)
               :encode-function #'(lambda (x) (values (ipmi-encode x) 0))
               :decode-function #'(lambda (x) (values (ipmi-decode x) 0))))

#+(and lispworks win32)
(defun send-ipmi-message (session message)
  (declare (type ipmi-session session)
           (type rmcp message))
  (comm:sync-message (socket (ipmi-socket session))
                     message
                     (ipmi-host session)
                     (ipmi-port session)
                     :encode-function #'(lambda (x) (values (ipmi-encode x) 0))
                     :decode-function #'(lambda (x) (values (ipmi-decode x) 0))))

(defun ipmi-connect (host &optional (port *asf-rmcp-port*))
  (declare (ignorable host port))
  #-win32
  (socket-connect/udp nil nil   ; On Mac OS X, we must NOT connect()
                      :element-type '(unsigned-byte 8)
                      :stream nil)
  #+win32
  (socket-connect/udp host port ; On Win32, we must bind(), so we connect() instead
                      :element-type '(unsigned-byte 8)
                      :stream nil))
