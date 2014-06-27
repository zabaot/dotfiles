; 言語を日本語にする
(set-language-environment 'Japanese)
; 極力UTF-8とする
(prefer-coding-system 'utf-8)

;; Mac用フォント設定
;; 英語
(set-face-attribute 'default nil
	:family "Menlo" ;; font
	:height 150)    ;; font size

;; 日本語
(set-fontset-font
	nil 'japanese-jisx0208
;; (font-spec :family "Hiragino Mincho Pro")) ;; font
(font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; 半角と全角の比を1:2にしたければ
(setq face-font-rescale-alist
;;        '((".*Hiragino_Mincho_pro.*" . 1.2)))
	'((".*Hiragino_Kaku_Gothic_ProN.*" . 1.2)));; Mac用フォント設定

