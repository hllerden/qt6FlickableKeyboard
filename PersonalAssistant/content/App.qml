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

        // add stackwiew
        StackView {
                id: stackViewMainApp
                initialItem:  mainScreen
                anchors.fill: parent
                Component {id: mainScreen;Screen01 {}}
        }
    }

    InputPanel {
        id: inputPanel
        property bool showKeyboard :  active
        y: showKeyboard ? parent.height - height : parent.height
        Behavior on y {
            NumberAnimation {
                duration: 200
                easing.type: Easing.InOutQuad
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
            {   flickableLogin.anchors.bottomMargin=inputPanel.height; // klavye açıldığında boyutu

                var focusedItem = Qt.inputMethod.focusedItem;
               // var parentPosition = mapToItem(null, 0, 0);
               // console.log("InnerRect'in parent üzerindeki pozisyonu:", parentPosition.x, parentPosition.y);
                //flickableLogin.contentY = focusedItem.y - flickableLogin.height / 2 + focusedItem.height / 2;

                flickableLogin.interactive= true;
                //flickable fokuslanan itemi scroolunda ortalasın diye

                flickableLogin.contentY = (Constants.height-inputPanel.height)-125; // İstediğiniz miktarı ayarlayabilirsiniz
                console.log("Cons-input : ",(Constants.height-inputPanel.height));

                console.log("Klavye aktif.");

                console.log(showKeyboard);
            }
            else if(!showKeyboard)
            {
                flickableLogin.contentY = 0; // İçeriği en üst konuma alır
                flickableLogin.anchors.bottomMargin=0; // klavye açıldığında boyutu
                flickableLogin.interactive= false;
                console.log("Klavye pasif.");

                console.log(showKeyboard);
            }

            /*
            //  BU kod bir sinyal ve connect örneğidir
            showKeyboard ? keyboardActiveChanged(true) : keyboardActiveChanged(false);
            console.log(showKeyboard);
            */
        }
        // function keyboardActiveChanged() {
        //     console.log("Klavye aktif.");
        //     flickableLogin.interactive= true;
        //     flickableLogin.anchors.bottomMargin=inputPanel.height; // klavye açıldığında boyutu
        // }
         //-----------------------------------------------------
    }

}

