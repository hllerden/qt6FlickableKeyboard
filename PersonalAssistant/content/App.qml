// Copyright (C) 2021 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick 6.2
import PersonalAssistant
import QtQuick.VirtualKeyboard 6.2
//import QtQuick.VirtualKeyboard.Settings
import QtQuick.Controls // ekleyince stackView ve Scroolbar hatası gitti

Window {
    width: Constants.width
    height: Constants.height
    maximumHeight: Constants.height
    minimumHeight: Constants.height
    maximumWidth: Constants.width
    minimumWidth: Constants.width
    visible: true
    title: "PersonalAssistant"
    onActiveFocusItemChanged: print("activeFocusItem", activeFocusItem)

/*
    Screen01 {
        id: mainScreen
    }*/

    Flickable {
        id: flickableLogin
        anchors.fill: parent
        anchors.bottomMargin: 0 // klavye açıldığında boyutu
        contentHeight: parent.height// * 0.9
        contentY: 0
        anchors.topMargin: 0

        contentWidth: parent.width
        interactive: false // ne zaman true olacağı
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds // StopAtBounds özelliğini etkinleştir

        property real scrollMarginVertical: 20

        ScrollBar.vertical: ScrollBar {}

        MouseArea {
            id: mauseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked:
            {

                focus=true
            }

        // add stackwiew
        StackView {
                id: stackViewMainApp
                initialItem:  mainScreen
                anchors.fill: parent
                Component {id: mainScreen;Screen01 {}}
        }
        }
        Behavior on contentY {
                       NumberAnimation {
                           duration: 150
                           easing.type: Easing.InOutQuad
                       }
                   }
    }

    InputPanel {
        id: inputPanel
        property bool showKeyboard :  active
        y: showKeyboard ? parent.height - height : parent.height
        Behavior on y {
            NumberAnimation {
                duration: 150
                easing.type: Easing.InOutQuad
            }
        }
        Timer { // flicker'ın Kapanışında oluşan titremeyi engellemek için eklendi.
                   id: delayKeyBoardFlicker
                   interval: 150 // 2000 milisaniye (2 saniye) gecikme
                   onTriggered: {
                       // Gecikme sona erdiğinde gerçekleşecek işlemler
                       flickableLogin.anchors.bottomMargin=0; // klavye açıldığında boyutu

                   }
               }
        //anchors.leftMargin: Constants.height/10
        //anchors.rightMargin: Constants.width/10
        anchors.left: parent.left
        anchors.right: parent.right
        onShowKeyboardChanged:
        {
            // showKeyboard ? keyboardActiveChanged(true) : keyboardActiveChanged(false);
            if(showKeyboard)
            {   console.log(mauseArea.mouseY)

                flickableLogin.anchors.bottomMargin=inputPanel.height; // klavye açıldığında boyutu
                flickableLogin.interactive= true;
                //flickableLogin.contentY = (Constants.height-inputPanel.height); // İstediğiniz miktarı ayarlayabilirsiniz
                //flickableLogin.contentY=activeFocusItem.y;
                //flickableLogin.contentY=(activeFocusItem.y<(Constants.height-inputPanel.height)/2) ? 0: 0;
               // console.log("Cons-input : ",(Constants.height-inputPanel.height));
                //flickableLogin.contentY = Math.max(0, activeFocusItem.y - ((flickableLogin.height-inputPanel.height) - activeFocusItem.height) / 2);
                //flickableLogin.contentY = Math.max(0, Math.min(activeFocusItem.y - (flickableLogin.height - activeFocusItem.height) / 2,  Constants.height-(flickableLogin.height - inputPanel.height)));
                //flickableLogin.contentY = Math.max(0, Math.min(activeFocusItem.y - (flickableLogin.height - activeFocusItem.height) / 2, Constants.height - flickableLogin.height + inputPanel.height));
                flickableLogin.contentY = Math.max(0, Math.min(activeFocusItem.y - (flickableLogin.height - activeFocusItem.height) / 2, Constants.height - flickableLogin.height));

                // Eğer klavye açıldığında sayfanın altı ekrandan taşıyorsa, sayfayı yukarı kaydır
                if (flickableLogin.height + flickableLogin.contentY > Constants.height) {
                    flickableLogin.contentY = Constants.height - flickableLogin.height;
                }

                console.log("Klavye aktif.");
                console.log(showKeyboard);
            }
            else if(!showKeyboard)
            {
                flickableLogin.interactive= false;
                //flickableLogin.anchors.bottomMargin=0; // klavye açıldığında boyutu

                flickableLogin.contentY = 0; // İçeriği en üst konuma alır
                delayKeyBoardFlicker.start(); // Timer'ı başlat ve gecikmeyi başlat

                console.log("Klavye pasif.");

                console.log(showKeyboard);
            }
        }
        // function keyboardActiveChanged() {
        //     console.log("Klavye aktif.");
        //     flickableLogin.interactive= true;
        //     flickableLogin.anchors.bottomMargin=inputPanel.height; // klavye açıldığında boyutu
        // }
         //-----------------------------------------------------
    }

}

