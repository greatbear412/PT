import 'dart:ui';
import 'package:flutter/material.dart';

import '../states/target.dart';
import '../common/util.dart';
import '../components/text.dart';
import '../common/constant.dart';

class Finish extends StatefulWidget {
  final Target target;
  Finish({this.target});

  @override
  _FinishState createState() => new _FinishState();
}

class _FinishState extends State<Finish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: Utils.getScreenHeight(context),
            color: Utils.transStr('d2d2d2'),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    margin: const EdgeInsets.only(top: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                          style: TextStyle(),
                          child: Row(
                            children: [
                              DefaultText(
                                text: '从 ',
                              ),
                              KeyText(
                                text: Utils.getFormatDate(
                                    widget.target.startTime),
                              ),
                              DefaultText(
                                text: ' 开始，',
                              )
                            ],
                          ),
                        ),
                        DefaultTextStyle(
                          style: TextStyle(),
                          child: Row(
                            children: [
                              DefaultText(
                                text: '到目前为止，已经过去了 ',
                              ),
                              KeyText(
                                text:
                                    Utils.getPassedDate(widget.target.startTime)
                                        .toString(),
                              ),
                              DefaultText(
                                text: ' 天，',
                              )
                            ],
                          ),
                        ),
                        DefaultText(
                          text: '你兑现了自己的诺言，',
                        ),
                        DefaultTextStyle(
                          style: TextStyle(),
                          child: Row(
                            children: [
                              DefaultText(
                                text: '完成了 ',
                              ),
                              KeyText(
                                text: widget.target.finishHistory.length
                                    .toString(),
                              ),
                              DefaultText(
                                text: ' 次：',
                              ),
                            ],
                          ),
                        ),
                        KeyText(
                          text: widget.target.title,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  StyleText(
                    '"乘风破浪会有时，直挂云帆济沧海"',
                    TextStyle(
                      color: Utils.transStr('494949'),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    align: TextAlign.start,
                  ),
                  SizedBox(height: 20),
                  Image(
                      image: AssetImage('imgs/finish.webp'),
                      repeat: ImageRepeat.noRepeat,
                      width: Utils.getScreenWidth(context) * 0.6)
                ],
              ),
            )));
  }
}

class DefaultText extends StatelessWidget {
  final String text;
  DefaultText({this.text});
  @override
  Widget build(BuildContext context) {
    return StyleText(
      text,
      TextStyle(
        color: Utils.transStr('656565'),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      lines: 1,
    );
  }
}

class KeyText extends StatelessWidget {
  final String text;
  KeyText({this.text});
  @override
  Widget build(BuildContext context) {
    return StyleText(
      text,
      TextStyle(
        color: Utils.transStr('000'),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      lines: 1,
    );
  }
}
