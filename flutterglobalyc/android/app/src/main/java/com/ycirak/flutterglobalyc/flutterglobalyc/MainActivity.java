package com.ycirak.flutterglobalyc.flutterglobalyc;

import android.util.Log;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import android_serialport_api.SerialPort;
import android_serialport_api.SerialPortFinder;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "serial_port_channel";
    private SerialPort serialPort;
    private OutputStream outputStream;
    private InputStream inputStream;
    private ReadThread readThread;

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            switch (call.method) {
                                case "openSerialPort":
                                    openSerialPort();
                                    result.success("Seri port açıldı");
                                    break;
                                case "sendData":
                                    String hexData = call.argument("data");
                                    sendData(hexData);
                                    result.success("Veri gönderildi");
                                    break;
                                case "closeSerialPort":
                                    closeSerialPort();
                                    result.success("Seri port kapatıldı");
                                    break;
                                case "readData":
                                    String data = readSerialData();
                                    result.success(data);
                                    break;
                                default:
                                    result.notImplemented();
                            }
                        }
                );
    }

    private void openSerialPort() {
        SerialPortFinder serialPortFinder = new SerialPortFinder();
        String[] allDevicesPath = serialPortFinder.getAllDevicesPath();

        for (String devicePath : allDevicesPath) {
            try {
                int baudRate = 115200;
                serialPort = new SerialPort(new File(devicePath), baudRate, 0);

                outputStream = serialPort.getOutputStream();
                inputStream = serialPort.getInputStream();

                readThread = new ReadThread();
                readThread.start();

                break; // Serial port found and opened
            } catch (SecurityException | IOException e) {
                e.printStackTrace();
                // Handle exceptions
            }
        }
    }

    private void sendData(String hexData) {
        try {
            if (outputStream != null) {
                byte[] byteData = hexStringToByteArray(hexData);
                outputStream.write(byteData);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private String readSerialData() {
        if (inputStream == null) {
            Log.e("MainActivity", "inputStream is null");
            return ""; 
        }
        byte[] buffer = new byte[1024];
        int size;
        try {
            size = inputStream.read(buffer);
            if (size > 0) {
                return new String(buffer, 0, size);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "";
    }

    private void closeSerialPort() {
        if (serialPort != null) {
            serialPort.close();
        }
        if (readThread != null) {
            readThread.interrupt();
        }
    }

    private byte[] hexStringToByteArray(String hex) {
        int len = hex.length();
        byte[] data = new byte[len / 2];
        for (int i = 0; i < len; i += 2) {
            data[i / 2] = (byte) ((Character.digit(hex.charAt(i), 16) << 4)
                    + Character.digit(hex.charAt(i + 1), 16));
        }
        return data;
    }

    private class ReadThread extends Thread {
        @Override
        public void run() {
            byte[] buffer = new byte[1024];
            int size;

            while (!isInterrupted()) {
                try {
                    size = inputStream.read(buffer);
                    if (size > 0) {
                        Log.d("SerialPortData", new String(buffer, 0, size));
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
