import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/card_bloc/card_bloc.dart';
import '../../../widgets/index.dart';
import '../../../../domain/entities/column_item.dart';
import '../../../../../../style/index.dart';

class ColumnFooter extends StatefulWidget {
  final ColumnItem column;

  ColumnFooter({
    @required this.column,
  });

  @override
  _ColumnFooterState createState() => _ColumnFooterState();
}

class _ColumnFooterState extends State<ColumnFooter> {
  CardBloc get cardBloc => BlocProvider.of<CardBloc>(context);
  TextEditingController _cardController = TextEditingController();
  bool showForm = false;
  bool isTitleEmpty = false;
  final _formKey = GlobalKey<FormState>();
  final _cardFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _cardFocusNode.dispose();
    _cardController.dispose();
  }

  void _toggleShowForm() => setState(() => showForm = !showForm);

  void _createCard() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _toggleShowForm();

      cardBloc.add(
        CreateCardEvent(
          columnId: widget.column.id,
          cardIndex: widget.column.cards.length,
          title: _cardController.text,
        ),
      );
    }
  }

  Widget _buildCardTitleFormField() {
    return TextFormField(
      controller: _cardController,
      focusNode: _cardFocusNode,
      onFieldSubmitted: (_) => _createCard(),
      decoration: InputDecoration(
        hintText: "Type a name for your card",
      ),
      style: defaultTextStyle,
      onChanged: (value) {
        if (value.isEmpty) {
          setState(() => isTitleEmpty = false);
        } else if (value.isNotEmpty) {
          setState(() => isTitleEmpty = true);
        }
      },
      validator: (value) {
        if (value.isEmpty) {
          return "Card title can't be empty.";
        } else if (value.length > 100) {
          return "Card title can't be over 100 characters.";
        }
        return null;
      },
    );
  }

  Widget _buildButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedDeleteButton(handler: _toggleShowForm),
        SizedBox(width: 15),
        OutlinedButton(
          child: Text('Add Card'),
          onPressed: isTitleEmpty ? _createCard : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) {
                if (states.contains(MaterialState.pressed)) {
                  return ThemeColor.success_press;
                } else if (!isTitleEmpty) {
                  return ThemeColor.success_bg.withOpacity(0.2);
                }
                return ThemeColor.success_bg;
              },
            ),
            side: MaterialStateProperty.resolveWith<BorderSide>((states) {
              if (!isTitleEmpty) {
                return BorderSide(
                    color: ThemeColor.success_border.withOpacity(0.2));
              }
              return BorderSide(color: ThemeColor.success_border);
            }),
            foregroundColor:
                MaterialStateProperty.all<Color>(ThemeColor.text_normal),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateWidth(5),
        vertical: getProportionateWidth(15),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildCardTitleFormField(),
            SizedBox(height: 10),
            _buildButtonBar(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: getProportionateWidth(7)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showForm
              ? _buildForm()
              : TextButton(
                  onPressed: () {
                    _toggleShowForm();
                    _cardFocusNode.requestFocus();
                  },
                  child: Text(
                    'Add a card',
                    style: TextStyle(
                      color: ThemeColor.link,
                      fontSize: ThemeSize.fs_17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
