;;;; -*- Mode: Lisp -*-
;;;; $Id$

;;;; IPMI (Intelligent Platform Management Interface)

(in-package :ipmi)

(defvar *asf-rmcp-port* 623)

(defun asf-ping (host &optional port)
  (let* ((socket (socket-connect/udp host (or port *asf-rmcp-port*)
                                 :stream t :element-type '(unsigned-byte 8)))
         (ping (make-instance 'asf-presence-ping)))
    (write-sequence (encode ping) (socket-stream socket))
    (force-output (socket-stream socket))))
