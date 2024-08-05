import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../apis/user_apis.dart';
import '../../main.dart';
import '../../models/user_model.dart';
import '../home_screen.dart';

// ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
// ┃                                                                            ┃
// ┃                             기본정보 입력 화면                             ┃
// ┃                                                                            ┃
// ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
class InfoInsertScreen extends StatefulWidget {
  const InfoInsertScreen({super.key});

  @override
  State<InfoInsertScreen> createState() => _InfoInsertScreenState();
}

class _InfoInsertScreenState extends State<InfoInsertScreen> {
  // 성별 선택
  int _selectedGender = 0;

  // 생일 선택
  DateTime _selectedDate = DateTime.now();

  // ios 날짜 선택 UI
  void _showCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return SizedBox(
            height: MediaQuery
                .of(context)
                .copyWith()
                .size
                .height / 3,
            child: CupertinoDatePicker(
              initialDateTime: _selectedDate,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
          );
        });
  }

  // 라디오 버튼 UI
  Widget _buildCustomRadioButton(int value, String text, String gender) {
    bool isSelected = _selectedGender == value;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedGender = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: isSelected
              ? gender == 'M'
              ? Colors.blue
              : Colors.pink
              : Colors.grey[200],
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: isSelected ? Colors.blue : Colors.grey),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃  HomeScreen 이동 페이지 Blur ROUTE   ┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  Route _moveHomeRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0 * animation.value,
                sigmaY: 10.0 * animation.value,
              ),
              child: Container(
                color: Colors.black.withOpacity(0.1 * animation.value),
              ),
            ),
            FadeTransition(
              opacity: animation,
              child: child,
            ),
          ],
        );
      },
    );
  }

  // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆화면★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┃★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆★☆┃
  // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(56, 56, 60, 1), // LoginScreen backgroundColor
        // ┏━━━━━━━━┓
        // ┃  Body  ┃
        // ┗━━━━━━━━┛
        body: SizedBox(
          width: mq.width,
          height: mq.height,
          // 화면 요소
          child: Column(
            children: [
              // 타이틀 위쪽 여백
              SizedBox(
                width: mq.width,
                height: mq.height * .2,
              ),
              // 타이틀 박스
              SizedBox(
                height: mq.height * .1,
                child: const Text(
                  "사용자 정보 입력 화면",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
              // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
              // ┃  Body - 성별 선택 RADIO   ┃
              // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
              SizedBox(
                height: mq.height * .05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildCustomRadioButton(0, '남자', 'M'),
                    const SizedBox(width: 10),
                    _buildCustomRadioButton(1, '여자', 'G'),
                  ],
                ),
              ),
              // ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
              // ┃  Body - 생일 선택         ┃
              // ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
              SizedBox(
                height: mq.height * .15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => _showCupertinoDatePicker(context),

                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Text(
                          'Select Date',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Selected Date: ${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                      style: const TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ],
                ),
              ),
              // ┏━━━━━━━━━━━━━━━━━━━━━┓
              // ┃  Body - 저장 버튼   ┃
              // ┗━━━━━━━━━━━━━━━━━━━━━┛
              SizedBox(
                  width: mq.width * 0.9,
                  height: mq.height * 0.06,
                  child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Btn-BackgroundColor
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))), // Btn-Shape
                      ),
                      onPressed: () async {
                        final birthDay = _selectedDate.millisecondsSinceEpoch.toString();
                        ModuUser user = ModuUser(
                            image: '',
                            gender: _selectedGender == 0 ? 'M' : 'G',
                            name: '',
                            birthDay: birthDay,
                            createdAt: '',
                            id: '',
                            email: '',
                            isDefaultInfoSet: true,
                            pushToken: '',
                            partnerId: '',
                        );

                        await UserAPIs.updateUserDefaultInfo(user);
                        Navigator.pushReplacement(context, _moveHomeRoute());
                      },
                      // LoginBtn-Element
                      label: RichText(
                        text: const TextSpan(style: TextStyle(color: Colors.black, fontSize: 16), children: [
                          TextSpan(text: '저장 '),
                        ]),
                      )))
            ],
          ),
        ));
  }
}
