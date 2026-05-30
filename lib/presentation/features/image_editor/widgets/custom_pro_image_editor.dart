import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pro_image_editor/pro_image_editor.dart';
import 'package:twinfix/core/extensions/num_extensions.dart';
import 'package:twinfix/generated/l10n.dart';

class CustomProImageEditor extends StatefulWidget {
  final String imagePath;
  final ValueChanged<Uint8List> onSaveComplete;
  final VoidCallback onClose;
  final VoidCallback onSaveStarted;

  const CustomProImageEditor({
    super.key,
    required this.imagePath,
    required this.onSaveComplete,
    required this.onClose,
    required this.onSaveStarted,
  });

  @override
  State<CustomProImageEditor> createState() => _CustomProImageEditorState();
}

class _CustomProImageEditorState extends State<CustomProImageEditor> {
  @override
  Widget build(BuildContext context) {
    return ProImageEditor.file(
      File(widget.imagePath),
      key: ValueKey(widget.imagePath),
      callbacks: ProImageEditorCallbacks(
        onImageEditingComplete: (bytes) async {
          Future.delayed(100.milliseconds, () {
            if (mounted) {
              widget.onSaveComplete(bytes);
            }
          });
        },
      ),
      configs: ProImageEditorConfigs(
        designMode: ImageEditorDesignMode.cupertino,
        i18n: I18n(
          cancel: S.of(context).cancel,
          undo: S.of(context).back,
          done: S.of(context).finish,
          doneLoadingMsg: S.of(context).saving,
          tuneEditor: I18nTuneEditor(
            bottomNavigationBarText: S.of(context).tune,
            back: S.of(context).back,
            done: S.of(context).finish,
            brightness: S.of(context).brightness,
            contrast: S.of(context).contrast,
            saturation: S.of(context).saturation,
            exposure: S.of(context).exposure,
            hue: S.of(context).hue,
            temperature: S.of(context).temperature,
            sharpness: S.of(context).sharpness,
            fade: S.of(context).fade,
            luminance: S.of(context).luminance,
            undo: S.of(context).undo,
            redo: S.of(context).redo,
          ),
          paintEditor: I18nPaintEditor(
            bottomNavigationBarText: S.of(context).paint,
            moveAndZoom: S.of(context).moveAndZoom,
            freestyle: S.of(context).freestyle,
            freestyleArrowStart: S.of(context).freestyleArrowStart,
            freestyleArrowEnd: S.of(context).freestyleArrowEnd,
            freestyleArrowStartEnd: S.of(context).freestyleArrowStartEnd,
            arrow: S.of(context).arrow,
            line: S.of(context).line,
            rectangle: S.of(context).rectangle,
            circle: S.of(context).circle,
            dashLine: S.of(context).dashLine,
            dashDotLine: S.of(context).dashDotLine,
            hexagon: S.of(context).hexagon,
            polygon: S.of(context).polygon,
            blur: S.of(context).blur,
            pixelate: S.of(context).pixelate,
            custom1: S.of(context).custom1,
            custom2: S.of(context).custom2,
            custom3: S.of(context).custom3,
            lineWidth: S.of(context).lineWidth,
            eraser: S.of(context).eraser,
            toggleFill: S.of(context).toggleFill,
            changeOpacity: S.of(context).changeOpacity,
            undo: S.of(context).undo,
            redo: S.of(context).redo,
            done: S.of(context).finish,
            back: S.of(context).back,
            smallScreenMoreTooltip: S.of(context).smallScreenMoreTooltip,
            opacity: S.of(context).opacity,
            color: S.of(context).color,
            strokeWidth: S.of(context).strokeWidth,
            fill: S.of(context).fill,
            cancel: S.of(context).cancel,
          ),
          textEditor: I18nTextEditor(
            inputHintText: S.of(context).inputHintText,
            bottomNavigationBarText: S.of(context).text,
            back: S.of(context).back,
            done: S.of(context).finish,
            textAlign: S.of(context).textAlign,
            fontScale: S.of(context).fontScale,
            backgroundMode: S.of(context).backgroundMode,
            smallScreenMoreTooltip: S.of(context).smallScreenMoreTooltip,
          ),
          cropRotateEditor: I18nCropRotateEditor(
            bottomNavigationBarText: S.of(context).crop,
            rotate: S.of(context).rotate,
            flip: S.of(context).flip,
            ratio: S.of(context).ratio,
            back: S.of(context).back,
            done: S.of(context).finish,
            cancel: S.of(context).cancel,
            undo: S.of(context).undo,
            redo: S.of(context).redo,
            smallScreenMoreTooltip: S.of(context).smallScreenMoreTooltip,
            reset: S.of(context).reset,
          ),
          filterEditor: I18nFilterEditor(
            bottomNavigationBarText: S.of(context).filter,
            back: S.of(context).back,
            done: S.of(context).finish,
            filters: I18nFilters(none: S.of(context).noFilter),
          ),
          blurEditor: I18nBlurEditor(
            bottomNavigationBarText: S.of(context).blur,
            back: S.of(context).back,
            done: S.of(context).finish,
          ),
        ),
      ),
    );
  }
}
