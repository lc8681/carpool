import 'package:flutter/material.dart';
import 'package:flutter_grab/common/common.dart';
import 'package:flutter_grab/common/theme.dart';
import 'package:flutter_grab/common/utils.dart';
import 'package:flutter_grab/manager/beans.dart';
import 'package:flutter_grab/pages/detail.dart';

const Color c1 = Color(0xFF222222);
const Color c2 = Color(0xFF444444);
const Color c3 = Color(0xFFD8D8D8);

final TextStyle fontPhone =
    const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: c1);

final TextStyle fontInfo = const TextStyle(fontSize: 16.0, color: c2);

final TextStyle fontTime1 = const TextStyle(fontSize: 16.0, color: c3);
final TextStyle fontTime2 = const TextStyle(fontSize: 16.0, color: colorPick);

final TextStyle fontCall =
    TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.w500);

class ItemView2 extends StatelessWidget {
  final Event event;
  final int index;
  final int type;

  ItemView2(this.event, this.index, this.type);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey[400], width: 0.5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200],
                blurRadius: 10.0,
//                  spreadRadius: 1.0,
              )
            ]),
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: event.remark != null && event.remark.isNotEmpty
              ? <Widget>[
                  _getHeader(),
                  _getPadding(),
                  _getPickup(),
                  _getPadding(),
                  _getDropoff(),
                  _getPadding(),
                  _getDateTime(),
                  _getPadding(),
                  _getRemark(),
                ]
              : <Widget>[
                  _getHeader(),
                  _getPadding(),
                  _getPickup(),
                  _getPadding(),
                  _getDropoff(),
                  _getPadding(),
                  _getDateTime(),
                ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(event.phone, event.start,
                  event.end, event.remark, event.time)),
        );
      },
    );
  }

  _getPadding() => SizedBox(height: 8);

  /// 第一行: 头像, 电话, Action
  _getHeader() {
    var phone = event.phone;
    if (phone.length > 7) {
      phone = phone.replaceRange(3, 7, "****");
    }

    return Row(
      children: <Widget>[
        _getAvatar(), //头像
        SizedBox(width: 8),
        Expanded(
          child: Text(
            phone,
            style: fontPhone,
          ),
          flex: 2,
        ), //电话
        _getAction(), //打电话
//        _getAvatar(),
      ],
    );
  }

  ///起点
  _getPickup() =>
      _getInfoView(Icons.trip_origin, colorPick, event.start, fontInfo);

  ///终点
  _getDropoff() =>
      _getInfoView(Icons.trip_origin, colorDrop, event.end, fontInfo);

  ///出发时间
  _getDateTime() {
    final dt = new DateTime.fromMillisecondsSinceEpoch(event.time);
//    return _getInfoView(Icons.access_time, Color(0xFFC7C7C7),
//        new DateFormat("HH:mm  y年M月d日").format(dt), fontTime1);
    var date = dateFormat.format(dt);
    var time = timeFormat.format(dt);
    return Row(
      children: <Widget>[
        Icon(
          Icons.access_time,
          color: c3,
          size: 14.0,
        ),
        SizedBox(width: 6),
        Text(
          date,
          style: fontTime1,
          textAlign: TextAlign.left,
        ),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            time,
            style: fontTime2,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  ///公用ICON + TEXT
  _getInfoView(IconData icon, Color color, String info, TextStyle style) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: color,
          size: 14.0,
        ),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            info ?? "info",
            style: style,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  ///备注
  _getRemark() => Text(event.remark ?? "remark", style: fontX);

  ///头像
  _getAvatar() {
    return getRoundIcon(getIcon(type));
  }

  ///打电话
  _getAction() {
    return InkWell(
      onTap: () {
        launchcaller('tel:' + event.phone);
      },
      child: getRoundIcon(Icons.call),
    );
  }
}
