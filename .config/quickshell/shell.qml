import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower

ShellRoot {
    QtObject {
        id: c
        readonly property color bg:     "#1a1b26"
        readonly property color fg:     "#c0caf5"
        readonly property color dim:    "#565f89"
        readonly property color accent: "#7aa2f7"
        readonly property color urgent: "#f7768e"
        readonly property color good:   "#9ece6a"
        readonly property color warn:   "#e0af68"
        readonly property string font:  "Iosevka Nerd Font Mono"
    }

    SystemClock { id: clock; precision: SystemClock.Minutes }

    // array of {index, is_active, is_urgent, layout, client_count}
    property var tags: []

    Process {
        command: ["mmsg", "watch", "all-tags"]
        running: true
        stdout: SplitParser {
            onRead: line => {
                try {
                    const data = JSON.parse(line)
                    const mon = data.all_tags[0]   // single monitor
                    if (mon) tags = mon.tags
                } catch (e) {
                    console.log("parse error:", e)
                }
            }
        }
    }

    PanelWindow {
        anchors { top: true; left: true; right: true }
        implicitHeight: 30
        color: c.bg

        // tags, left
        Row {
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
            spacing: 4

            Repeater {
                model: 4
                Rectangle {
                    required property int index
                    readonly property var t: tags[index] || null
                    readonly property bool sel: t ? t.is_active : false
                    readonly property bool urg: t ? t.is_urgent : false
                    readonly property bool occ: t ? t.client_count > 0 : false

                    width: 24; height: 22; radius: 4
                    color: sel ? c.accent : (urg ? c.urgent : c.bg)

                    Text {
                        anchors.centerIn: parent
                        text: index + 1
                        font.family: c.font
                        font.pixelSize: 18
                        font.bold: parent.sel
                        color: parent.sel ? c.bg : (parent.occ ? c.fg : c.dim)
                    }
                }
            }
        }

        Text {
            id: dateText
            anchors.right: parent.right
            anchors.rightMargin: 20
            text: Qt.formatDateTime(clock.date, "dddd, MMMM d  hh:mm ap")
            color: c.fg
            font.family: c.font
            font.pixelSize: 18
        }

        // battery, right next to the date
        Text {
            anchors.left: dateText.left
            anchors.leftMargin: -50
            anchors.verticalCenter: dateText.verticalCenter
            readonly property var bat: UPower.displayDevice
            readonly property int pct: bat ? Math.round(bat.percentage * 100) : 0
            visible: bat && bat.isPresent
            text: (bat && bat.state === UPowerDeviceState.Charging ? "󰂄 " : "󰁹 ") + pct + "%"
            color: pct <= 15 ? c.urgent : (pct <= 30 ? c.warn : c.good)
            font.family: c.font
            font.pixelSize: 14
        }
    }
}
