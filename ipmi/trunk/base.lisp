;;;; -*- Mode: Lisp -*-
;;;; $Id$

(in-package :ipmi)

(define-method-combination ipmi ()
  ((head () :required t))
  (flet ((call-methods (methods)
	   (mapcar #'(lambda (method)
		       `(call-method ,method))
		   methods)))
    `(apply #'concatenate
	    'vector
	    (nreverse (list ,@(call-methods head))))))

(defgeneric ipmi-encode (object)
  (:documentation "Encode a object into packet data")
  (:method-combination ipmi))

(defgeneric ipmi-decode (stream)
  (:documentation "Decode a object from packet stream"))

(defmethod ipmi-decode ((data sequence))
  (let ((stream (make-instance 'asn.1:ber-stream :sequence data)))
    (ipmi-decode stream)))
