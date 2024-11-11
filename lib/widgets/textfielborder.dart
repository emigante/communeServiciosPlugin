import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldBorder extends StatefulWidget {
  final String? hint;
  TextInputType? type = TextInputType.text;
  final TextEditingController? controller;
  Function? validation;
  Function? change;
  bool? obscure = false;
  Color? color;
  TextCapitalization? capitalization;
  Widget? prefixIcon;
  String? errorText;
  bool? space;
  double? paddingBoth;
  bool? readOnly;
  bool? enable;
  Function()? onTap;

  TextFormFieldBorder(this.hint, this.controller,
      {super.key,
      this.type,
      this.obscure,
      this.color,
      this.space,
      this.validation,
      this.paddingBoth,
      this.readOnly,
      this.enable,
      this.onTap});
  TextFormFieldBorder.withCustomCapitalization(
      {super.key,
      this.errorText,
      this.change,
      this.hint,
      this.controller,
      this.type,
      this.obscure,
      this.color,
      this.capitalization,
      this.validation,
      this.space,
      this.prefixIcon,
      this.enable,
      this.onTap,
      this.paddingBoth});
  TextFormFieldBorder.withCustomValidator(
      {super.key,
      this.hint,
      this.type,
      this.controller,
      this.validation,
      this.color,
      this.obscure,
      this.space,
      this.onTap,
      this.enable,
      this.prefixIcon,
      this.paddingBoth});
  TextFormFieldBorder.withCustomChange(
      {super.key,
      this.hint,
      this.type,
      this.controller,
      this.change,
      this.space,
      this.prefixIcon,
      this.onTap,
      this.paddingBoth});
  TextFormFieldBorder.withCustomChangeAndValidator(
      {super.key,
      this.hint,
      this.type,
      this.controller,
      this.change,
      this.validation,
      this.color,
      this.space,
      this.onTap,
      this.prefixIcon,
      this.paddingBoth});

  @override
  _TextFormFieldBorderState createState() => _TextFormFieldBorderState();
}

class _TextFormFieldBorderState extends State<TextFormFieldBorder> {
  // UIHelper _uIHelper = new UIHelper();
  bool show = false;
  @override
  Widget build(BuildContext context) {
    widget.capitalization = (widget.type == TextInputType.emailAddress)
        ? TextCapitalization.none
        : widget.capitalization;
    widget.space = widget.space ?? true;
    return Padding(
        padding: EdgeInsets.only(
            left: widget.paddingBoth ?? 0, right: widget.paddingBoth ?? 0),
        child: Row(
          children: [
            widget.prefixIcon ?? const SizedBox(),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TextFormField(
                //enableInteractiveSelection: false,
                onTap:  widget.onTap,
                textCapitalization: (widget.capitalization == null)
                    ? TextCapitalization.sentences
                    : widget.capitalization!,
                obscureText:
                    widget.obscure == null ? false : (widget.obscure! && !show),
                readOnly:
                    widget.readOnly != null ? (widget.readOnly as bool) : false,
                decoration: InputDecoration(
                  //prefixIcon: prefixIcon,
                  filled: true,
                  enabled:
                      widget.enable != null ? !(widget.enable as bool) : true,
                  labelText: widget.hint,
                  fillColor: widget.color,
                  hintText: widget.hint,
                  enabledBorder: border(false),
                  focusedBorder: border(true),
                  border: border(false),
                  errorText: widget.errorText,
                ),

                controller: widget.controller,
                keyboardType: widget.type,
                inputFormatters: widget.space!
                    ? []
                    : [FilteringTextInputFormatter.deny(RegExp("[ ]"))],
                validator: widget.validation == null
                    // ignore: unnecessary_cast
                    ? (value) {
                        if (value.isEmpty) {
                          return "Campo requerido";
                        }
                        return null;
                      } as String? Function(String?)?
                    : widget.validation as String? Function(String?)?,
                onChanged: (widget.change == null)
                    ? null
                    : widget.change as void Function(String)?,
              ),
            ),
            widget.obscure! ? _eye() : const SizedBox(),
          ],
        ));
  }

  _eye() {
    return InkWell(
      onTap: () {
        setState(() {
          show = !show;
        });
      },
      child: show
          ? const Icon(
              Icons.remove_red_eye,
              size: 20,
            )
          : const Icon(
              Icons.remove_red_eye_outlined,
              size: 20,
            ),
    );
  }
}

UnderlineInputBorder border(bool focus) {
  return UnderlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Color(0xFF2d4e3d), width: focus ? 2 : 1));
}
