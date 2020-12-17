import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/widgets/index.dart';
import '../../../blocs/card_bloc/card_bloc.dart';
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
  bool isTitleEmpty = true;
  final _formKey = GlobalKey<FormState>();
  final _cardFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _cardFocusNode.addListener(() {
      if (!_cardFocusNode.hasFocus) {
        setState(() => showForm = false);
      }
    });
  }

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
          setState(() => isTitleEmpty = true);
        } else if (value.isNotEmpty) {
          setState(() => isTitleEmpty = false);
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

  Widget _buildAddCardBtn() {
    return TextButton(
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
    );
  }

  Widget _buildButtonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        OutlinedCancelButton(handler: _toggleShowForm),
        SizedBox(width: getProportionateHeight(15)),
        OutlinedSuccessButton(
          isFieldEmpty: isTitleEmpty,
          btnText: 'Add Card',
          handler: _createCard,
        )
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
            SizedBox(height: getProportionateHeight(10)),
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
          showForm ? _buildForm() : _buildAddCardBtn(),
        ],
      ),
    );
  }
}
