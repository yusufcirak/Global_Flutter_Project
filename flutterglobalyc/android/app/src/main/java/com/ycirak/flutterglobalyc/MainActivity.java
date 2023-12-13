package com.ycirak.flutterglobalyc;

import io.flutter.embedding.android.FlutterActivity;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.ycirak.flutterglobalyc/serial";
    private SerialPortUtils serialPortUtils; // SerialPortUtils sınıfını tanımladık
 

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        serialPortUtils = new SerialPortUtils(); // SerialPortUtils sınıfını başlattık
       
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("openSerialPort")) {
                        String path = call.argument("path");
                        String suPath = call.argument("suPath");
                        serialPortUtils.openSerialPort(path, suPath);
                        result.success("Seri port açıldı");
                    } else if (call.method.equals("sendData")) {
                        String data = call.argument("data");
                        serialPortUtils.sendSerialPort(data);
                        result.success("Veri gönderildi");
                    } else if (call.method.equals("closeSerialPort")) {
                        serialPortUtils.closeSerialPort();
                        result.success("Seri port kapandı");
                    } else {
                        result.notImplemented();
                    }
                }
            );
    }
}
