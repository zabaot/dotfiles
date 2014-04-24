;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_color.el --- color setting file


;; Copyright (C) 2004-2012  sakito
;; Author: sakito <sakito@sakito.com>

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary: 色の設定

;; 

;;; Code:

;; デフォルトのフレーム設定
;; ディスプレイサイズによって分離する試み 途中
(cond
 ;; デュアルだったりトリプルだったりするので width の方は条件に入れてない
 ;; 設定は (frame-parameter (selected-frame) 'height) などで値を取得して設定する
 ((= (display-pixel-height) 1440)
  (setq default-frame-alist
        (append (list
                 '(width . 200)
                 '(height . 80)
                 '(top . 100)
                 '(left . 650)
                 )
                default-frame-alist)))
 ;; 1920 * 1200 ディスプレイ
 ((= (display-pixel-height) 1200)
  (setq default-frame-alist
        (append (list
                 '(width . 175)
                 '(height . 65)
                 '(top . 50)
                 '(left . 500)
                 )
                default-frame-alist)))
 ;; MacBook Pro ディスプレイ
 ((= (display-pixel-height) 900)
  (setq default-frame-alist
        (append (list
                 '(width . 110)
                 '(height . 50)
                 '(top . 22)
                 '(left . 637)
                 )
                default-frame-alist)))
 ;; とりあえずその他 完全に未確認で分岐できる事を確認するためのコード
 (t
  (setq default-frame-alist
        (append (list
                 '(width . 140)
                 '(height . 50)
                 '(top . 90)
                 '(left . 100)
                 )
                default-frame-alist))))

;; 垂直スクロール用のスクロールバーを付けない
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))

;; 背景の透過
;; (add-to-list 'default-frame-alist '(alpha . (85 20)))
(add-to-list 'default-frame-alist '(alpha . (92 70)))

;;; フォントの設定
;; システム依存を排除するために一旦デフォルトフォントセットを上書き
;; 漢字は IPAゴジック + かな英数字は September を設定(等幅以外はインストールしてない)
;; jisx0208の範囲の漢字は September にすべきかもしれない
;; face の設定は基本的に全て color-thema に設定する方針
;; japanese-jisx0213.2004-1 = japanese-jisx0213-a + japanese-jisx0213-1
;; japanese-jisx0213-1 = japanese-jisx0208 のほぼ上位互換
;; japanese-jisx0213-2 = code-offset #x150000
;; japanese-jisx0212 = code-offset #x148000
;; japanese-jisx0208 = code-offset #x140000
(when mac-p
  (set-face-attribute 'default
                      nil
                      :family "September"
                      :height 140)
  (set-frame-font "September-14")
  (set-fontset-font nil
                    'unicode
                    ;; (font-spec :family "IPAGothic")
                    (font-spec :family "September")
                    nil
                    'append)
  ;; 古代ギリシア文字、コプト文字を表示したい場合は以下のフォントをインストールする
  ;; http://apagreekkeys.org/NAUdownload.html
  (set-fontset-font nil
                    'greek-iso8859-7
                    (font-spec :family "New Athena Unicode")
                    nil
                    'prepend)
  ;; 一部の文字を September にする
  ;; 記号         3000-303F http://www.triggertek.com/r/unicode/3000-303F
  ;; 全角ひらがな 3040-309f http://www.triggertek.com/r/unicode/3040-309F
  ;; 全角カタカナ 30a0-30ff http://www.triggertek.com/r/unicode/30A0-30FF
  (set-fontset-font nil
                    '( #x3000 .  #x30ff)
                    (font-spec :family "September")
                    nil
                    'prepend)
  ;; 半角カタカナ、全角アルファベット ff00-ffef http://www.triggertek.com/r/unicode/FF00-FFEF
  (set-fontset-font nil
                    '( #xff00 .  #xffef)
                    (font-spec :family "September")
                    nil
                    'prepend)

  ;; その他サンプル設定
  (when (find-font (font-spec :family "Menlo"))
    ;; ヒラギノ 角ゴ ProN + Menlo
    (create-fontset-from-ascii-font "Menlo-14" nil "menlokakugo")
    (set-fontset-font "fontset-menlokakugo"
                      'unicode
                      (font-spec :family "Hiragino Kaku Gothic ProN" :size 16))
    ;; 確認用 (set-frame-font "fontset-menlokakugo")
    ;; (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))  ;; 実際に設定する場合
    )
  )

;; linux では Ricty を利用している
(when linux-p
  (when (find-font (font-spec :family "Ricty"))
    ;; http://save.sys.t.u-tokyo.ac.jp/~yusa/fonts/ricty.html
    (set-face-attribute 'default
                        nil
                        :family "Ricty"
                        :height 140)
    (add-to-list 'default-frame-alist '(font . "Ricty-14"))
    (set-fontset-font nil
                      'unicode
                      (font-spec :family "Ricty")
                      nil
                      'append)
    ;; (set-frame-font "Ricty-16:weight=normal:slant=normal")
    ;; (set-frame-font "Aicty-14:weight=normal:slant=normal")
    ))


;; フォントロックの設定
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t)
  ;;(setq font-lock-maximum-decoration t)
  (setq font-lock-support-mode 'jit-lock-mode))

;; タブ文字、全角空白、文末の空白の色付け
;; @see http://www.emacswiki.org/emacs/WhiteSpace
;; @see http://xahlee.org/emacs/whitespace-mode.html
(setq whitespace-style '(spaces tabs space-mark tab-mark))
(setq whitespace-display-mappings
      '(
       ;; (space-mark 32 [183] [46]) ; normal space, ·
        (space-mark 160 [164] [95])
        (space-mark 2208 [2212] [95])
        (space-mark 2336 [2340] [95])
        (space-mark 3616 [3620] [95])
        (space-mark 3872 [3876] [95])
        (space-mark ?\x3000 [?\□]) ;; 全角スペース
        ;; (newline-mark 10 [182 10]) ; newlne, ¶
        (tab-mark 9 [9655 9] [92 9]) ; tab, ▷
        ))
(require 'whitespace)
;; (global-whitespace-mode 1) 常に whitespace-mode だと動作が遅くなる場合がある
(global-set-key (kbd "C-x w") 'global-whitespace-mode)

;; 行末の空白を表示
(setq-default show-trailing-whitespace t)
;; EOB を表示
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)

;; マーク領域を色付け
(setq transient-mark-mode t)

;; 変更点に色付け
(global-highlight-changes-mode t)
;; 初期は非表示として highlight-changes-visible-mode で表示する
(setq highlight-changes-visibility-initial-state nil)
(global-set-key (kbd "M-]") 'highlight-changes-next-change)
(global-set-key (kbd "M-[") 'highlight-changes-previous-change)

;; 現在行に色を付ける
;;(global-hl-line-mode)
;;(hl-line-mode 1)
;; 標準の hl-line だと結構邪魔なので拡張機能に変更
;; @see http://www.emacswiki.org/emacs/hl-line%2B.el
(require 'hl-line+)
(toggle-hl-line-when-idle 1)


;; 列に色を付ける
;; @see http://www.emacswiki.org/emacs/CrosshairHighlighting
;; @see http://www.emacswiki.org/emacs/VlineMode
;; @see http://www.emacswiki.org/cgi-bin/wiki/vline.el
;;(require 'crosshairs)

;; color-theme
(setq color-theme-load-all-themes nil)
(setq color-theme-libraries nil)
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (cond
      (mac-p
       (require 'color-theme-dark)
       (color-theme-dark))
      (windows-p
       (require 'color-theme-ntemacs)
       (color-theme-ntemacs))
      (t
       (require 'color-theme-dark)
       (color-theme-dark))
      )))

;; face を調査するための関数
;; いろいろ知りたい場合は C-u C-x =
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

;; kill-ring 中の属性を削除
;; @see http://www-tsujii.is.s.u-tokyo.ac.jp/~yoshinag/tips/junk_elisp.html
;; (defadvice kill-new (around my-kill-ring-disable-text-property activate)
;;   (let ((new (ad-get-arg 0)))
;;     (set-text-properties 0 (length new) nil new)
;;     ad-do-it))


(provide 'init_color)
;;; init_color.el ends here
