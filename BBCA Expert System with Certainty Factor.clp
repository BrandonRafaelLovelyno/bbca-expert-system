(deffacts initial-bbca-3-years-stats
(book-value 1801.09)
(pbv 4.78)
(eps 326.34)
(pe 27.45)
)

(deftemplate introduction
(slot done-introducting)
)

; calculate certainties

(defrule calculate-cf-both-positive
?fact1<-(?prediction ?c1&:(>= ?c1 0))
?fact2<-(?prediction ?c2&:(>= ?c2 0))
(test (neq ?fact1 ?fact2))
=>
(retract ?fact1 ?fact2)
(bind ?c3 (-(+ ?c1 ?c2) (* ?c1 ?c2)))
(assert (?prediction ?c3))
)

(defrule calculate-cf-both-negative
?fact1<-(?prediction ?c1&:(<= ?c1 0))
?fact2<-(?prediction ?c2&:(<= ?c2 0))
=>
(retract ?fact1 ?fact2)
(bind ?c3 (+(+ ?c1 ?c2) (* ?c1 ?c2)))
(assert (?prediction ?c3))
)

(defrule calculate-cf-opposite-signs
?fact1<-(?prediction ?c1&:(>= ?c1 0))
(test (<= ?c1 1))
?fact2<-(?prediction ?c2&:(<= ?c2 0))
(test (>= ?c2 -1))
=>
(retract ?fact1 ?fact2)
(bind ?c3 (/(+ ?c1 ?c2) (-1 (min(abs ?c1) (abs ?c2)))))
(assert (?prediction ?c3))
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
(future-book-value ?response)
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

; earning per share

(defrule ask-for-current-earning-per-share
(introduction (done-introducting yes))
(future-price-to-book-value ?response)
=>
((printout t "In future circumstances, would you think the earning per share for bbca would decrease, normal, or increase?" crlf)
(printout t "PS: The 3-years mean of bbca earning per share is 326.34" crlf))
(bind ?response(read))
(if (member$ ?response (create$ "decrease" "normal" "increase"))
       then
       (assert (future-earning-per-share ?response))
       else
       (printout t "Invalid value. Please enter a valid value." crlf))
)

(defrule increase-earning-per-share
(future-earning-per-share "increase")
=>
(printout t "In a scale of 0-1, how sure do you think the earning per share would increase?" crlf crlf)
(bind ?response(read))
(assert (increase-earning-per-share ?response))
)

(defrule decrease-earning-per-share
(future-earning-per-share "decrease")
=>
(printout t "In a scale of 0-1, how sure do you think the earning per share would decrease?" crlf crlf)
(bind ?response(read))
(assert (decrease-earning-per-share ?response))
)

; price to earning

(defrule ask-for-current-price-to-earning
(introduction (done-introducting yes))
(future-earning-per-share ?response)
=>
((printout t "In future circumstances, would you think the price to earning for bbca would decrease, normal, or increase?" crlf)
(printout t "PS: The 3-years mean of bbca price to earning is 27.45" crlf))
(bind ?response(read))
(if (member$ ?response (create$ "decrease" "normal" "increase"))
       then
       (assert (future-price-to-earning ?response))
       else
       (printout t "Invalid value. Please enter a valid value." crlf))
)

(defrule increase-price-to-earning
(future-price-to-earning "increase")
=>
(printout t "In a scale of 0-1, how sure do you think the price to earning would increase?" crlf crlf)
(bind ?response(read))
(assert (increase-price-to-earning ?response))
)

(defrule decrease-price-to-earning
(future-price-to-earning "decrease")
=>
(printout t "In a scale of 0-1, how sure do you think the price to earning would decrease?" crlf crlf)
(bind ?response(read))
(assert (decrease-price-to-earning ?response))
)

; conclude investor action


