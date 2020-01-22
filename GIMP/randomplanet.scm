
(script-fu-register
	"script-fu-random-planet"
	"Random Planet"
	""
	"Keksi"
	""
	""
	""
	SF-IMAGE "Image" 0
	SF-VALUE "Max angle deviation (deg)" "20"
	SF-VALUE "Max size decrease (%)" "30"


)(script-fu-menu-register "script-fu-random-planet" "<Image>/File")

;(define (RandomResize img layer max_angle)
;(let*
;	(
;		(image_width (car (gimp-image-width img)))
;		(image_height (car (gimp-image-height img)))
;		(layer_width (car (gimp-drawable-width layer)))
;		(layer_height (car (gimp-drawable-height layer)))
;	)
;   (gimp-layer-set-offsets layer
;      (/ (- image_width layer_width) 2)
;      (/ (- image_height layer_height) 2))
;))


(define (script-fu-random-planet
         img max_angle max_shrink)
(let* 
    (
        (layer (car (gimp-image-get-active-layer img)))
        (rad_degree 0.01745329251994329576923690768489)
        (new_angle (- (random (* 2 max_angle)) max_angle))
        (new_size (* (/ (- 100 (random max_shrink)) 100)))
    )

    (gimp-image-undo-group-start img)
    (gimp-context-push)
    
    (gimp-layer-scale
        layer
        (* new_size (car (gimp-drawable-width layer)))
        (* new_size (car (gimp-drawable-height layer)))
        TRUE
    )
    
    (gimp-item-transform-rotate
        layer
        (* rad_degree new_angle)
        TRUE
        0
        0
    )
    
    (gimp-hue-saturation
        layer
        0
        (- (random (* 2 180)) 180)
        0
        0
    )
 
	(gimp-context-pop)
	(gimp-displays-flush)
	(gimp-image-undo-group-end img)
)
)


;(define (script-fu-angled-text-box
;		 img text font font_size first_color angle box_min_width updown_text second_color)
;(let*
;	(
;		(text_layer (car (gimp-text-layer-new img text font font_size PIXELS)))
;		(text_layer_flipped (car (gimp-text-layer-new img text font font_size PIXELS)))
;		(text_width (car (gimp-drawable-width text_layer)))
;		(box_height (car (gimp-drawable-height text_layer)))
;		(box_width box_min_width)
;		(layer_padding 0)
;		(rad_degree 0.01745329251994329576923690768489)
;	)
;	
;	(gimp-image-undo-group-start img)
;	(gimp-context-push)
;	
;	
;	(gimp-image-insert-layer img text_layer 0 0)
;	(gimp-image-insert-layer img text_layer_flipped 0 0)
;	(gimp-text-layer-set-color text_layer first_color)
;	(gimp-text-layer-set-color text_layer_flipped second_color)
;
;	(if (= updown_text TRUE)
;		(set! layer_padding (/ (- box_width (* text_width 2)) 3))			
;		(set! layer_padding (/ (- box_width text_width) 2))
;	)
;	(if (positive? layer_padding)
;		(begin 
;			(gimp-layer-resize text_layer (+ text_width (* layer_padding 2)) box_height layer_padding 0)
;			(gimp-layer-resize text_layer_flipped (+ text_width (* layer_padding 2)) box_height layer_padding 0)
;		)
;	)
;	(if (= updown_text TRUE)
;		(begin 
;			(gimp-item-transform-flip-simple text_layer_flipped 1 TRUE 0)
;			(gimp-item-transform-flip-simple text_layer_flipped 0 TRUE 0)
;			(gimp-layer-translate text_layer_flipped (+ text_width layer_padding) 0)
;			(set! text_layer (car (gimp-image-merge-down img text_layer_flipped 0)))
;		)
;		(gimp-image-remove-layer img text_layer_flipped)
;	)
;		
;	(gimp-item-transform-rotate text_layer (* rad_degree angle) TRUE 0 0)
;	(gimp-item-set-name text_layer "Text box")
;	
;	(CenterLayer img text_layer)
;	
;		
;	(gimp-context-pop)
;	(gimp-displays-flush)
;	(gimp-image-undo-group-end img)
;)
;)
