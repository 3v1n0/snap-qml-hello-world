import QtQuick 2.1
import QtQuick.Window 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.1

Window
{
  id: main
  width: 600
  height: 400
  readonly property var defaultImports: 'import QtQuick 2.1;'

  RowLayout
  {
    spacing: 10
    anchors.fill: parent
    anchors.margins: spacing

    TextArea
    {
      property var dynObj
      text: 'Rectangle {color: "#41cd52"; anchors.fill: parent\n'+
            '  Text { text: "Hello QML"; anchors.centerIn: parent\n' +
            '         font.pixelSize: parent.width / 5 }'+
            '}'
      Layout.fillWidth: true
      Layout.minimumHeight: parent.height
      Layout.maximumHeight: Layout.minimumHeight

      onTextChanged: {
        var obj = Qt.createQmlObject(defaultImports+text, canvas, "dynamicObject");

        if (obj)
        {
          if (dynObj)
            dynObj.destroy()

          dynObj = obj
        }
      }
    }

    Item
    {
      id: canvas

      Layout.minimumWidth: main.width/2 //- separator.width/2
      Layout.maximumWidth: Layout.minimumWidth
      Layout.minimumHeight: parent.height
      Layout.maximumHeight: Layout.minimumHeight
    }
  }
}
