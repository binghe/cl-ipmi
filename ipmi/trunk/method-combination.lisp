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

(defgeneric encode (object)
  (:documentation "Encode a object into packet data")
  (:method-combination ipmi))
