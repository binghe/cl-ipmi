;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :ipmi)

;; octets type is commonly used by many files, define it here.
(deftype octets () `(simple-array (unsigned-byte 8) (*)))

(define-method-combination ipmi ()
  ((head () :required t))
  (flet ((call-methods (methods)
	   (mapcar #'(lambda (method)
		       `(call-method ,method))
		   methods)))
    `(apply #'concatenate
	    'octets ; vector
	    (nreverse (list ,@(call-methods head))))))

(defgeneric ipmi-encode (object)
  (:documentation "Encode a object into packet data")
  (:method-combination ipmi))

(defgeneric ipmi-decode (stream)
  (:documentation "Decode a object from packet stream"))

(defmethod ipmi-decode ((data sequence))
  (let ((stream (make-instance 'asn.1:ber-stream :sequence data)))
    (ipmi-decode stream)))

(defmethod ipmi-decode ((stream stream))
  (ipmi-decode-protocol stream t :rmcp))

(defgeneric ipmi-decode-protocol (stream parent protocol))

(defun decode-integer-4 (stream)
  (declare (type stream stream))
  (let ((a (read-byte stream))
        (b (read-byte stream))
        (c (read-byte stream))
        (d (read-byte stream)))
    (logior (ash a 24) (ash b 16) (ash c 8) d)))
