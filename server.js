const WebSocket = require("ws");

// Khởi tạo WebSocket server trên cổng 8080
const wss = new WebSocket.Server({ port: 8080 });

wss.on("connection", (ws) => {
  console.log("🔗 Client đã kết nối!");

  ws.on("message", (message) => {
    console.log("📩 Nhận tin nhắn: ", message);

    // 📌 Gửi tin nhắn đến tất cả client (bao gồm người gửi)
    wss.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(message);
      }
    });
  });

  ws.on("close", () => {
    console.log("🔌 Client đã ngắt kết nối.");
  });
});

console.log("✅ WebSocket Server đang chạy trên cổng 8080");
