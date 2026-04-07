; extends
(emphasis) @emphasis.outer
(strong_emphasis) @emphasis.outer
((strong_emphasis) @emphasis.inner (#offset! @emphasis.inner 0 2 0 -2))
((emphasis) @emphasis.inner (#offset! @emphasis.inner 0 1 0 -1))
(inline_link) @mdlink.outer
(link_text) @mdlink.inner
