

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick 6.2
import QtQuick.Controls 6.2
import PersonalAssistant

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height

    color: Constants.backgroundColor

    Button {
        id: button
        text: qsTr("Press me")
        anchors.verticalCenter: parent.verticalCenter
        checkable: true
        anchors.horizontalCenter: parent.horizontalCenter

        Connections {
            target: button
            onClicked: animation.start()
        }
    }

    Text {
        id: label
        text: "Focused Item: " + (Item.activeFocusItem ? Item.activeFocusItem.toString(
                                                             ) : "None")

        //text: qsTr("Hello PersonalAssistant")
        anchors.top: button.bottom
        font.family: Constants.font.family
        anchors.topMargin: 45
        anchors.horizontalCenter: parent.horizontalCenter

        SequentialAnimation {
            id: animation

            ColorAnimation {
                id: colorAnimation1
                target: rectangle
                property: "color"
                to: "#2294c6"
                from: Constants.backgroundColor
            }

            ColorAnimation {
                id: colorAnimation2
                target: rectangle
                property: "color"
                to: Constants.backgroundColor
                from: "#2294c6"
            }
        }
    }

    TextInput {
        id: textInput
        x: 212
        y: 8
        width: 89
        height: 46
        text: qsTr("Text Input1")
        font.pixelSize: 16
    }

    TextInput {
        id: textInput1
        x: 212
        y: 60
        width: 89
        height: 49
        text: qsTr("Text Input2")
        font.pixelSize: 16
    }

    TextInput {
        id: textInput2
        x: 212
        y: 115
        width: 89
        height: 49
        text: qsTr("Text Input3")
        font.pixelSize: 16
    }

    TextInput {
        id: textInput3
        x: 212
        y: 170
        width: 89
        height: 49
        text: qsTr("Text Input4")
        font.pixelSize: 16
    }

    TextInput {
        id: textInput4
        x: 212
        y: 225
        width: 89
        height: 49
        text: qsTr("Text Input5")
        font.pixelSize: 16
    }

    TextInput {
        id: textInput5
        x: 212
        y: 280
        width: 89
        height: 49
        text: qsTr("Text Input6")
        font.pixelSize: 16
    }

    TextInput {
        id: textInput6
        x: 212
        y: 338
        width: 89
        height: 49
        text: qsTr("Text Input7")
        font.pixelSize: 16
    }

    TextInput {
        id: textInput7
        x: 212
        y: 393
        width: 89
        height: 49
        text: qsTr("Text Input8")
        font.pixelSize: 16
    }

    TextInput {
        id: textInput8
        x: 212
        y: 448
        width: 89
        height: 49
        text: qsTr("Text Inp9")
        font.pixelSize: 16
    }

    TextInput {
        id: textInput9
        x: 212
        y: 503
        width: 89
        height: 49
        text: qsTr("Text Input10")
        font.pixelSize: 16
    }

    TextInput {
        id: textInput10
        x: 212
        y: 558
        width: 89
        height: 34
        text: qsTr("Text Input11")
        font.pixelSize: 16
    }
    states: [
        State {
            name: "clicked"
            when: button.checked

            PropertyChanges {
                target: label
                text: qsTr("Button Checked")
            }
        }
    ]
}
