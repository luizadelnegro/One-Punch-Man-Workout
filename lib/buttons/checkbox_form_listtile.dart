import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckboxFormListTile extends FormField<bool> {
  CheckboxFormListTile({
    Widget title,
    Widget secondary = null,
    FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool> validator,
    bool initialValue = false,
    bool autovalidate = false
  }) : super (
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    autovalidate: autovalidate,
    builder: (FormFieldState<bool> state){
      return CheckboxListTile( 
        activeColor: Colors.grey[600],
        checkColor: Colors.white,
        dense: state.hasError,
        title: title,
        value: state.value,
        onChanged: state.didChange,
        subtitle: state.hasError ? Builder ( 
          builder: (BuildContext context) => Text(
            state.errorText,
            style: TextStyle(color: Theme.of(context).errorColor),
          )
        ) : null,
        secondary: secondary,
        controlAffinity: ListTileControlAffinity.leading,
      );
    });
}