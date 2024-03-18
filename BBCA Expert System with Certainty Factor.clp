(deffacts initial-bbca-3-years-stats
(book-value 1801.09)
(pbv 4.78)
(eps 326.34)
(pe 27.45)
)

(deftemplate introduction
(slot done-introducting)
)

; introduction

(defrule introduct
=>
(printout t "Hello, I am a bbca analyst expert system. Nice to meet you!!" crlf)
(printout t "I'll pose a series of questions to assist you in evaluating whether a bbca is overvalued or reasonably priced." crlf crlf)
(assert (introduction (done-introducting yes)))
)

; current book value

(defrule ask-for-current-book-value
(introduction (done-introducting yes))
=>
((printout t "In future circumstances, would you think the book value for bbca would decrease, normal, or increase?" crlf)
(printout t "PS: The 3-years mean of bbca book value is 1801.09" crlf))
(bind ?response(read))
(if (member$ ?response (create$ "decrease" "normal" "increase"))
       then
       (assert (future-book-value ?response))
       else
       (printout t "Invalid value. Please enter a valid value." crlf))
)

(defrule increase-book-value
(future-book-value "increase")
=>
(printout t "In a scale of 0-1, how sure do you think the book value would increase?" crlf crlf)
(bind ?response(read))
(assert (increase-book-value ?response))
)

(defrule decrease-book-value
(future-book-value "decrease")
=>
(printout t "In a scale of 0-1, how sure do you think the book value would decrease?" crlf crlf)
(bind ?response(read))
(assert (decrease-book-value ?response))
)

; price to book value

(defrule ask-for-current-price-to-book-value
(introduction (done-introducting yes))
=>
((printout t "In future circumstances, would you think the price to book value for bbca would decrease, normal, or increase?" crlf)
(printout t "PS: The 3-years mean of bbca price to book value is 4.78" crlf))
(bind ?response(read))
(if (member$ ?response (create$ "decrease" "normal" "increase"))
       then
       (assert (future-price-to-book-value ?response))
       else
       (printout t "Invalid value. Please enter a valid value." crlf))
)

(defrule increase-price-to-book-value
(future-price-to-book-value "increase")
=>
(printout t "In a scale of 0-1, how sure do you think the price to book value would increase?" crlf crlf)
(bind ?response(read))
(assert (increase-price-to-book-value ?response))
)

(defrule decrease-book-value
(future-price-to-book-value "decrease")
=>
(printout t "In a scale of 0-1, how sure do you think the book value would decrease?" crlf crlf)
(bind ?response(read))
(assert (decrease-price-to-book-value ?response))
)
