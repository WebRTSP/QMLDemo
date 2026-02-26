import QtQuick
import org.webrtsp.client 0.1
import org.freedesktop.gstreamer.Qt6GLVideoItem 1.0

Window {
    width: 800
    height: 600
    visible: true

    WebRTSPConnection {
        id: connection
        serverUrl: "wss://ipcam.stream:5555/"
        authToken: "token"
        stunServerUrl: "stun://global.stun.twilio.com"
    }
    GstGLQt6VideoItem {
        id: video
        anchors.fill: parent
    }
    property WebRTSPPlayer player

    property WebRTSPUriInfo rootInfo: connection.uriInfo("*")
    Connections {
        target: rootInfo
        function onListChanged(list) {
            console.log("list changed:", list);
            playNext();
        }
    }

    property int activeItem: -1
    function playNext() {
        if(player) {
            player.destroy();
            player = null;
        }

        const list = rootInfo.list;

        timer.running = list.length > 0;

        if(list.length !== 0) {
            ++activeItem;
            if(activeItem >= list.length) {
                activeItem = 0;
            }

            player = connection.player(list[activeItem].uri, video);
        }
    }

    Timer {
        id: timer
        interval: 10000;
        running: false;
        repeat: true
        onTriggered: {
            playNext();
        }
    }

    Component.onCompleted: {
        connection.open();
    }
}
