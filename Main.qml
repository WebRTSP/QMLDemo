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
            if(list.length !== 0) {
                player = connection.player(list[0].uri, video);
            } else {
                player = null;
            }
        }
    }

    Component.onCompleted: {
        connection.open();
    }
}
